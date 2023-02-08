//
//  ViewController.swift
//  Weather
//
//  Created by Pavel Shymanski on 3.02.23.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    
    var weatherManager = WeatherManager()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCityTextField.delegate = self
        
    }
}


extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: Any) {
        searchCityTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCityTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchCityTextField.text {
            
            weatherManager.fetchWeather(cityName: city) { data, error in
                
                guard let main = data?.weatherDescription?[0].main,
                      let temperature = data?.mainWeatherData?.temperature,
                      let feelslike = data?.mainWeatherData?.feelslike,
                      let _ = data?.weatherDescription?[0].id  else {return}
                
                self.cityLabel.text = city
                self.temperatureLabel.text = "\(main) \(String(format: "%.0f", temperature))°"
                self.feelsLikeLabel.text = "Fells like \(String(format: "%.0f", feelslike))°"
                self.imageViewWeather.image = (UIImage(systemName:(data?.conditionName)!))
                
            }
        }
        
        searchCityTextField.text = ""
    }
    
}










