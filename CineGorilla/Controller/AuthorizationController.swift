import UIKit
import FirebaseAuth

class AuthorizationController: UIViewController {
    
    private var authView: AuthorizationView!
    
    override func loadView() {
        authView = AuthorizationView()
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallbacks()
        setupButtonActions()
        setupTextFields()
        setupTapGesture()
    }
    
    private func setupCallbacks() {
        authView.onSegmentChange = { [weak self] in
            self?.handleSegmentChange()
        }
    }
    
    private func setupButtonActions() {
        authView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        authView.registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        authView.anonymousButton.addTarget(self, action: #selector(anonymousButtonTapped), for: .touchUpInside)
    }
    
    private func setupTextFields() {
        authView.emailTextField.autocapitalizationType = .none
        authView.regEmailTextField.autocapitalizationType = .none
        
        authView.emailTextField.delegate = self
        authView.passwordTextField.delegate = self
        
        authView.nameTextField.delegate = self
        authView.regEmailTextField.delegate = self
        authView.regPasswordTextField.delegate = self
        authView.confirmPasswordTextField.delegate = self
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func loginButtonTapped() {
        guard let email = authView.emailTextField.text, !email.isEmpty,
              let password = authView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in all fields")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(message: "Login error: \(error.localizedDescription)")
                return
            }
            
            UIApplication.setRootViewController(MainController())
        }
    }
    
    @objc private func registrationButtonTapped() {
        guard let name = authView.nameTextField.text, !name.isEmpty,
              let email = authView.regEmailTextField.text, !email.isEmpty,
              let password = authView.regPasswordTextField.text, !password.isEmpty,
              let confirmPassword = authView.confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please fill in all fields")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(message: "Registration error: \(error.localizedDescription)")
                return
            }
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("Profile update error: \(error.localizedDescription)")
                }
            }
            
            UIApplication.setRootViewController(MainController())
        }
    }
    
    @objc private func anonymousButtonTapped() {
        UIApplication.setRootViewController(MainController())
    }
    
    private func handleSegmentChange() {
        authView.updateViewVisibility()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension AuthorizationController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == authView.emailTextField {
            authView.passwordTextField.becomeFirstResponder()
        } else if textField == authView.passwordTextField {
            textField.resignFirstResponder()
        } else if textField == authView.nameTextField {
            authView.regEmailTextField.becomeFirstResponder()
        } else if textField == authView.regEmailTextField {
            authView.regPasswordTextField.becomeFirstResponder()
        } else if textField == authView.regPasswordTextField {
            authView.confirmPasswordTextField.becomeFirstResponder()
        } else if textField == authView.confirmPasswordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
