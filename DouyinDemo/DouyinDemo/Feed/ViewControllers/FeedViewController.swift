//
//  FeedViewController.swift
//  DouyinDemo
//
//  Created by ByteDance on 2022/5/3.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    
    private var playerLayer: AVPlayerLayer
    
    init(player: AVPlayer?) {
        playerLayer = AVPlayerLayer(player: player)
        super.init(frame: .zero)
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

class FeedViewController: UIViewController {

    private var feed: FeedModel
    
    private var player: AVPlayer?
    
    private lazy var playerView: PlayerView = {
        PlayerView(player: self.player)
    }()
    
    init(with feed: FeedModel) {
        self.feed = feed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = AVPlayer(url: feed.videoURL!)
        view.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pause()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
}
