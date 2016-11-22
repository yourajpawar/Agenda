//
//  AgendaProtocol.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/17/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation


protocol AgendaProtocol {
    
    var title : String {get}
    
    var subTitle : String {get}
    
    var location : String {get}
    
    var timeAgenda: String {get}
    
    var typeAgenda : AGENDATYPE {get}
    
    func description () -> String
}

extension AgendaProtocol {
    
    //default implementation
    func description () -> String {
        
        return "Agenda title is \(title) and category \(typeAgenda.rawValue)"
    }
}
