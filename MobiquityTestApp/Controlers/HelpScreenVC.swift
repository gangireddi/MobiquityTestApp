//
//  HelpScreenVC.swift
//  MobiquityApp
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import UIKit
import WebKit

class HelpScreenVC: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.loadHTMLString("<html><h1>How to use app?</h1> <body><p> <ol><li>Home page shows list of pinned locations when user pinned locations on Maps</li><li>For this click on Map button top right corner of Home page</li><li>If user long press on map then pin will generate on map</li><li>If user back from map to home screen by clik on back button in map screen</li><li>You see list of pinned locations on home page</li><li>If you click on any cell in Home page then City screen open and loads with 5 days weather forecast data</li></ol> </p></body> </html>", baseURL: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
   

}
