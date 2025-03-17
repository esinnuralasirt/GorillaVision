import UIKit

final class ProfileView: UIView {
    private var background: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .background)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private(set) var logOutButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(resource: .logOut), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private(set) var deleteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(resource: .deleteAccount), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private(set) var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(resource: .back), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var avatar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .avatar)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        return label
    }()
    
    private(set) var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        [background, logOutButton, deleteButton, backButton, 
         avatar, nameLabel, emailTitleLabel, emailLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            deleteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 70),
            
            logOutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            logOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            logOutButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -20),
            logOutButton.heightAnchor.constraint(equalToConstant: 70),
            
            avatar.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            avatar.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -80),
            avatar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -36),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: avatar.centerYAnchor),
            
            emailTitleLabel.leadingAnchor.constraint(equalTo: avatar.leadingAnchor),
            emailTitleLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 30),
            
            emailLabel.leadingAnchor.constraint(equalTo: emailTitleLabel.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 10),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 96),
            backButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
} 
