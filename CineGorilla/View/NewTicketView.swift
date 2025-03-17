import UIKit

final class NewTicketView: UIView {
    private let background = UIImageView()
    let calendarView = UICalendarView()
    let backButton = UIButton()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
        setupCalendar()
        setupBackButton()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func setupBackButton() {
        backButton.setBackgroundImage(UIImage(resource: .back), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 96),
            backButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    private func setupCalendar() {
        backgroundColor = .black
        
        calendarView.calendar = .current
        calendarView.backgroundColor = UIColor(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)
        
        let headerBackgroundView = UIView()
        headerBackgroundView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        headerBackgroundView.layer.cornerRadius = 30
        headerBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        calendarView.addSubview(headerBackgroundView)
        calendarView.sendSubviewToBack(headerBackgroundView)
        
        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: calendarView.topAnchor),
            headerBackgroundView.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor),
            headerBackgroundView.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 30
        calendarView.overrideUserInterfaceStyle = .dark
        
        calendarView.tintColor = UIColor(red: 73/255, green: 238/255, blue: 112/255, alpha: 1.0)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        tableView.register(FilmCell.self, forCellReuseIdentifier: "FilmCell")
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
} 
