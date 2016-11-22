//
//  AgendaDataSource.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/18/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation
import UIKit

class AgendaDataSource: GenericDataSource {
    
    
    var currentArray: [Agenda] = [Agenda]()
    var headerTitle: String = ""
    
    init() {
        
        //super init accepts generics that implements DataType protocol
        //Ingredients implements DataType protocol
        super.init(dataObject: AgendasModelManager())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var reuseIdentifier = ""
        
        if tableView.tag == 1 {
            
            reuseIdentifier = "AgendaCell"
        }
        else if tableView.tag == 2{
            
            reuseIdentifier = "AgendaCell2"
        }
        guard let cell  =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AgendaCell
            
            else {
                return AgendaCell()
        }
        
        cell.bindData(agenda: currentArray[indexPath.row])
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return headerTitle
    }
    
    
    
    func updateArrayForSelected(_ dateString:String) {
        
        headerTitle = dateString
        
        if let arr = dataObject.agendasDictionary[dateString] {
            
            currentArray = dataObject.agendasDictionary[dateString]!
        }
        else {
            
            currentArray = []
        }
       
        
    }
}
