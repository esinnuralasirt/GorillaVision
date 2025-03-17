import UIKit

final class CertainTicketView: UIView {
    private var background = UIImageView()
    private(set) var scrollView = UIScrollView()
    private(set) var contentView = UIView()
    private(set) var backButton = UIButton()
    private(set) var bookNowButton = UIButton()
    private(set) var pointImageView = UIImageView()
    private(set) var total = IntLabel()
    private(set) var centerImageView = UIImageView()
    private(set) var filmNameLabel = UILabel()
    private var genreLabel = UILabel()
    private(set) var genre = UILabel()
    private var yearLabel = UILabel()
    private(set) var year = UILabel()
    private var timeLabel = UILabel()
    private(set) var time = UILabel()
    private var dateLabel = UILabel()
    private(set) var date = UILabel()
    private var pointLabel = UILabel()
    private(set) var incrementButton = UIButton()
    private(set) var decrementButton = UIButton()
    private var placesLabel = UILabel()
    private(set) var placesCountString = UILabel()
    private(set) var customAlertView = UIView()
    private(set) var alertLabel = UILabel()
    private(set) var okButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(background)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        addSubview(backButton)
        addSubview(bookNowButton)
        addSubview(customAlertView)
        
        [centerImageView, filmNameLabel, genreLabel, genre, yearLabel, year,
         timeLabel, time, dateLabel, date, placesLabel, incrementButton,
         placesCountString, decrementButton, pointImageView, pointLabel, total].forEach {
            contentView.addSubview($0)
        }
        
