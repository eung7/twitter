//
//  Tweet.swift
//  twitter
//
//  Created by 김응철 on 2022/05/29.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    var timestamp: Date!
    let likes: Int
    let retweetCount: Int
    
    init(tweetID: String, dic: [String: Any]) {
        self.tweetID = tweetID
        self.caption = dic["caption"] as? String ?? ""
        self.uid = dic["uid"] as? String ?? ""
        self.retweetCount = dic["retweets"] as? Int ?? 0
        self.likes = dic["likes"] as? Int ?? 0
        
        if let timestamp = dic["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
