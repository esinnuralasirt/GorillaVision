import UIKit

final class FilmCell: UITableViewCell {
    // MARK: - UI Elements
    let bookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(resource: .book), for: .normal)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(resource: .like), for: .normal)
        return button
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1.0).cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private let filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.3
        return imageView
    }()
    
    var onLikePressed: ((MovieItem) -> Void)?
    private var currentFilm: MovieItem?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup
    func setupUI() {
        setupInitialState()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupInitialState() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(filmImageView)
        [timeLabel, nameLabel, genreLabel, likeButton, bookButton].forEach {
            containerView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2.5),
            
            filmImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            filmImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            filmImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            filmImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: likeButton.leadingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: likeButton.leadingAnchor, constant: -10),
            
            genreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            genreLabel.trailingAnchor.constraint(lessThanOrEqualTo: likeButton.leadingAnchor, constant: -10),
            genreLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            bookButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            bookButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            bookButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            bookButton.widthAnchor.constraint(equalToConstant: 84),
            bookButton.heightAnchor.constraint(equalToConstant: 125),
            
            likeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            likeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            likeButton.trailingAnchor.constraint(equalTo: bookButton.leadingAnchor, constant: -5),
            likeButton.widthAnchor.constraint(equalToConstant: 56),
            likeButton.heightAnchor.constraint(equalToConstant: 125)
        ])
    }
    
    func configure(with film: MovieItem) {
        currentFilm = film
        nameLabel.text = film.name
        genreLabel.text = film.genre
        timeLabel.text = film.time
        
        if let image = UIImage(named: film.image) {
            filmImageView.image = image
        }
        
        likeButton.setBackgroundImage(film.isFavorite ? UIImage(resource: .liked) : UIImage(resource: .like), for: .normal)
        bookButton.setBackgroundImage(film.isPushed ? UIImage(resource: .book) : UIImage(resource: .book), for: .normal)
    }
}