        [alertLabel, okButton].forEach {
            customAlertView.addSubview($0)
        }
    }
    
    private func configureUI() {
        background.image = UIImage(resource: .background)
        background.contentMode = .scaleAspectFill
        
        backButton.setBackgroundImage(UIImage(resource: .back), for: .normal)
        backButton.contentMode = .scaleAspectFit
        
        centerImageView.contentMode = .scaleAspectFit
        centerImageView.image = .img1
        
        pointImageView.image = UIImage(resource: .point)
        pointImageView.contentMode = .scaleAspectFit
        
        configureLabels()
        configureButtons()
        configureCustomAlert()
    }
    
    private func configureLabels() {
        filmNameLabel.text = "Captain America: Brave New World"
        filmNameLabel.textColor = .white
        filmNameLabel.font = .boldSystemFont(ofSize: 36)
        filmNameLabel.numberOfLines = 0
        filmNameLabel.textAlignment = .left
        
        let grayColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        let greenColor = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1)
        
        [(genreLabel, "Genre: "), (yearLabel, "Year: "), (timeLabel, "Time: "), (dateLabel, "Date: ")].forEach {
            $0.0.text = $0.1
            $0.0.textColor = grayColor
            $0.0.font = .systemFont(ofSize: 20)
            $0.0.numberOfLines = 1
            $0.0.textAlignment = .left
        }
        
        [(genre, "Adventure, Family"), (year, "2025"), (time, "19:00-22:00"), (date, "15.06.2025")].forEach {
            $0.0.text = $0.1
            $0.0.textColor = .white
            $0.0.font = .systemFont(ofSize: 20)
            $0.0.numberOfLines = 1
            $0.0.textAlignment = .right
        }
        
        placesLabel.text = "Places:"
        placesLabel.textColor = .white
        placesLabel.font = .systemFont(ofSize: 20)
        
        placesCountString.text = "1"
        placesCountString.textColor = greenColor
        placesCountString.font = .systemFont(ofSize: 20)
        placesCountString.textAlignment = .center
        
        pointLabel.text = "Points:"
        pointLabel.textColor = .white
        pointLabel.font = .systemFont(ofSize: 20)
        
        total.textColor = greenColor
        total.font = .systemFont(ofSize: 16)
        total.textAlignment = .right
    }
    
    private func configureButtons() {
        let greenColor = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1)
        
        incrementButton.setTitle("+", for: .normal)
        incrementButton.setTitleColor(greenColor, for: .normal)
        incrementButton.titleLabel?.font = .systemFont(ofSize: 20)
        
        decrementButton.setTitle("-", for: .normal)
        decrementButton.setTitleColor(greenColor, for: .normal)
        decrementButton.titleLabel?.font = .systemFont(ofSize: 20)
        
        bookNowButton.setBackgroundImage(UIImage(resource: .bookNow), for: .normal)
        bookNowButton.contentMode = .scaleAspectFit
    }
    
    private func configureCustomAlert() {
        let greenColor = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1)
        
        customAlertView.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
        customAlertView.layer.cornerRadius = 20
        customAlertView.layer.borderWidth = 2
        customAlertView.layer.borderColor = greenColor.cgColor
        customAlertView.isHidden = true
        
        alertLabel.text = "Your ticket is added"
        alertLabel.textColor = greenColor
        alertLabel.font = .boldSystemFont(ofSize: 24)
        alertLabel.numberOfLines = 2
        alertLabel.textAlignment = .center
        
        okButton.setBackgroundImage(UIImage(resource: .ok), for: .normal)
        okButton.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        [background, scrollView, contentView, backButton, centerImageView, filmNameLabel,
         genreLabel, genre, yearLabel, year, timeLabel, time, dateLabel, date,
         placesLabel, incrementButton, placesCountString, decrementButton,
         pointImageView, pointLabel, total, bookNowButton, customAlertView,
         alertLabel, okButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: heightAnchor, constant: 200),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 96),
            backButton.heightAnchor.constraint(equalToConstant: 64),
            
            centerImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 100),
            centerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            centerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            centerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            filmNameLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10),
            filmNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filmNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            genreLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            genre.centerYAnchor.constraint(equalTo: genreLabel.centerYAnchor),
            genre.leadingAnchor.constraint(greaterThanOrEqualTo: genreLabel.trailingAnchor, constant: 10),
            genre.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            yearLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            yearLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            year.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            year.leadingAnchor.constraint(greaterThanOrEqualTo: yearLabel.trailingAnchor, constant: 10),
            year.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            timeLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 20),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            time.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            time.leadingAnchor.constraint(greaterThanOrEqualTo: timeLabel.trailingAnchor, constant: 10),
            time.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            date.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            date.leadingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor, constant: 10),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            placesLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40),
            placesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            incrementButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40),
            incrementButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            placesCountString.centerYAnchor.constraint(equalTo: incrementButton.centerYAnchor),
            placesCountString.trailingAnchor.constraint(equalTo: incrementButton.leadingAnchor, constant: -5),
            placesCountString.widthAnchor.constraint(equalToConstant: 30),
            
            decrementButton.centerYAnchor.constraint(equalTo: placesCountString.centerYAnchor),
            decrementButton.trailingAnchor.constraint(equalTo: placesCountString.leadingAnchor, constant: -5),
            
            pointImageView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 20),
            pointImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pointImageView.widthAnchor.constraint(equalToConstant: 25),
            pointImageView.heightAnchor.constraint(equalToConstant: 25),
            
            pointLabel.centerYAnchor.constraint(equalTo: pointImageView.centerYAnchor),
            pointLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            total.centerYAnchor.constraint(equalTo: pointImageView.centerYAnchor),
            total.trailingAnchor.constraint(equalTo: pointImageView.leadingAnchor, constant: -5),
            total.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            
            bookNowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bookNowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bookNowButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bookNowButton.heightAnchor.constraint(equalToConstant: 70),
            
            customAlertView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customAlertView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customAlertView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            alertLabel.topAnchor.constraint(equalTo: customAlertView.topAnchor, constant: 10),
            alertLabel.leadingAnchor.constraint(equalTo: customAlertView.leadingAnchor, constant: 20),
            alertLabel.trailingAnchor.constraint(equalTo: customAlertView.trailingAnchor, constant: -20),
            
            okButton.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 20),
            okButton.centerXAnchor.constraint(equalTo: customAlertView.centerXAnchor),
            okButton.bottomAnchor.constraint(equalTo: customAlertView.bottomAnchor, constant: -10),
            okButton.widthAnchor.constraint(equalTo: okButton.heightAnchor, multiplier: 5),
            okButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
} 
