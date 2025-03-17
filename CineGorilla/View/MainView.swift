import UIKit

class MainView: UIView {
    
    let background = UIImageView()
    
    let newTicketButton = UIButton()
    let myProfileButton = UIButton()
    let notificationButton = UIButton()
    
    let myTicketIDButton = UIButton()
    let myFavoriteSessionsButton = UIButton()
    let sessionsHistoryButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        setupBackground()
        setupNewTicketButton()
        setupMyProfileButton()
        setupNotificationButton()
        setupMyTicketIDButton()
        setupMyFavoriteSessionsButton()
        setupSessionsHistoryButton()
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
    
    private func setupNewTicketButton() {
        newTicketButton.setBackgroundImage(UIImage(resource: .newTicket), for: .normal)
        newTicketButton.contentMode = .scaleAspectFit
        newTicketButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newTicketButton)
        
        NSLayoutConstraint.activate([
            newTicketButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            newTicketButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            newTicketButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            newTicketButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupMyProfileButton() {
        myProfileButton.setBackgroundImage(UIImage(resource: .myProfile), for: .normal)
        myProfileButton.contentMode = .scaleAspectFit
        myProfileButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myProfileButton)
        
        NSLayoutConstraint.activate([
            myProfileButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            myProfileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myProfileButton.widthAnchor.constraint(equalToConstant: 180),
            myProfileButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupNotificationButton() {
        notificationButton.setBackgroundImage(UIImage(resource: .notificationIMG), for: .normal)
        notificationButton.contentMode = .scaleAspectFit
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(notificationButton)
        
        NSLayoutConstraint.activate([
            notificationButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            notificationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            notificationButton.widthAnchor.constraint(equalToConstant: 60),
            notificationButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupMyTicketIDButton() {
        myTicketIDButton.setBackgroundImage(UIImage(resource: .myTicketID), for: .normal)
        myTicketIDButton.contentMode = .scaleAspectFit
        myTicketIDButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myTicketIDButton)
        
        NSLayoutConstraint.activate([
            myTicketIDButton.widthAnchor.constraint(equalToConstant: 160),
            myTicketIDButton.heightAnchor.constraint(equalToConstant: 160),
            myTicketIDButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            myTicketIDButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -140)
        ])
    }
    
    private func setupMyFavoriteSessionsButton() {
        myFavoriteSessionsButton.setBackgroundImage(UIImage(resource: .myFavoriteSessions), for: .normal)
        myFavoriteSessionsButton.contentMode = .scaleAspectFit
        myFavoriteSessionsButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myFavoriteSessionsButton)
        
        NSLayoutConstraint.activate([
            myFavoriteSessionsButton.widthAnchor.constraint(equalToConstant: 160),
            myFavoriteSessionsButton.heightAnchor.constraint(equalToConstant: 160),
            myFavoriteSessionsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -85),
            myFavoriteSessionsButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
        ])
    }
    
    private func setupSessionsHistoryButton() {
        sessionsHistoryButton.setBackgroundImage(UIImage(resource: .sessionsHistory), for: .normal)
        sessionsHistoryButton.contentMode = .scaleAspectFit
        sessionsHistoryButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sessionsHistoryButton)
        
        NSLayoutConstraint.activate([
            sessionsHistoryButton.widthAnchor.constraint(equalToConstant: 160),
            sessionsHistoryButton.heightAnchor.constraint(equalToConstant: 160),
            sessionsHistoryButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 85),
            sessionsHistoryButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
        ])
    }
} 
