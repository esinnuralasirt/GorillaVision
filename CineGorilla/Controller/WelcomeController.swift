import UIKit

final class WelcomeController: UIViewController {
    
    private let welcomeView = WelcomeView()
    
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        welcomeView.logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logInButtonTapped() {
            navigateToNextScreen()
        }
        
        func navigateToNextScreen() {
            UIApplication.setRootViewController(AuthorizationController())
        }
}
