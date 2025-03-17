import UIKit
import FirebaseAuth

class MainController: UIViewController {
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        mainView.newTicketButton.addTarget(self, action: #selector(newTicketTapped), for: .touchUpInside)
        mainView.myProfileButton.addTarget(self, action: #selector(myProfileTapped), for: .touchUpInside)
        mainView.notificationButton.addTarget(self, action: #selector(notificationTapped), for: .touchUpInside)
        mainView.myTicketIDButton.addTarget(self, action: #selector(myTicketIDTapped), for: .touchUpInside)
        mainView.myFavoriteSessionsButton.addTarget(self, action: #selector(myFavoriteSessionsTapped), for: .touchUpInside)
        mainView.sessionsHistoryButton.addTarget(self, action: #selector(sessionsHistoryTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func newTicketTapped() {
        UIApplication.setRootViewController(NewTicketController())
    }
    
    @objc private func myProfileTapped() {
        if Auth.auth().currentUser != nil {
            UIApplication.setRootViewController(ProfileController())
        } else {
            UIApplication.setRootViewController(AuthorizationController())
        }
    }
    
    @objc private func notificationTapped() {
        UIApplication.setRootViewController(PushController())
    }
    
    @objc private func myTicketIDTapped() {
        UIApplication.setRootViewController(MyTicketController())
    }
    
    @objc private func myFavoriteSessionsTapped() {
        UIApplication.setRootViewController(FavoriteController())
    }
    
    @objc private func sessionsHistoryTapped() {
        UIApplication.setRootViewController(HistoryController())
    }
}
