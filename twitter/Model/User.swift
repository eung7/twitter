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
    let profileImageURL: String
    let uid: String
    
    init(uid: String, dic: [String: Any]) {
        self.uid = uid
        self.email = dic["email"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.profileImageURL = dic["profileImageURL"] as? String ?? ""
        self.fullname = dic["fullname"] as? String ?? ""
    }
}
