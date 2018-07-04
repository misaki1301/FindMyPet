//
//  EditProfileViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/3/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class EditProfileViewController: UIViewController {
    
    let API_BASE_URL:String="http://34.220.155.206:1414/owner"
    
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldTelephone: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var imageProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUserData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("hola apareceré?")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("aparecí!")
        //fillUserData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnDoneTapped(_ sender: Any) {
        let preferences=UserDefaults.standard
        let id=preferences.string(forKey: "_id")!
        let parameters=[
            "name":textFieldName.text,
            "lastname":textFieldLastName.text,
            "address":textFieldAddress.text,
            "birthdate":preferences.string(forKey: "birthdate"),
            "image":preferences.string(forKey: "image"),
            "telephone":textFieldTelephone.text,
            "user_id":preferences.string(forKey: "user_id")
            ]
        Alamofire.request(API_BASE_URL+"?_id=\(id)",method:.patch, parameters:parameters, encoding:JSONEncoding.default).responseJSON(completionHandler:{(response:DataResponse) in
                switch(response.result){
                    case .success(let value):
                        let json=JSON(value)
                        print("successfull update")
                        var _id=json["_id"].stringValue
                        var name=json["name"].stringValue
                        var address=json["address"].stringValue
                        var birthdate=json["birthdate"].stringValue
                        var lastname=json["lastname"].stringValue
                        var telephone=json["telephone"].stringValue
                        var pets=[json["pets"].stringValue]
                        var user_id=json["user_id"].stringValue
                        var image=json["image"].stringValue
                        let owner=Owners(id: _id,pets: pets,name: name,lastname: lastname,birthdate: birthdate,telephone: telephone,address: address,image: image,user_id: user_id)
                        self.saveUserInfo(item: owner)
                        self.navigationController?.popViewController(animated: true)
                        break
                    case .failure(let error):
                        break
                }
            })
    }
    
    @IBAction func btnPhotoTapped(_ sender: Any) {
    }
    func saveUserInfo(item:Owners){
        let preferences = UserDefaults.standard
        preferences.set(item._id, forKey: "_id")
        preferences.set(item.name, forKey: "name")
        preferences.set(item.lastname, forKey: "lastname")
        preferences.set(item.address, forKey: "address")
        preferences.set(item.birthdate, forKey: "birthdate")
        preferences.set(item.telephone, forKey: "telephone")
        preferences.set(item.pets, forKey: "pets")
        preferences.set(item.user_id, forKey: "user_id")
        preferences.set(item.image, forKey: "image")
        //checking if the preference is saved or not
        didSave(preferences: preferences)
        
    }
    func didSave(preferences:UserDefaults){
        let didSave = preferences.synchronize()
        if !didSave{
            //it couldn't save
            print("Preferences could not be saved")
        }else{
            print("Preferences has been saved")
        }
    }
    func fillUserData(){
        let preferences = UserDefaults.standard
        textFieldName.text="\(preferences.string(forKey: "name")!)"
        textFieldLastName.text="\(preferences.string(forKey: "lastname")!)"
        textFieldAddress.text="\(preferences.string(forKey: "address")!)"
        textFieldTelephone.text="\(preferences.string(forKey: "telephone")!)"
        let url = URL(string: preferences.string(forKey: "image")!)
        imageProfile.kf.setImage(with: url)
        print("url de imagen \(url!)")
        
    }
    func updateUserData(){
        
    }

}
