//
//  DetailLostViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/3/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import Kingfisher

class DetailLostViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textDescription: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var textName: UILabel!
    @IBOutlet weak var textBreed: UILabel!
    @IBOutlet weak var textDate: UILabel!
    var report=Report()
    var locationManager:CLLocationManager!
    let API_BASE_URL:String="http://34.220.155.206:1414/"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        print(report.pet_id+"este es id para buscar todos los datos de mrd")
        FillDataFromSegue()
        // Do any additional setup after loading the view.
        Alamofire.request(API_BASE_URL+"pets?_id=\(report.pet_id)").responseJSON(completionHandler: {(response:DataResponse) in
            switch(response.result){
                case .success(let value):
                    let json = JSON(value)
                    print("\(value)")
                    let pet=Pet()
                    pet._id=json["_id"].stringValue
                    pet.name=json["name"].stringValue
                    pet.gender=json["gender"].stringValue
                    pet.image=json["image"].stringValue
                    pet.owner_id=json["owner_id"].stringValue
                    pet.breed_id=json["breed_id"].stringValue
                    print("nombre de la mascota a identificar "+pet.name)
                    self.updateDatatoShow(pet: pet)
                    break
                case .failure(let error):
                    print("fail to get data from report and dogs \(error)")
                    break
            }
            
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        determinateCurrentLocation()
    }
    func determinateCurrentLocation(){
        locationManager=CLLocationManager()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
       if CLLocationManager.locationServicesEnabled(){
           locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let userLocation:CLLocation=locations[0] as CLLocation
        let lat:Double = (report.latitude as NSString).doubleValue
        let lon:Double = (report.longitude as NSString).doubleValue
        let center=CLLocationCoordinate2DMake(lat, lon)
        let region=MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)
        
        //Drop a Pin at user location
        let myAnnotation:MKPointAnnotation=MKPointAnnotation()
        myAnnotation.coordinate=CLLocationCoordinate2DMake(lat, lon)
        myAnnotation.title="Ubicación registrada"
        mapView.addAnnotation(myAnnotation)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func FillDataFromSegue(){
        textDescription.text=report.description
        textDate.text=report.date
        textTitle.text=report.title
        //let url =URL(string:)
        //imageView.kf.setImage(with: <#T##Resource?#>)
    }
    func updateDatatoShow(pet:Pet){
        textName.text=pet.name
        print("raza de perro seleccionado \(pet.breed_id)")
        Alamofire.request(API_BASE_URL+"breeds?_id=\(pet.breed_id)").responseJSON(completionHandler: {(response:DataResponse) in
            switch(response.result){
            case .success(let value):
                let json=JSON(value)
                self.textBreed.text=json["name"].stringValue
                break
            case .failure(let error):
                print("fail while fetching breed name data \(error)")
            }
        })
        let url=URL(string: pet.image)
        imageView.kf.setImage(with: url)
    }

}
