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
    
    let API_BASE_URL:String="http://34.220.155.206:1414/login"
    
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
    @IBAction func RegisterTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
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
                        print("login successfull \(json["name"].stringValue)")
                        let _id=json["_id"].stringValue
                        let name=json["name"].stringValue
                        let address=json["address"].stringValue
                        let birthdate=json["birthdate"].stringValue
                        let lastname=json["lastname"].stringValue
                        let telephone=json["telephone"].stringValue
                        let pets=[json["pets"].stringValue]
                        let user_id=json["user_id"].stringValue
                        let image=json["image"].stringValue
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
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
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
