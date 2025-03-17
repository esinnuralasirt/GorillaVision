import UIKit

final class FavoriteController: UIViewController {
    
    private let favoriteView = FavoriteView()
    private var favoriteFilms: [MovieItem] = []
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteFilms()
    }
    
    private func updateFavoriteFilms() {
        favoriteFilms = FilmModel.shared.films.filter { $0.isFavorite }
        favoriteView.tableView.reloadData()
    }
    
    private func setupTableView() {
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
    }
    
    private func setupActions() {
        favoriteView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        UIApplication.setRootViewController(MainController())
    }
}

extension FavoriteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
        let film = favoriteFilms[indexPath.row]
        
        cell.configure(with: film)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.removeTarget(nil, action: nil, for: .allEvents)
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let film = favoriteFilms[index]
        film.isFavorite.toggle()
        updateFavoriteFilms()
    }
}

extension FavoriteController: UITableViewDelegate {
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
