import UIKit

final class PushController: UIViewController {
    
    private let films = FilmModel.shared.films
    
    private var pushView: PushView {
        return view as! PushView
    }
    
    override func loadView() {
        view = PushView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupTableView()
    }
    
    private func setupActions() {
        pushView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        pushView.tableView.dataSource = self
        pushView.tableView.delegate = self
    }
    
    @objc private func backButtonTapped() {
        UIApplication.setRootViewController(MainController())
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let film = films[index]
        film.isFavorite.toggle()
        
        let cell = pushView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? FilmCell
        cell?.likeButton.setBackgroundImage(film.isFavorite ? UIImage(resource: .liked) : UIImage(resource: .like), for: .normal)
    }
    
    @objc private func bookButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let certainTicketController = CertainTicketController()
        certainTicketController.configure(with: films[index], date: currentDate)
        UIApplication.setRootViewController(certainTicketController)
    }
}

extension PushController: UITableViewDataSource {
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
}

extension PushController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}
