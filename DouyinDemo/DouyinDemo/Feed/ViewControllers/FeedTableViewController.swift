//
//  FeedTableViewController.swift
//  DouyinDemo
//
//  Created by ByteDance on 2022/5/2.
//

import UIKit
import AVFAudio

class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isPagingEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdenfitiferString)
        view.addSubview(tableView)
    
        // 设置 audio session
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        // 处理前后台播放
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.pause()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func play() {
        tableView.visibleCells.forEach { cell in
            (cell as? FeedTableViewCell)?.play()
        }
    }
    
    private func pause() {
        tableView.visibleCells.forEach { cell in
            (cell as? FeedTableViewCell)?.pause()
        }
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FeedTableViewCell else {
            return
        }
        
        cell.viewController?.beginAppearanceTransition(true, animated: false)
        cell.viewController?.endAppearanceTransition()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FeedTableViewCell else {
            return
        }
        
        cell.viewController?.beginAppearanceTransition(false, animated: false)
        cell.viewController?.endAppearanceTransition()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdenfitiferString, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor
        if let cell = cell as? FeedTableViewCell {
            cell.config(FeedModel())
        }
        return cell
    }
}
