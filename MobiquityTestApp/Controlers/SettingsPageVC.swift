//
//  SettingsPageVC.swift
//  MobiquityApp
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import UIKit
import CoreData

class SettingsPageVC: BaseViewController {

    var locations = [Location]()
     @IBOutlet weak var metricButton: CustomSettingsButton!
     @IBOutlet weak var imperialButton: CustomSettingsButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if appDelegate.selectedUnits == METRIC {
            metricButton.isSelected = true
            imperialButton.isSelected = false
        }else {
            imperialButton.isSelected = true
            metricButton.isSelected = false
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeUnitsButtonAction(_ sender: CustomSettingsButton) {
        
        imperialButton.isSelected = false
        metricButton.isSelected = false

        sender.isSelected = true
        if sender.tag == 1 {
            appDelegate.selectedUnits = METRIC
        }else{
            appDelegate.selectedUnits = IMPERIAL
        }
    }
    
    @IBAction func resetBookMarkedCitiesButtonAction(_ sender: UIButton) {
        
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_LOCATIONS)

        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let obj: NSManagedObject = data
                context.delete(obj)
                do {
                    try context.save()
                }
          }
        } catch {
            print("Failed")
        }
    }
}


@IBDesignable
class CustomSettingsButton: UIButton {
    
    override open var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(red: 0.0/255, green: 174.0/255, blue: 242.0/255, alpha: 1.0) : UIColor.lightGray
        }
    }
    override func draw(_ rect: CGRect) {
        
        self.titleLabel?.textAlignment = .center
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
    }
    
}
