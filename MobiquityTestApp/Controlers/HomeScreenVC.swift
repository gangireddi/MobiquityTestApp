//
//  ViewController.swift
//  MobiquityApp
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import UIKit
import CoreData

class HomeScreenVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    var locationsViewModels = [LocationViewModel]()
    var locationsArray = [Location]()
    let cellId = "LocationCell"
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vcSettings: SettingsPageVC = storyboard.instantiateViewController(withIdentifier: "SettingsPageVC") as! SettingsPageVC
        self.navigationController?.pushViewController(vcSettings, animated: true)
    }
    
    @IBAction func mapButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vcMapsScreen: MapsScreenVC = storyboard.instantiateViewController(withIdentifier: "MapsScreenVC") as! MapsScreenVC
        vcMapsScreen.locationsViewModels = self.locationsViewModels
        self.navigationController?.pushViewController(vcMapsScreen, animated: true)
    }
    
    @IBAction func helpButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vcHelpScreen: HelpScreenVC = storyboard.instantiateViewController(withIdentifier: "HelpScreenVC") as! HelpScreenVC
        self.navigationController?.pushViewController(vcHelpScreen, animated: true)
    }
    
    fileprivate func fetchData() {
                
        let _context = appDelegate.persistentContainer.viewContext

        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        request.returnsObjectsAsFaults = false
        do {
            let result = try _context.fetch(request)
            for data in result as! [NSManagedObject] {
                let address = data.value(forKey: "address") as! String
                let latitude = data.value(forKey: "latitude") as! String
                let longitude = data.value(forKey: "longitude") as! String
                let locationName = data.value(forKey: "locationName") as! String
                let country = data.value(forKey: "country") as! String
                
                let loc = Location(address: address,latitude: latitude,longitude: longitude,locationName: locationName,country: country)
                locationsArray.append(loc)
            }
            self.locationsViewModels = locationsArray.map({return LocationViewModel(location: $0)})

            if(locationsViewModels.count>0) {
                noDataLabel.isHidden = true
                self.tableView.reloadData()
            }else {
                noDataLabel.isHidden = true
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    @objc func updateTable(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: LocationCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let locationViewModel = locationsViewModels[indexPath.row]
        cell.locationViewModel = locationViewModel
        
        cell.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        cell.cancelButton.selectedIndex = indexPath.row
    
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vcCityScreen: CityScreenVC = storyboard.instantiateViewController(withIdentifier: "CityScreenVC") as! CityScreenVC
        vcCityScreen.selectedLocation = locationsViewModels[indexPath.row]
        self.navigationController?.pushViewController(vcCityScreen, animated: true)
    }
    
    @objc func cancelButtonAction(sender: CustomCloseButton) {
        
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: context)
//
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
//
//        let location = locationsViewModels[sender.selectedIndex]
//        let index: Int = locationsViewModels.firstIndex(where: {$0.latitude == location.latitude && $0.longitude == location.longitude}) ?? -1
//        locationsViewModels.remove(at: index)
//        fetchRequest.predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", location.latitude,location.longitude)
//
//        if let result = try? context.fetch(fetchRequest) {
//            for object in result {
//                context.delete(object as! NSManagedObject)
//            }
//        }
//
//
    }
}
