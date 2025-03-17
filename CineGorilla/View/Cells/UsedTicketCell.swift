import UIKit

final class UsedTicketCell: UICollectionViewCell {
    // MARK: - UI Elements
    let topBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "top")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bottom")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time:"
        label.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let time: UILabel = {
        let label = UILabel()
        label.text = "19:00-22:00"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let placesLabel: UILabel = {
        let label = UILabel()
        label.text = "Places:"
        label.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let places: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date:"
        label.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.text = "06.03.2025"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Points:"
        label.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let points: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Captain America: Brave New World"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qrcode-1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pointImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .point)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let visitedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .visited)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    func setupUI() {
        setupTicketBackground()
        setupLabels()
    }
    
    func setupTicketBackground() {
        [topBackground, bottomBackground].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            topBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            topBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            topBackground.widthAnchor.constraint(equalToConstant: 310),
            topBackground.heightAnchor.constraint(equalToConstant: 166),
            
            bottomBackground.topAnchor.constraint(equalTo: topBackground.bottomAnchor, constant: 20),
            bottomBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            bottomBackground.widthAnchor.constraint(equalToConstant: 310),
            bottomBackground.heightAnchor.constraint(equalToConstant: 282)
        ])
    }
    
    func setupLabels() {
        [timeLabel, time, placesLabel, places, dateLabel, date, 
         pointsLabel, points, nameLabel, qrImageView, pointImageView, visitedImageView].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            time.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            time.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            placesLabel.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 20),
            placesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            places.topAnchor.constraint(equalTo: placesLabel.bottomAnchor, constant: 10),
            places.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 30),
            
            date.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            date.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            
            pointsLabel.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 20),
            pointsLabel.leadingAnchor.constraint(equalTo: date.leadingAnchor),
            
            points.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 10),
            points.leadingAnchor.constraint(equalTo: pointsLabel.leadingAnchor),
            
            pointImageView.leadingAnchor.constraint(equalTo: points.trailingAnchor, constant: 5),
            pointImageView.centerYAnchor.constraint(equalTo: points.centerYAnchor),
            pointImageView.widthAnchor.constraint(equalToConstant: 20),
            pointImageView.heightAnchor.constraint(equalTo: pointImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: qrImageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: qrImageView.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: qrImageView.widthAnchor),
            
            qrImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80),
            qrImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            qrImageView.widthAnchor.constraint(equalToConstant: 175),
            qrImageView.heightAnchor.constraint(equalTo: qrImageView.widthAnchor),
            
            visitedImageView.centerXAnchor.constraint(equalTo: bottomBackground.centerXAnchor),
            visitedImageView.centerYAnchor.constraint(equalTo: bottomBackground.centerYAnchor, constant: -30),
            visitedImageView.widthAnchor.constraint(equalToConstant: 240),
            visitedImageView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        visitedImageView.layer.zPosition = 999
    }
}

