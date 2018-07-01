//
//  Report.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 6/30/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import Foundation

class Report{
    var _id:String?
    var title:String?
    var latitude:String?
    var longitude:String?
    var date:String?
    var isLost:Bool
    var description:String?
    var user_id:String?
    var pet_id:String?
    
    init(id:String,title:String,latitude:String,longitude:String,date:String,isLost:Bool,description:String,user_id:String,pet_id:String) {
        self._id=id
        self.title=title
        self.latitude=latitude
        self.longitude=longitude
        self.date=date
        self.isLost=isLost
        self.description=description
        self.user_id=user_id
        self.pet_id=pet_id
    }
}
