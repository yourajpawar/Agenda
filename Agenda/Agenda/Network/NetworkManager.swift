//
//  NetworkManager.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/21/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation


class NetworkManager {
    
    func fireGetWeatherApi(_ userIDCallback:@escaping (Weather?)->Void){
        
        makeGetCall(url:APIS.GET_CURRENT_WEATHER_URL.rawValue ,{ jsonObject in
            
            print("Response is \(jsonObject)")
            
            guard let weatherDictionary = jsonObject?[Weather.currentlyKey] as? Dictionary<String,AnyObject> else {
                
                print("Error in getting weather dictionary")
                return
            }
            
            let temperature = weatherDictionary[Weather.temperatureKey] as! Int
            let summary = weatherDictionary[Weather.summaryKey] as! String
            let humidity = weatherDictionary[Weather.humidityKey] as! Float
            let windSpeed = weatherDictionary[Weather.windSpeedKey] as! Float
            
            let weather = Weather(temperature: temperature,summary: summary ,humidity: humidity,windSpeed: windSpeed )
            
            userIDCallback(weather)
        })
    }
    
    
    func makeGetCall(url:String,_ completionHandler:@escaping (Dictionary<String, AnyObject>?)->Void)  {
        // Set up the URL request
        let endPoint: String = url
        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = fireRequest(session: session, urlRequest: urlRequest, completionHandler: completionHandler)
        
        task.resume()
    }
    
    func makePostCall(params : Dictionary<String, AnyObject>, url : String, _ completionHandler:@escaping (Dictionary<String, AnyObject>?)->Void) {
        
        let endPoint: String = url
        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        let jsonData = try! JSONSerialization.data(withJSONObject:params, options:.prettyPrinted)
        
        _ = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        
        
        
        
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = fireRequest(session: session, urlRequest: request, completionHandler: completionHandler)
        
        task.resume()
    }
    
    
    
    func fireRequest(session: URLSession,urlRequest:URLRequest, completionHandler:@escaping (Dictionary<String, AnyObject>?)->Void) ->URLSessionDataTask {
        
        return session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling Request ")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let responseString = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)
            
            if responseString?.length == 0 {
                
                
                completionHandler((["value":"empty-response for \(response?.url?.lastPathComponent)"] as AnyObject) as? Dictionary<String, AnyObject>)
            }else {
                
                // parse the result as JSON, since that's what the API provides
                do {
                    
                    guard let jsonDictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    
                    print("The json is: " + jsonDictionary.description)
                    
                    
                    //callback
                    completionHandler((jsonDictionary as AnyObject) as? Dictionary<String, AnyObject>)
                    
                    
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            
        }
        
    }
    
}
