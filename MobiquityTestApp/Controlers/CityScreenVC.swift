//
//  CityScreenVC.swift
//  MobiquityApp
//
//  Created by Sandy Gangireddi on 10/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import UIKit

fileprivate let cellID = "WeatherForcastCell"
fileprivate let MINIMUM_INTER_ITEM_SPACE: CGFloat = 30.0//isiPhone == true ? 30.0 : 60.0
fileprivate let MINIMUM_SECTION_LINE_SPACING: CGFloat = 25.0//isiPhone == true ? 25.0 : 50.0

class CityScreenVC: BaseViewController {

    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var locationName: UILabel!
    
    var selectedLocation: LocationViewModel?
    var responseDataObject: WeatherForecastDataObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationName.text = (selectedLocation?.countryName ?? "...") + "," + (selectedLocation?.locationName ?? "...")
        
        callApi()
        // Do any additional setup after loading the view.
    }
    func callApi() {
        
        openloader()
        Service.shared.fetchData(lat: selectedLocation?.latitude ?? "", lon: selectedLocation?.longitude ?? "", units: "metric") { (responseDataObject, error) in
            self.responseDataObject = responseDataObject
            self.collectionVw.reloadData()
            self.closeLoader()
        }
    }
    
    func openloader() {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        activityIndicatorView.tag = 12345
        self.view.addSubview(activityIndicatorView)
    }
    
    func closeLoader() {
        self.view.viewWithTag(12345)?.removeFromSuperview()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK: UICollectionViewDelegate methods
extension CityScreenVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = self.responseDataObject?.list?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WeatherForcastCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WeatherForcastCell
        
        if indexPath.item%2 == 0
        {
            cell.imvBg.backgroundColor = UIColor(red: 74.0/255, green: 91.0/255, blue: 94.0/255, alpha: 1.0).withAlphaComponent(0.54)
        }
        else
        {
            cell.imvBg.backgroundColor = UIColor(red: 102.0/255, green: 122.0/255, blue: 125.0/255, alpha: 1.0).withAlphaComponent(0.54)
        }
        
        if let dt_txt = responseDataObject?.list?[indexPath.item].dt_txt {
            cell.dateTimeInfoLabel.text = "\(dt_txt)"
        }
        if let obj: MainObject = responseDataObject?.list?[indexPath.item].main {
            if let temp = obj.temp {
                cell.tempartureInfoLabel.text = "Temparature: \(String(describing: temp))"
            }
            if let humidity = obj.humidity {
                cell.humidityInfoLabel.text = "Humidity: \(String(describing: humidity))"
            }
        }
        if let obj: WindObject = responseDataObject?.list?[indexPath.item].wind {
            if let speed = obj.speed {
                var _deg: Int = 0
                if let deg = obj.deg {
                    _deg = deg
                }
                cell.windInfoLabel.text = "Wind Speed: \(String(describing: speed)) Deg: \(String(describing: _deg))"
            }
        }
        if let obj: WeatherObject = responseDataObject?.list?[indexPath.item].weather?.first {
            if let description = obj.description {
                cell.rainChancesInfoLabel.text = "Weather: \(description)"
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let wt = self.view.frame.width - 30
        return CGSize(width: wt, height: 130.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5, bottom: 5.0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
    }
}


