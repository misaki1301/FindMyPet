//
//  RegisterOwnerViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/4/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterOwnerViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var user=User()
    @IBOutlet weak var textFielName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldTelephone: UITextField!
    @IBOutlet weak var textFieldBirth: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker=UIImagePickerController()
    var imagenID=NSUUID().uuidString
    let API_BASE_URL:String="http://34.220.155.206:1414/owner"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTap()
        imagePicker.delegate=self
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image=info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image=image
        imageView.backgroundColor=UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func GalleryTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing=true
        present(imagePicker,animated: true,completion: nil)
    }
    @IBAction func DoneTapped(_ sender: Any) {
        let ownerData=getValuesFromFields()
        //en esta parte se sube toda la info del owner con ALAMO
        let imageData=UIImagePNGRepresentation(imageView.image!)!
        let parameters=[
            "name":ownerData.name,
            "lastname":ownerData.lastname,
            "birthdate":ownerData.birthdate,
            "telephone":ownerData.telephone,
            "address":ownerData.address,
            "user_id":ownerData.user_id
        ]
        
        
    }
    
    func getValuesFromFields()->Owners{
        let owner=Owners()
        //_id
        owner.name=textFielName.text
        owner.lastname=textFieldLastName.text
        owner.birthdate=textFieldBirth.text
        owner.telephone=textFieldTelephone.text
        owner.address=textFieldAddress.text
        //image
        owner.user_id=user._id
        return owner
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
