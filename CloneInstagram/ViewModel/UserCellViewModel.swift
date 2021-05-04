//
//  UserCellViewModel.swift
//  CloneInstagram
//
//  Created by Lucky on 04.05.2021.
//

import Foundation

struct UserCellViewModel {
    let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
    
    
}
