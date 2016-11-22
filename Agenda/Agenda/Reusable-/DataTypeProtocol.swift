//
//  DataTypeProtocol.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/18/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation


protocol DataTypeProtocol {
    
    var numberOfKeysInDictionary: Int {get}
    func addNewRandomData() -> Self
    func numberOfItemsFor(_ dateString:String) -> Int
    var agendasDictionary:[String:[Agenda]] {get}
    
}
