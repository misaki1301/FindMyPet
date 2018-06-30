//
//  Case.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 6/29/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import Foundation
class Case {
    private var title:String?
    private var latitude:String?
    private var longitude:String?
    private var date:String?
    private var isLost:Bool?
    private var description:String?
    private var user_id:String?
    private var pet_id:String?
    
    init(item:Case) {
        self.title=item.title
        self.latitude=item.latitude
        self.longitude=item.longitude
        self.date=item.date
        self.isLost=item.isLost
        self.description=item.description
        self.user_id=item.user_id
        self.pet_id=item.pet_id
    }
    
    func getTitle() -> String? {
        return self.title
    }
    func setTitle(title:String?){
        self.title=title
    }
}
