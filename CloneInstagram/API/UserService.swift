//
//  UserService.swift
//  CloneInstagram
//
//  Created by Lucky on 27.04.2021.
//

import Firebase

struct UserService {
    
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
    
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            print("DEBUG: Snapshot: \(snapshot?.data())")
            
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
             completion(user)
        }
    }
}

