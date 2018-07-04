//
//  Owner.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/2/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import Foundation

class Owners :Codable{
    var pets:[String]=[]
    var _id:String?=""
    var name:String?=""
    var lastname:String?=""
    var birthdate:String?=""
    var telephone:String?=""
    var address:String?=""
    var image:String?=""
    var user_id:String?=""
    init() {
        
    }
    enum CodingKeys: String, CodingKey{
        case pets
        case _id
        case name
        case lastname
        case birthdate
        case telephone
        case address
        case image
        case user_id
    }
    init(id:String,pets:[String],name:String,lastname:String,birthdate:String,telephone:String,
         address:String,image:String,user_id:String) {
        self._id=id
        self.name=name
        self.lastname=lastname
        self.birthdate=birthdate
        self.telephone=telephone
        self.address=address
        self.image=image
        self.user_id=user_id
        self.pets=pets
    }
}
