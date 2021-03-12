//
//  ViewController.swift
//  MobiquityApp
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import UIKit
import CoreData

class HomeScreenVC: BaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    var locationsArray = [Location]()
    var filteredlocationsArray = [Location]()
    let cellId = "LocationCell"
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    var managedObjectsArray = [NSManagedObject]()

    
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
        vcMapsScreen.locations = self.locationsArray
        self.navigationController?.pushViewController(vcMapsScreen, animated: true)
    }
    
    @IBAction func helpButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vcHelpScreen: HelpScreenVC = storyboard.instantiateViewController(withIdentifier: "HelpScreenVC") as! HelpScreenVC
        self.navigationController?.pushViewController(vcHelpScreen, animated: true)
    }
    
    fileprivate func fetchData() {
                
        let _context = appDelegate.persistentContainer.viewContext

        locationsArray.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        request.returnsObjectsAsFaults = false
        do {
            let result = try _context.fetch(request)
            managedObjectsArray = result as! [NSManagedObject]
            for data in result as! [NSManagedObject] {
                let address = data.value(forKey: "address") as! String
                let latitude = data.value(forKey: "latitude") as! String
                let longitude = data.value(forKey: "longitude") as! String
                let locationName = data.value(forKey: "locationName") as! String
                let country = data.value(forKey: "country") as! String
                
                let loc = Location(address: address,latitude: latitude,longitude: longitude,locationName: locationName,country: country)
                locationsArray.append(loc)
            }
            self.filteredlocationsArray = self.locationsArray

            showOrHideNoDataText(isHide: (self.filteredlocationsArray.count > 0) ? true : false)
            self.tableView.reloadData()
            
        } catch {
            
            print("Failed")
        }
    }
    
    func showOrHideNoDataText(isHide: Bool) {
        noDataLabel.isHidden = isHide
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var search: String = ""
        if string == "" {
            
        }else {
            search = (textField.text ?? "") + string
        }
        
        if search == "" {
            filteredlocationsArray = locationsArray
            self.tableView.reloadData()
            
           showOrHideNoDataText(isHide: (self.filteredlocationsArray.count > 0) ? true : false)

            return true
        }
        
        filteredlocationsArray = locationsArray.filter({(($0.locationName?.uppercased().contains(search.uppercased()) ?? false) || ($0.country?.uppercased().contains(search.uppercased()) ?? false) || ($0.address?.uppercased().contains(search.uppercased()) ?? false))})
        self.tableView.reloadData()
        showOrHideNoDataText(isHide: (self.filteredlocationsArray.count > 0) ? true : false)
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredlocationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: LocationCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        cell.locationModel = filteredlocationsArray[indexPath.row]
        
        cell.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        cell.cancelButton.selectedIndex = indexPath.row
    
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vcCityScreen: CityScreenVC = storyboard.instantiateViewController(withIdentifier: "CityScreenVC") as! CityScreenVC
        vcCityScreen.selectedLocation = filteredlocationsArray[indexPath.row]
        self.navigationController?.pushViewController(vcCityScreen, animated: true)
    }
    
    @objc func cancelButtonAction(sender: CustomCloseButton) {
        
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")

        let location = filteredlocationsArray[sender.selectedIndex]
        let index: Int = locationsArray.firstIndex(where: {$0.latitude == location.latitude && $0.longitude == location.longitude}) ?? -1
        let index1: Int = filteredlocationsArray.firstIndex(where: {$0.latitude == location.latitude && $0.longitude == location.longitude}) ?? -1
        locationsArray.remove(at: index)
        filteredlocationsArray.remove(at: index1)
        
        showOrHideNoDataText(isHide: (self.filteredlocationsArray.count > 0) ? true : false)
        
        fetchRequest.predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", location.latitude ?? "",location.longitude ?? "")
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let obj: NSManagedObject = data
                context.delete(obj)
                self.tableView.reloadData()
                do {
                    try context.save()
                }
          }
        } catch {
            print("Failed")
        }
    }
}
