//
//  RegisterUserViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/4/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldRepeat: UITextField!
    let API_BASE_URL:String="http://34.220.155.206:1414/user"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func SaveTapped(_ sender: Any) {
        let username=textFieldUsername.text
        if textFieldPassword.text == textFieldRepeat.text{
            let password=textFieldRepeat.text
            let parameters=[
                "username":username,
                "password":password
            ]
            Alamofire.request(API_BASE_URL,method:.post,parameters:parameters,encoding:JSONEncoding.default)
                .responseJSON(completionHandler: {(response) in
                    switch(response.result){
                        case .success(let value):
                            let json=JSON(value)
                            let user=User()
                            user._id=json["_id"].stringValue
                            user.password=json["password"].stringValue
                            user.username=json["username"].stringValue
                            self.performSegue(withIdentifier: "onRegisterOwnerSegue", sender: user)
                            break
                        case .failure(let error):
                            print("an error has ocurred while creating user \(error)")
                    }
                })
        }else{
            //mandar alerta
            print("ingrese bien la contraseña")
        }
    }
    @IBAction func CancelTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        if segue.identifier == "onRegisterOwnerSegue"{
            let siguienteVC=segue.destination as! RegisterOwnerViewController
            siguienteVC.user=sender as! User
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
