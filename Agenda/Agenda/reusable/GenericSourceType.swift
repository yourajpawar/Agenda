//
//  GenericSourceType.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/18/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation
import UIKit

protocol GenericSourceType: UITableViewDataSource {
    
    var dataObject : DataTypeProtocol {get set}
    
    func insertTopRowIn(tableview:UITableView)
    func deleteRowAtIndexPath(indexPath:IndexPath, from tableview:UITableView)
    func moveRow(fromIndexPath:IndexPath, toIndexPath:IndexPath, in tableview:UITableView)
}

extension GenericSourceType {
    
    func insertTopRowIn(tableview:UITableView){
        
        tableview.insertRows(at: [IndexPath(row:0, section:0)], with: .fade)
    }
    
    func deleteRowAtIndexPath(indexPath:IndexPath, from tableview:UITableView){
        
        tableview.deleteRows(at: [indexPath], with: .fade)
    }
    
    func moveRow(fromIndexPath:IndexPath, toIndexPath:IndexPath, in tableview:UITableView) {
        
        tableview.moveRow(at: fromIndexPath, to: toIndexPath)
    }
    
}
