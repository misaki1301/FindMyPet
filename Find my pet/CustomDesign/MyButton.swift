//
//  MyButton.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/1/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

@IBDesignable class MyButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false{
        didSet{
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius(){
        layer.cornerRadius=rounded ? frame.size.height/2:0
    }
    
}


