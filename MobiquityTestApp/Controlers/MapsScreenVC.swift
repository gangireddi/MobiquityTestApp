//
//  MapsScreenVC.swift
//  MobiquityTestApp
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapsScreenVC: BaseViewController,UIGestureRecognizerDelegate,CLLocationManagerDelegate {
    @IBOutlet private var mapView: MKMapView!

    var locations = [Location]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        addAnotationsforInitialSetup()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(handleTap))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    func addAnotationsforInitialSetup() {
        for loc in locations {
            
            if let lat: Double = Double(loc.latitude ?? "0.0") {
                let annotation = MKPointAnnotation()
                if  let lon: Double = Double(loc.longitude ?? "0.0"){
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == .ended {
            let locationInView = gestureRecognizer.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
        }
    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
        self.getAddressFromLatLon(pdblLatitude: location.latitude.description, withLongitude: location.longitude.description)
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String)
    {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0
                {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    
                    if pm.administrativeArea != nil {
                        addressString = addressString + pm.administrativeArea! + ", "
                    }
                    if pm.subAdministrativeArea != nil {
                        addressString = addressString + pm.subAdministrativeArea! + ", "
                    }
                    if pm.subLocality != nil
                    {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.postalCode != nil
                    {
                        addressString = addressString + pm.postalCode! + " "
                    }
                
                    if addressString != "" {
                        self.saveLocationData(lat: pdblLatitude,lon: pdblLongitude,address: addressString,locName: pm.locality ?? "",countryName: pm.country ?? "")
                    }
                    
                }
        })
        
    }
    
    func isEntityAttributeExist(latitude: String, longitude: String) -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        fetchRequest.predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", latitude,longitude)
        let res = try! context.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    func saveLocationData(lat: String, lon: String, address: String,locName: String,countryName: String) {
        
        if isEntityAttributeExist(latitude: lat, longitude: lon) {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: context)
        let newLocation = NSManagedObject(entity: entity!, insertInto: context)
        
        newLocation.setValue(address, forKey: "address")
        newLocation.setValue(lat, forKey: "latitude")
        newLocation.setValue(lon, forKey: "longitude")
        newLocation.setValue(locName, forKey: "locationName")
        newLocation.setValue(countryName, forKey: "country")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
