//
//  GenericDataSource.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/18/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation
import UIKit


class GenericDataSource : NSObject, UITableViewDataSource, GenericSourceType {
    
    var dataObject: DataTypeProtocol
    
    var conditionForAdding: Bool {
        
        return false
    }
    
    init<A:DataTypeProtocol>(dataObject: A) {
        
        self.dataObject = dataObject
    }
    
    // MARK Protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        fatalError("This method should be overriden")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("This method should be overriden")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        fatalError("This method should be overriden")

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        fatalError("This method should be overriden")

        
    }
    
   
}
