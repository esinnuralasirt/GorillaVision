import UIKit

final class CertainTicketController: UIViewController {
    private let mainView = CertainTicketView()
    private var placesCount: Int = 1
    private var selectedFilm: MovieItem?
    private var selectedDate: DateComponents?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        setupActions()
    }
    
    func configure(with film: MovieItem, date: DateComponents) {
        selectedFilm = film
        selectedDate = date
    }
    
    private func setupInitialState() {
        mainView.total.intValue = 30
        updatePlacesCount()
        
        if let film = selectedFilm {
            mainView.centerImageView.image = UIImage(named: film.image)
            mainView.filmNameLabel.text = film.name
            mainView.genre.text = film.genre
            mainView.year.text = "\(film.year)"
            mainView.time.text = film.time
        }
        
        if let date = selectedDate, 
           let day = date.day, 
           let month = date.month, 
           let year = date.year {
            mainView.date.text = String(format: "%02d.%02d.%d", day, month, year)
        }
    }
    
    private func setupActions() {
        mainView.incrementButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        mainView.decrementButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
        mainView.bookNowButton.addTarget(self, action: #selector(showCustomAlert), for: .touchUpInside)
        mainView.okButton.addTarget(self, action: #selector(hideCustomAlert), for: .touchUpInside)
        mainView.backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
    }
    
    @objc private func incrementValue() {
        placesCount += 1
        updatePlacesCount()
    }
    
    @objc private func decrementValue() {
        guard placesCount > 1 else { return }
            placesCount -= 1
        updatePlacesCount()
    }
    
    private func updatePlacesCount() {
        mainView.placesCountString.text = "\(placesCount)"
        mainView.total.intValue = placesCount * 30
    }
    
    @objc private func showCustomAlert() {
        mainView.customAlertView.isHidden = false
        mainView.customAlertView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.mainView.customAlertView.alpha = 1
        }
    }
    
    @objc private func hideCustomAlert() {
        UIView.animate(withDuration: 0.3) {
            self.mainView.customAlertView.alpha = 0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.mainView.customAlertView.isHidden = true
            
            let ticket = TicketModel(
                movie: self.selectedFilm!,
                date: self.mainView.date.text ?? "",
                places: self.placesCount,
                points: self.mainView.total.intValue
            )
            TicketModel.saveTicket(ticket)
            UIApplication.setRootViewController(MyTicketController())
        }
    }
    
    @objc private func handleBackButton() {
        UIApplication.setRootViewController(NewTicketController())
    }
}

class IntLabel: UILabel {
    var intValue: Int = 0 {
        didSet {
            self.text = "\(intValue)"
        }
    }
}
