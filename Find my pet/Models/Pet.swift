//
//  Pet.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 6/29/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import Foundation

class Pet{
    var _id:String=""
    var name:String=""
    var breed_id:String=""
    var gender:String=""
    var image:String=""
    var owner_id:String=""
    init() {
    }
    init(id:String,name:String,breed_id:String,gender:String,image:String,owner_id:String) {
        self._id=id
        self.breed_id=breed_id
        self.owner_id=owner_id
        self.name=name
        self.gender=gender
        self.image=image
    }
}
