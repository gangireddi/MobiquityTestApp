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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetBookMarkedCitiesButtonAction(_ sender: UIButton) {
        
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")

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
