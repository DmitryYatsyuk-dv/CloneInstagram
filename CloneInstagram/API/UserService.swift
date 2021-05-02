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
//            print("DEBUG: Snapshot: \(snapshot?.data())")
            
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
             completion(user)
        }
    }
    
    //MARK: - func to fetch all of the users
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
// Refactoring var users = [User]()
        
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }

/* Refactoring
            snapshot.documents.forEach { document in
                print("DEBUG: Document in service file: \(document.data())")
                let user = User(dictionary: document.data())
                users.append(user)
            }
            completion(users)
*/
/// The best way is just two lines code
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
}

