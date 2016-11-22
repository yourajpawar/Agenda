//
//  AppEnums.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/17/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation


enum AGENDATYPE: String {
    
    case OUTDOOR
    
    case INDOOR
    
}

enum APIS:String{
    
    case GET_CURRENT_WEATHER_URL = "https://api.darksky.net/forecast/3b369fda7cb81f6e52126d0c28bba8a8/37.793829,-122.394601?exclude=minutely,daily,alerts,flags,hourly"
   
    
}
