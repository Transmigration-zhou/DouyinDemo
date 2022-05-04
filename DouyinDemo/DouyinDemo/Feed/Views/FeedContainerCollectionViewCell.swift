//
//  FeedContainerCollectionViewCell.swift
//  DouyinDemo
//
//  Created by ByteDance on 2022/4/28.
//

import UIKit

class FeedContainerCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifierString = "FeedContainerCollectionViewCell"

    private(set) var viewController: UIViewController?

    public func config(with viewController: UIViewController) {
        self.viewController?.view.removeFromSuperview()
        self.viewController = viewController

        if let view = self.viewController?.view {
            self.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalTo(0)
            }
        }
    }
}
