//
//  ViewController.swift
//  day07
//
//  Created by Vladyslav PALAMARCHUK on 10/10/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textRequestRecast: UITextField!
    @IBOutlet weak var labelTextRecast: UILabel!
    
    let bot = RecastAIClient(token: "2310945ba4eb5a7bec55caf8122e508a")
    let darkSkyClient = DarkSkyClient(apiKey: "b90cbab3d5de329e2e81c9f59ecf287f")
    
    @IBAction func weatherSearcher(_ sender: UIButton) {
        if (textRequestRecast.text == "") {
            textRequestRecast.text = "Kyiv"
        }
        bot.textRequest(textRequestRecast.text!, successHandler: { (res) in
            
            if res.intent()?.slug == "get-weather" {
                if let location = res.get(entity: "location") {
                    self.getWeatherFromLocal(lat: location["lat"] as! Double, lng: location["lng"] as! Double)
                    print(location["lat"]!, location["lng"]!)
                } else {
                    self.labelTextRecast.text = "City not found!"
                }
            }
        }) { (er) in
            self.labelTextRecast.text = "API error!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getWeatherFromLocal(lat: Double, lng: Double) {
        darkSkyClient.getForecast(location: CLLocationCoordinate2D(latitude: lat, longitude: lng)) {
            (result) in
            switch result {
            case .success(let forecast, _):
                if let currently = forecast.currently {
                    let weather = currently.summary!
                    let temp = currently.temperature!
                    
                    DispatchQueue.main.async {
                        self.labelTextRecast.text = "\(self.textRequestRecast.text!): weather is \(weather) and the temperature is \(Int((temp - 32) * 5/9))°C (\(temp) F)."
                    }
                } else {
                    print("err")
                    self.labelTextRecast.text = "City not found!"
                }
            default:
                print("default==", result)
                self.labelTextRecast.text = "API error!"
            }
        }
    }

}

