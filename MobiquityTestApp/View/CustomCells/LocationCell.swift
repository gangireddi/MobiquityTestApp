//
//  LocationTableViewCell.swift
//  MobiquityApp
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cancelButton: CustomCloseButton!
    @IBOutlet weak var imvBg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func draw(_ rect: CGRect) {
        
        
    }
    var locationViewModel: LocationViewModel! {
        didSet {
            countryName.text = locationViewModel.countryName
            locationName.text = locationViewModel.locationName
            address.text = locationViewModel.address
        }
    }
//
//    override init(style: LocationCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError()
//    }
}

class CustomCloseButton: UIButton {
    var isToClear: Bool = false
    var selectedIndex: Int = -1
}
