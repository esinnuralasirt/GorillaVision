import UIKit

final class MyTicketController: UIViewController {
    private let contentView = MyTicketView()
    private var tickets: [TicketModel] = []
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tickets = TicketModel.getTickets()
        setupDelegates()
        setupActions()
    }
    
    private func setupDelegates() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.pageControl.numberOfPages = contentView.collectionView.numberOfItems(inSection: 0)
    }
    
    private func setupActions() {
        contentView.pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        contentView.backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
    }
    
    @objc private func handleBackButton() {
        UIApplication.setRootViewController(MainController())
    }
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let newOffset = CGPoint(
            x: CGFloat(sender.currentPage) * contentView.collectionView.frame.size.width,
            y: 0
        )
        contentView.collectionView.setContentOffset(newOffset, animated: true)
    }
}

extension MyTicketController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = tickets.count
        contentView.pageControl.numberOfPages = numberOfItems
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCell", for: indexPath) as! TicketCell
        let ticket = tickets[indexPath.item]
        cell.configure(with: ticket)
        return cell
    }
}

extension MyTicketController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing = layout.minimumLineSpacing
        let itemWidth = collectionView.frame.width - itemSpacing
        return CGSize(width: itemWidth, height: collectionView.frame.height)
    }
}

extension MyTicketController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        contentView.pageControl.currentPage = page
        
        let offset = CGPoint(
            x: CGFloat(page) * scrollView.frame.size.width,
            y: 0
        )
        scrollView.setContentOffset(offset, animated: true)
    }
}
