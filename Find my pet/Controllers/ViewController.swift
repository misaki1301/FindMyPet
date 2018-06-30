//
//  ViewController.swift
//  Find my pet
//
//  Created by Paul Pacheco on 5/7/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let API_BASE_URL:String="http://34.221.160.8:1414"
    @IBOutlet weak var tableView: UITableView!
    typealias Breeds = [Breed]
    var tableData:[Breed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetching data from web api
        Alamofire.request(API_BASE_URL+"/breeds").responseJSON{ (response) in
            if let json = response.result.value{
                let Array : NSArray = json as! NSArray
                for i in 0..<Array.count{
                    self.tableData.append(Breed(
                        id:(Array[i] as AnyObject).value(forKey: "_id") as! String,
                        name:(Array[i] as AnyObject).value(forKey: "name") as! String
                    ))
                }
                
                self.tableView?.reloadData()
            }
                //self.tableView?.reloadData()
                //print("datos para tabla\(self.tableData)")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("elements\(tableData.count)")
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LostDog
        let breed:Breed
        breed=tableData[indexPath.row]
        cell.textViewName.text=breed.name
        return cell
    }
    


}
