//
//  DataSource.swift
//  MyOrder
//
//  Created by Pawar, Youraj on 10/20/16.
//  Copyright © 2016 Pawar, Youraj (Contractor). All rights reserved.
//

import Foundation
import UIKit


class DataSource : NSObject, UITableViewDataSource, SourceType {
    
    var dataObject: DataType
    
    var conditionForAdding: Bool {
        
        return false
    }
    
    func addItemTo(tableView: UITableView){
        
        if conditionForAdding {
            
            dataObject = dataObject.addItemAtIndex(index:0)
            insertTopRowIn(tableview: tableView)
        }
    }
    
    init<A:DataType>(dataObject: A) {
        
        self.dataObject = dataObject
    }
    
    // MARK Protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataObject.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("This method should be overriden")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            //update model
            dataObject = dataObject.deleteItemAt(index: indexPath.row)
            //update view
            deleteRowAtIndexPath(indexPath: indexPath, from:tableView)
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //update model
         dataObject = dataObject.moveItems(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        //update view
        moveRow(fromIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath, in: tableView)
        
    }
    
    func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        
        //EMPTY
    }
}
