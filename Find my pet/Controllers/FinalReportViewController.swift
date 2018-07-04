//
//  FinalReportViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/3/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Alamofire

class FinalReportViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    let API_BASE_URL:String="http://34.220.155.206:1414/pets"
    var petList:[Pet] = []
    let rowHeight:CGFloat=50.0
    @IBOutlet weak var textFieldPet: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerViewPets: UIPickerView!
    @IBOutlet weak var textFieldDescription: UITextField!
    @IBOutlet weak var textFieldDate: UITextField!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewPets.isHidden=false
        datePicker.isHidden=true
        // Do any additional setup after loading the view.
        Alamofire.request(API_BASE_URL).responseJSON(completionHandler: {(response) in
            if let json = response.result.value{
                let Array: NSArray=json as! NSArray
                for i in 0..<Array.count{
                    self.petList.append(Pet(id: (Array[i] as AnyObject).value(forKey: "_id") as! String,
                                              name: (Array[i] as AnyObject).value(forKey: "name") as! String,
                                              breed_id: (Array[i] as AnyObject).value(forKey: "breed_id") as! String,
                                              gender: (Array[i] as AnyObject).value(forKey: "gender") as! String,
                                              image: (Array[i] as AnyObject).value(forKey: "image") as! String,
                                              owner_id: (Array[i] as AnyObject).value(forKey: "owner_id") as! String))
                }
            print(self.petList[0].name+"XD")
            }
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return petList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return petList[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldPet?.text=petList[row].name
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerViewPets.isHidden=false
        print("se ha activado mi mecanismo")
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerViewPets.isHidden=false
        //print("se ha activado mi mecanismo")
    }
    
}
