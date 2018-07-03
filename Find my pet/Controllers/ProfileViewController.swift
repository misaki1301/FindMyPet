//
//  ProfileViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/2/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textViewFullName: UILabel!
    @IBOutlet weak var textViewBirthDate: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var textViewAddress: UILabel!
    @IBOutlet weak var textViewTelephone: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUserData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! MyPets
        return cell
    }
    
    func fillUserData(){
        let preferences = UserDefaults.standard
        textViewFullName.text="\(preferences.string(forKey: "name")!) \(preferences.string(forKey: "lastname")!)"
        textViewAddress.text="\(preferences.string(forKey: "address")!)"
        textViewBirthDate.text="\(preferences.string(forKey: "birthdate")!)"
        textViewTelephone.text="\(preferences.string(forKey: "telephone")!)"
        let url = URL(string: preferences.string(forKey: "image")!)
        imageViewProfile.kf.setImage(with: url)
        print("url de imagen \(url!)")
        
    }
    

}
