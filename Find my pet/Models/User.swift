//
//  User.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 6/29/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import Foundation

class User{
    var _id:String=""
    var username:String=""
    var password:String=""
    init(){
        
    }
    
    init(user:User) {
        self._id=user._id
        self.username=user.username
        self.password=user.password
    }
}

