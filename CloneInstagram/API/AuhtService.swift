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
    static func registerUser(withCredential credentials: AuthCredentials) {
        print("DEBUG: Credentials are \(credentials)")
    }
}
