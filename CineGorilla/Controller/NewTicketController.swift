import UIKit

class NewTicketController: UIViewController {
    private var ticketView: NewTicketView {
        return view as! NewTicketView
    }
    
    private let films = FilmModel.shared.films
    private var selectedDate: DateComponents?
    
    override func loadView() {
        view = NewTicketView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupActions()
        registerCells()
    }
    
    private func setupDelegates() {
        ticketView.tableView.delegate = self
        ticketView.tableView.dataSource = self
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        ticketView.calendarView.selectionBehavior = selection
    }
    
    private func setupActions() {
        ticketView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func registerCells() {
        ticketView.tableView.register(FilmCell.self, forCellReuseIdentifier: "FilmCell")
    }
    
    @objc private func backButtonTapped() {
        UIApplication.setRootViewController(MainController())
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let film = films[index]
        film.isFavorite.toggle()
        
        let cell = ticketView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? FilmCell
        cell?.likeButton.setBackgroundImage(film.isFavorite ? UIImage(resource: .liked) : UIImage(resource: .like), for: .normal)
    }
    
    @objc private func bookButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        guard let selectedDate = selectedDate else {
            showDateSelectionAlert()
            return
        }
        
        let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        if let selectedDay = selectedDate.day, let selectedMonth = selectedDate.month, let selectedYear = selectedDate.year,
           let currentDay = currentDate.day, let currentMonth = currentDate.month, let currentYear = currentDate.year {
            
            let selectedDateValue = selectedYear * 10000 + selectedMonth * 100 + selectedDay
            let currentDateValue = currentYear * 10000 + currentMonth * 100 + currentDay
            
            if selectedDateValue < currentDateValue {
                showInvalidDateAlert()
                return
            }
        }
        
        let certainTicketController = CertainTicketController()
        certainTicketController.configure(with: films[index], date: selectedDate)
        UIApplication.setRootViewController(certainTicketController)
    }
    
    private func showDateSelectionAlert() {
        let alert = UIAlertController(title: "Choose Date", message: "Choose date", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showInvalidDateAlert() {
        let alert = UIAlertController(title: "Invalid Date", message: "Choose future date", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewTicketController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
        
        let film = films[indexPath.row]
        cell.configure(with: film)
        
        cell.likeButton.tag = indexPath.row
        cell.bookButton.tag = indexPath.row
        
        cell.likeButton.removeTarget(nil, action: nil, for: .allEvents)
        cell.bookButton.removeTarget(nil, action: nil, for: .allEvents)
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        cell.bookButton.addTarget(self, action: #selector(bookButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension NewTicketController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selectedDate = dateComponents
    }
}
