import UIKit

final class AuthorizationView: UIView {
    
    private let greenColor = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1.0)
    private let darkGrayColor = UIColor(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)
    private let lightGrayColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1.0)
    
    private let background = UIImageView()
    let anonymousButton = UIButton()
    private let segmentedControl = UISegmentedControl(items: ["Log In", "Registration"])
    
    private let logInView = UIView()
    private let registrationView = UIView()
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    let nameTextField = UITextField()
    let regEmailTextField = UITextField()
    let regPasswordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let registrationButton = UIButton()
    
    var onSegmentChange: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setupBackground()
        setupSegmentedControl()
        setupAuthViews()
        setupAnonymousButton()
    }
    
    private func setupBackground() {
        background.image = UIImage(resource: .background)
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        addSubview(background)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupAnonymousButton() {
        anonymousButton.setBackgroundImage(UIImage(resource: .anonimous), for: .normal)
        anonymousButton.contentMode = .scaleAspectFit
        anonymousButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(anonymousButton)
        
        NSLayoutConstraint.activate([
            anonymousButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            anonymousButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            anonymousButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            anonymousButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentTintColor = greenColor
        
        segmentedControl.layer.borderWidth = 2.0
        segmentedControl.layer.borderColor = greenColor.cgColor
        segmentedControl.layer.cornerRadius = 25
        segmentedControl.layer.masksToBounds = true
        
        segmentedControl.clipsToBounds = true
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: greenColor,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    private func setupAuthViews() {
        setupLogInView()
        setupRegistrationView()
        
        updateViewVisibility()
    }
    
    private func setupLogInView() {
        logInView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logInView)
        
        NSLayoutConstraint.activate([
            logInView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logInView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logInView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            logInView.heightAnchor.constraint(equalToConstant: 475)
        ])
        
        let loginLabel = UILabel()
        loginLabel.text = "Log In"
        loginLabel.textColor = greenColor
        loginLabel.font = UIFont.boldSystemFont(ofSize: 40)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        logInView.addSubview(loginLabel)
        
        configureTextField(emailTextField, placeholder: "Email:")
        logInView.addSubview(emailTextField)
        
        configureTextField(passwordTextField, placeholder: "Password:", isSecure: true)
        logInView.addSubview(passwordTextField)
        
        loginButton.setBackgroundImage(UIImage(resource: .logIn), for: .normal)
        loginButton.contentMode = .scaleAspectFit
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        logInView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: logInView.topAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: logInView.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: logInView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: logInView.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: logInView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: logInView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: logInView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: logInView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupRegistrationView() {
        registrationView.translatesAutoresizingMaskIntoConstraints = false
        registrationView.isHidden = true
        addSubview(registrationView)
        
        NSLayoutConstraint.activate([
            registrationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            registrationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            registrationView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            registrationView.heightAnchor.constraint(equalToConstant: 475)
        ])
        
        let registrationLabel = UILabel()
        registrationLabel.text = "Registration"
        registrationLabel.textColor = greenColor
        registrationLabel.font = UIFont.boldSystemFont(ofSize: 40)
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        registrationView.addSubview(registrationLabel)
        
        configureTextField(nameTextField, placeholder: "Name:")
        registrationView.addSubview(nameTextField)
        
        configureTextField(regEmailTextField, placeholder: "Email:")
        registrationView.addSubview(regEmailTextField)
        
        configureTextField(regPasswordTextField, placeholder: "Password:", isSecure: true)
        registrationView.addSubview(regPasswordTextField)
        
        configureTextField(confirmPasswordTextField, placeholder: "Confirm Password:", isSecure: true)
        registrationView.addSubview(confirmPasswordTextField)
        
        registrationButton.setBackgroundImage(UIImage(resource: .registration), for: .normal)
        registrationButton.contentMode = .scaleAspectFit
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationView.addSubview(registrationButton)
        
        NSLayoutConstraint.activate([
            registrationLabel.topAnchor.constraint(equalTo: registrationView.topAnchor, constant: 20),
            registrationLabel.centerXAnchor.constraint(equalTo: registrationView.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            regEmailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            regEmailTextField.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor),
            regEmailTextField.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor),
            regEmailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            regPasswordTextField.topAnchor.constraint(equalTo: regEmailTextField.bottomAnchor, constant: 5),
            regPasswordTextField.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor),
            regPasswordTextField.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor),
            regPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: regPasswordTextField.bottomAnchor, constant: 5),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            registrationButton.leadingAnchor.constraint(equalTo: registrationView.leadingAnchor),
            registrationButton.trailingAnchor.constraint(equalTo: registrationView.trailingAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.backgroundColor = darkGrayColor
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: lightGrayColor]
        )
        textField.textColor = lightGrayColor
        textField.layer.cornerRadius = 20
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func segmentedControlValueChanged() {
        updateViewVisibility()
        onSegmentChange?()
    }
    
    func updateViewVisibility() {
        if segmentedControl.selectedSegmentIndex == 0 {
            logInView.isHidden = false
            registrationView.isHidden = true
        } else {
            logInView.isHidden = true
            registrationView.isHidden = false
        }
    }
    
    func getSelectedSegmentIndex() -> Int {
        return segmentedControl.selectedSegmentIndex
    }
} 
