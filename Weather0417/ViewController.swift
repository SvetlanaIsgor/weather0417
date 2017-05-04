//
//  ViewController.swift
//  Weather0417
//
//  Created by kirill lukyanov on 04.05.17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realm = try! Realm()
        var onlineWeather: WeatherData = WeatherData()
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=London&appid=cc43de317c7b45042d6dd7d09ee12d74"
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                onlineWeather.city_name = json["city"]["name"].stringValue
                print(json)
                try! realm.write {
                    realm.add(onlineWeather)
                }
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

