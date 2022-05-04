//
//  FeedModel.swift
//  DouyinDemo
//
//  Created by ByteDance on 2022/5/3.
//

import Foundation

struct FeedModel {
    
    struct Author {
        var id: String?
        var name: String?
        var avatarURL: URL? = URL(string: "https://avatars.githubusercontent.com/u/57855015?v=4")
    }
    
    var id: String?

    var videoURL: URL? = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")

    var coverURL: URL?

    var author: Author?

    var likeCount: String?

}
