import UIKit

final class WelcomeView: UIView {
    
    private var background = UIImageView()
    private(set) var logInButton = UIButton()
    private var welcomeLabel = UILabel()
    private var gorillaImageView = UIImageView()
    
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
        setupLogInButton()
        setupWelcomeLabel()
        setupGorillaImage()
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
    
    private func setupLogInButton() {
        logInButton.setBackgroundImage(UIImage(resource: .logIn), for: .normal)
        logInButton.contentMode = .scaleAspectFit
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logInButton)
        NSLayoutConstraint.activate([
            logInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            logInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            logInButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            logInButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupWelcomeLabel() {
        welcomeLabel.text = "Welcome"
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1)
        welcomeLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeLabel.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -10)
        ])
    }
    
    private func setupGorillaImage() {
        gorillaImageView.image = UIImage(resource: .gorilla)
        gorillaImageView.contentMode = .scaleAspectFit
        gorillaImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gorillaImageView)
        
        NSLayoutConstraint.activate([
            gorillaImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gorillaImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            gorillaImageView.widthAnchor.constraint(equalToConstant: 361),
            gorillaImageView.heightAnchor.constraint(equalToConstant: 371)
        ])
    }
}
