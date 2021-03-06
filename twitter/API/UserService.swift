//
//  UserService.swift
//  twitter
//
//  Created by 김응철 on 2022/05/29.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dic = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dic: dic)
            DispatchQueue.main.async {
                completion(user)
            }
        }
    }
}
