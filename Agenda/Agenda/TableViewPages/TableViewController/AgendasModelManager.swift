//
//  AgendasModelManager.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/18/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation

struct AgendasModelManager :DataTypeProtocol {
    
    var agendasDictionary: [String : [Agenda]]
    
    init (){
        
        self.agendasDictionary = Agenda.randomAgendaDictionary
    }
    
    init(agendas:[String:[Agenda]]) {
        
        self.agendasDictionary = agendas
    }
    
   
    
    subscript(dateString: String) -> [Agenda]{
        
        return self.agendasDictionary[dateString]!
        
    }
    
    
    func agendaFor(_ dateString:String) -> [Agenda] {
        
        guard dateString.characters.count == 0 else {
            
            return Agenda.getRandomAgendas()
        }
        
        return  self.agendasDictionary[dateString]!
    }
    
    //MARK: DataTypeProtocol
    
    //Add items to array
    func addNewRandomData() -> AgendasModelManager {
        
        return AgendasModelManager.init()
    }
    
    func numberOfItemsFor(_ dateString: String) -> Int {
        
        return self[dateString].count
    
    }
    
    func numberOfItems() -> Int {
        
       return 0
    }
    
    var numberOfKeysInDictionary: Int {
        
        return self.agendasDictionary.keys.count
    }
    
    
}
