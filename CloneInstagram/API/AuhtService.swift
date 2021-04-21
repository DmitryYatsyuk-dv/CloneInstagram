//
//  AuhtService.swift
//  CloneInstagram
//
//  Created by Lucky on 21.04.2021.
//

import UIKit
import Firebase

struct AuthCredentials  {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredential credentials: AuthCredentials,
                             completion: @escaping(Error?) -> Void) {
        print("DEBUG: #1-Credentials are \(credentials)")
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("DEBUG: Failed registered user: \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
