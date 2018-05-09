//
//  LostDogCell.swift
//  Find my pet
//
//  Created by Paul Pacheco on 5/9/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

class LostDogCell: UITableViewCell {

    @IBOutlet weak var imageDog: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var raceText: UILabel!
    @IBOutlet weak var lastAddressText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
