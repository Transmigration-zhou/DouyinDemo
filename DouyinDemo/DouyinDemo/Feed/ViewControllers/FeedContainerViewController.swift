//
//  FeedContainerViewController.swift
//  DouyinDemo
//
//  Created by ByteDance on 2022/4/28.
//

import UIKit
import SnapKit

protocol FeedContainerViewControllerDelegate: NSObjectProtocol {
    
    func feedContainerViewController(controller: FeedContainerViewController, viewControllerAt indexPath: IndexPath) -> UIViewController
    
    func numberOfViewControllers(in containerViewController: FeedContainerViewController) -> Int

    func feedContainerViewController(controller: FeedContainerViewController , didScroll scrollView: UIScrollView)
    
}

class FeedContainerViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func setPageIndex(index: Int, animated: Bool) {
        guard index < collectionView.numberOfItems(inSection: 0) else {
            return
        }
        collectionView.setContentOffset(CGPoint(x: CGFloat(index) * collectionView.frame.width, y: 0), animated: animated)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.feedContainerViewController(controller: self, didScroll: scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FeedContainerCollectionViewCell else {
            return
        }
        cell.viewController?.beginAppearanceTransition(true, animated: false)
        cell.viewController?.endAppearanceTransition()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FeedContainerCollectionViewCell else {
            return
        }
        cell.viewController?.beginAppearanceTransition(false, animated: false)
        cell.viewController?.endAppearanceTransition()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfViewControllers(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedContainerCollectionViewCell.reuseIdentifierString, for: indexPath) as! FeedContainerCollectionViewCell
        if let viewController = delegate?.feedContainerViewController(controller: self, viewControllerAt: indexPath) {
            cell.config(with: viewController)
        }
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
    
    public weak var delegate: FeedContainerViewControllerDelegate?

    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedContainerCollectionViewCell.self, forCellWithReuseIdentifier: FeedContainerCollectionViewCell.reuseIdentifierString)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }

    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        false
    }
    
}
