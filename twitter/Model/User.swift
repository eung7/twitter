//
//  User.swift
//  twitter
//
//  Created by 김응철 on 2022/05/29.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageURL: URL?
    let uid: String
    
    init(uid: String, dic: [String: Any]) {
        self.uid = uid
        self.email = dic["email"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.fullname = dic["fullname"] as? String ?? ""
        if let profileImageURLString = dic["profileImageURL"] as? String {
            guard let url = URL(string: profileImageURLString) else { return }
            self.profileImageURL = url
        }
    }
}
