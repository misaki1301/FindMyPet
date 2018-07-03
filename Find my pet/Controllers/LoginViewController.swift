//
//  LoginViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/2/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    let API_BASE_URL:String="http://34.218.48.122:1414/login"
    
    @IBOutlet weak var textViewUsename: UITextField!
    @IBOutlet weak var textViewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTap()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LoginTapped(_ sender: Any) {
        let parameters = [
            "username":textViewUsename.text,
            "password":textViewPassword.text
        ]
        Alamofire.request(API_BASE_URL,method:.post, parameters:parameters,encoding:JSONEncoding.default)
            .responseJSON(completionHandler: {(response:DataResponse) in
                switch(response.result){
                    case .success(let value):
                        let json = JSON(value)
                        //print(type(of: value))
                        //let json=try? JSON(data:value as! Data)
                        print("login successfull \(json["name"].stringValue)")
                        var _id=json["_id"].stringValue
                        var name=json["name"].stringValue
                        var address=json["address"].stringValue
                        var birthdate=json["birthdate"].stringValue
                        var lastname=json["lastname"].stringValue
                        var telephone=json["telephone"].stringValue
                        var pets=[json["pets"].stringValue]
                        var user_id=json["user_id"].stringValue
                        var image=json["image"].stringValue
                        print(lastname)
                        let owner=Owners(id: _id,pets: pets,name: name,lastname: lastname,birthdate: birthdate,telephone: telephone,address: address,image: image,user_id: user_id)
                        self.saveUserInfo(item: owner)
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        break
                    case .failure(let error):
                        print("login failure \(error)")
                        break
                }
            })
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
}
extension UIViewController {
    func hideKeyboardWhenTap(){
        let tap=UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
