import UIKit
import FirebaseAuth

final class ProfileController: UIViewController {
    private let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        configureInitialState()
    }
    
    private func setupActions() {
        profileView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        profileView.logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        profileView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    private func configureInitialState() {
        if let user = Auth.auth().currentUser {
            if let displayName = user.displayName, !displayName.isEmpty {
                profileView.nameLabel.text = displayName
            } else {
                profileView.nameLabel.text = "User"
            }
            
            if let email = user.email, !email.isEmpty {
                profileView.emailLabel.text = email
            } else {
                profileView.emailLabel.text = "No email"
            }
        } else {
            UIApplication.setRootViewController(AuthorizationController())
        }
    }
    
    @objc private func backButtonTapped() {
        UIApplication.setRootViewController(MainController())
    }
    
    @objc private func logOutButtonTapped() {
        do {
            try Auth.auth().signOut()
            
            showAlert(message: "You have been successfully logged out") { [weak self] in
                UIApplication.setRootViewController(AuthorizationController())
            }
        } catch {
            showAlert(message: "Error signing out: \(error.localizedDescription)")
        }
    }
    
    @objc private func deleteButtonTapped() {
        let alertController = UIAlertController(
            title: "Delete Account",
            message: "Are you sure you want to delete your account? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            Auth.auth().currentUser?.delete { error in
                if let error = error {
                    self?.showAlert(message: "Error deleting account: \(error.localizedDescription)")
                } else {
                    self?.showAlert(message: "Your account has been successfully deleted") {
                        UIApplication.setRootViewController(AuthorizationController())
                    }
                }
            }
        })
        
        present(alertController, animated: true)
    }
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        
        present(alertController, animated: true)
    }
}


