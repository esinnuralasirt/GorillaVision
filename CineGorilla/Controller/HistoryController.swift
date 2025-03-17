import UIKit

final class HistoryController: UIViewController {
    private let historyView = HistoryView()
    
    override func loadView() {
        view = historyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupActions()
    }
    
    private func setupDelegates() {
        historyView.collectionView.delegate = self
        historyView.collectionView.dataSource = self
        historyView.pageControl.numberOfPages = historyView.collectionView.numberOfItems(inSection: 0)
    }
    
    private func setupActions() {
        historyView.pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        historyView.backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
    }
    
    @objc private func handleBackButton() {
        UIApplication.setRootViewController(MainController())
    }
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let newOffset = CGPoint(x: CGFloat(sender.currentPage) * historyView.collectionView.frame.size.width, y: 0)
        historyView.collectionView.setContentOffset(newOffset, animated: true)
    }
}

extension HistoryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = 1
        historyView.pageControl.numberOfPages = numberOfItems
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsedTicketCell", for: indexPath)
        return cell
    }
}

extension HistoryController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing = layout.minimumLineSpacing
        let itemWidth = collectionView.frame.width - itemSpacing
        return CGSize(width: itemWidth, height: collectionView.frame.height)
    }
}

extension HistoryController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        historyView.pageControl.currentPage = page
        
        let offset = CGPoint(x: CGFloat(page) * scrollView.frame.size.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
}
