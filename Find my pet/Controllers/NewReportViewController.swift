//
//  NewReportViewController.swift
//  Find my pet
//
//  Created by Paul Frank Pacheco Carpio on 7/3/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit
import MapKit

class NewReportViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        self.setMapView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        let userLocation:CLLocation=locations[0] as CLLocation
        
        let center=CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region=MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)
        
        //Drop a Pin at user location
        let myAnnotation:MKPointAnnotation=MKPointAnnotation()
        myAnnotation.coordinate=CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        myAnnotation.title="Ubicación actual"
        mapView.addAnnotation(myAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func setMapView(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(NewReportViewController.handleLongPress(gestureRecognizer:)))
        longPress.minimumPressDuration=0.5
        longPress.delaysTouchesBegan=true
        longPress.delegate=self
        self.mapView.addGestureRecognizer(longPress)
        
    }
    @objc func handleLongPress(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state != UIGestureRecognizerState.ended{
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom:self.mapView)
            print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            let coordinates=[
                "latitude":locationCoordinate.latitude,
                "longitude":locationCoordinate.longitude
            ]
            let pinLocate:MKPointAnnotation=MKPointAnnotation()
            pinLocate.coordinate=CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)
            pinLocate.title="Ubicación seleccionada"
            self.mapView.addAnnotation(pinLocate)
            let alert = UIAlertController(title: "¿Desea seleccionar esta posición?", message: "Puede seguir buscando si desea", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Si", style: .default, handler: {
                action in
                print("que wea falta solo el post")
                self.performSegue(withIdentifier: "onEditSegue", sender:coordinates )
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        if gestureRecognizer.state != UIGestureRecognizerState.began{
            return
        }
    }
//    @objc func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer){
//        if sender.state != UIGestureRecognizerState.began { return }
//        let touchLocation = sender.location(in: mapView)
//        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
//        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
//    }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
//        switch newState{
//        case .starting:
//            view.dragState = .dragging
//        case .ending, .canceling:
//            view.dragState = .none
//        default: break
//        }
//    }
   

}
