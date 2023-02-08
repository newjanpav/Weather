//
//  WeatherManager.swift
//  Weather
//
//  Created by Pavel Shymanski on 3.02.23.
//

import Foundation


class WeatherManager {

    enum WeatherDataparamsKey : String {
        case apiKey = "appid"
        case units = "units"
        case city = "q"

    }
    
    let baseUrlString = "https://api.openweathermap.org"
    let weatherPatch = "/data/2.5/weather"
    let apiKey = "4529d030d5423024a977f7065add7d8c"
    let units = "metric"
    
    
    func fetchWeather(cityName: String, completionHandler: @escaping(WeatherData?, Error?)->Void)  {
        
        var components = URLComponents(string: baseUrlString)
        components?.path = weatherPatch

        let apiKeyItem = URLQueryItem(name: WeatherDataparamsKey.apiKey.rawValue, value: apiKey)
        let cityItem = URLQueryItem(name: WeatherDataparamsKey.city.rawValue, value: cityName)
        let unitsItem = URLQueryItem(name: WeatherDataparamsKey.units.rawValue, value: units)
        components?.queryItems = [cityItem,apiKeyItem,unitsItem]
        
        guard let url = components?.url else { return  }

       let request = URLRequest(url:url )
       let dataTask =  URLSession.shared.dataTask(with: request) { data, responce, error in
           guard  error == nil, let data = data  else {completionHandler(nil,error)
               return
           }
           let decoder = JSONDecoder()
           let weatherData = try? decoder.decode(WeatherData.self, from: data)
        
           DispatchQueue.main.async {
               completionHandler(weatherData,nil)
           }
        }
        dataTask.resume()
        
    }
}
        
        
        
        
      
        
        
        
        
        
        
   
    
    
    
    
    
    

