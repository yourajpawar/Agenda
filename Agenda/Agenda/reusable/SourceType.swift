//
//  SourceType.swift
//  MyOrder
//
//  Created by Pawar, Youraj on 10/20/16.
//  Copyright © 2016 Pawar, Youraj (Contractor). All rights reserved.
//

import Foundation
import UIKit


protocol SourceType: UITableViewDataSource {
    
    var dataObject : DataType {get set}
    
    func insertTopRowIn(tableview:UITableView)
    func deleteRowAtIndexPath(indexPath:IndexPath, from tableview:UITableView)
    func moveRow(fromIndexPath:IndexPath, toIndexPath:IndexPath, in tableview:UITableView)
    func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation)
}

extension SourceType {
    
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
