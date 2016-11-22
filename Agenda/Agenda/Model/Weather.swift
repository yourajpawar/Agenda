//
//  Weather.swift
//  
//
//  Created by Pawar, Youraj on 11/21/16.
//
//

import Foundation


struct Weather {
    
    let temperature:Int?
    let summary:String
    let humidity:Float?
    let windSpeed:Float?
    
    var temperatureString:String {
        
        return "Temperature: \(temperature!) F"
    }
    
    var humidityString:String {
        
        return "Humidity: \(humidity! * 100.0)%"
    }
    
    var windSpeedString:String {
        
        return "Wind Speed: \(windSpeed!)"
    }
    
    //keys for json
    static let currentlyKey = "currently"
    static let temperatureKey = "temperature"
    static let summaryKey = "summary"
    static let windSpeedKey = "windSpeed"
    static let humidityKey = "humidity"
    
}
