//
//  ProfileHeaderViewModel.swift
//  CloneInstagram
//
//  Created by Lucky on 27.04.2021.
//

import Foundation

struct ProfileHeaderViewModel {
    
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}
