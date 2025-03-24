
import UIKit
import SwiftUI
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cl = UIColor(named: "cl") ?? .white
        view.backgroundColor = cl

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()

        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func firstOpen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let onboardingScreen = Auth.auth().currentUser != nil ? MainController() : WelcomeController()
//            let hostingController = UIHostingController(rootView: onboardingScreen)
//            self.rootViewC(onboardingScreen)
            
            UIApplication.setRootViewController(onboardingScreen)
        }
    }
    
    func secondOpen(string: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for child in self.children {
                if child is FirstVC {
                    return
                }
            }
            guard !string.isEmpty else { return }
            let secondController = FirstVC(url: string)
            self.addChild(secondController)
            secondController.view.frame = self.view.bounds
            secondController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(secondController.view)
            secondController.didMove(toParent: self)
        }
    }

    
    func rootViewC(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
    
    func setupstr(mstring: String, deviid: String, advid: String, appsflif: String) -> (String) {
        var strins = ""
        
        strins = "\(mstring)?qqnn=\(deviid)&aass=\(advid)&ffpo=\(appsflif)"
        
        return strins
    }
}
