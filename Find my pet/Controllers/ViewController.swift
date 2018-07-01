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
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let API_BASE_URL:String="http://34.221.160.8:1414"
    @IBOutlet weak var tableView: UITableView!
    typealias Reports = [Report]
    var tableData:[Report] = []
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        //fetching data from web api
        Alamofire.request(API_BASE_URL+"/reports").responseJSON{ (response) in
            if let json = response.result.value{
                let Array : NSArray = json as! NSArray
                for i in 0..<Array.count{
                    self.tableData.append(Report(
                        id:(Array[i] as AnyObject).value(forKey: "_id") as! String,
                        title:(Array[i] as AnyObject).value(forKey: "title") as! String,
                        latitude: (Array[i] as AnyObject).value(forKey: "latitude") as! String,
                        longitude: (Array[i] as AnyObject).value(forKey: "longitude") as! String,
                        date: (Array[i] as AnyObject).value(forKey:"date") as! String,
                        isLost: (Array[i] as AnyObject).value(forKey:"isLost") as! Bool,
                        description: (Array[i] as AnyObject).value(forKey: "description") as! String,
                        user_id: (Array[i] as AnyObject).value(forKey: "user_id") as! String,
                        pet_id: (Array[i] as AnyObject).value(forKey: "pet_id") as! String
                    ))
                }
                print("elementos:\(self.tableData[1].latitude)")
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
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LostDog
        let report:Report
        report=tableData[indexPath.row]
        cell.textViewTitle.text=report.title
        cell.textViewDate.text=report.date
        let lat:Double = (report.latitude! as NSString).doubleValue
        let lon:Double = (report.longitude! as NSString).doubleValue
        let location = CLLocation(latitude:lat, longitude:lon)
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks,error) in
            if(error != nil){
                print("reverse geocode fail \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            if pm.count>0{
                let pm = placemarks![0]
                print(pm.country)
                print(pm.locality)
                print(pm.subLocality)
                print(pm.thoroughfare)
                print(pm.postalCode)
                print(pm.subThoroughfare)
                //print(pm.)
                var addressString : String = ""
                if pm.subLocality != nil{
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil{
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil{
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil{
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil{
                    addressString = addressString + pm.postalCode! + ", "
                }
                print(addressString)
                cell.textViewAddress.text=addressString
            }
        })
        return cell
    }
    
    func setUpNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController=searchController
        navigationItem.hidesSearchBarWhenScrolling=false
    }

}
