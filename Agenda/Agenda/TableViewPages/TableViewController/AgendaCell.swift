//
//  AgendaCell.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/18/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation
import UIKit

class AgendaCell: UITableViewCell {
    
    @IBOutlet weak var roundView:UIView!
    @IBOutlet weak var timeAgenda:UILabel!
    @IBOutlet weak var titleAgenda:UILabel!
    @IBOutlet weak var durationAgenda:UILabel!
    @IBOutlet weak var locationAgenda:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData (agenda: Agenda){
        
        //self.thingImageView =
        roundView.backgroundColor = UIColor.orange
        self.timeAgenda.text = agenda.timeAgenda
        self.titleAgenda.text = agenda.title
        self.locationAgenda.text = "Location: \(agenda.location)"
        self.durationAgenda.text = agenda.duration
    }
}
