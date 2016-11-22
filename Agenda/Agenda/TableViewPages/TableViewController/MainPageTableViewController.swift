//
//  MainPageTableViewController.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/14/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import UIKit

class MainPageTableViewController: UITableViewController {
    
    var agenDataSource: AgendaDataSource! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        agenDataSource = AgendaDataSource()
        
        self.tableView.dataSource = agenDataSource
        self.tableView.delegate = self
        
        updateForSelectedDate(moment(date: Date() as NSDate).format(dateFormat: "MMMM d, yyyy"))
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 77.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateForSelectedDate(_ dateString:String) {
        
        guard agenDataSource != nil else {
            
            return
        }
        agenDataSource.updateArrayForSelected(dateString)
        
        self.tableView.reloadData()
    }
    
    
}
