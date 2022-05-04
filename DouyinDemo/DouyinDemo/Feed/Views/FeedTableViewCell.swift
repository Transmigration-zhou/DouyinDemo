//
//  FeedTableViewCell.swift
//  DouyinDemo
//
//  Created by ByteDance on 2022/5/2.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    static let reuseIdenfitiferString = "FeedTableViewCell"
    
    var viewController: FeedViewController?

    func config(_ feed: FeedModel) {
        viewController?.view.removeFromSuperview()
        let vc = FeedViewController(with: feed)
        viewController = vc
        contentView.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    func play() {
        viewController?.play()
    }

    func pause() {
        viewController?.pause()
    }

}
