//
//  WeatherData.swift
//  Weather
//
//  Created by Pavel Shymanski on 3.02.23.
//

import Foundation

struct WeatherData:Decodable {
    
    let mainWeatherData: MainWeatherData?
    let weatherDescription : [Weather]?
    let cityName: String?
    
    
    var conditionName:String? {
        guard let  condition = weatherDescription?[0].id else {return nil}
        switch condition {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
  
    enum CodingKeys: String, CodingKey {
        case mainWeatherData = "main"
        case weather = "weather"
        case cityName = "name"
       
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.mainWeatherData =  try? container.decode(MainWeatherData.self, forKey: .mainWeatherData)
        self.weatherDescription = try? container.decode([Weather].self, forKey: .weather)
        self.cityName = try? container.decode(String.self, forKey:.cityName)
        
    }
    
}


struct MainWeatherData : Decodable {
    let temperature: Double?
    let feelslike: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelslike = "feels_like"
       
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temperature =  try? container.decode(Double.self, forKey: .temperature)
        self.feelslike =  try? container.decode(Double.self, forKey: .feelslike)
        
    }
}


struct Weather : Decodable{
    let  main: String?
    let id: Int?
    
}

