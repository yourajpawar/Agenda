//
//  AgendaConatinerViewController.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/15/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import UIKit


class AgendaConatinerViewController: UIViewController {

     var calendar: CalendarView!
     var pageViewController:PageViewController! = nil
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        
        pageViewController = self.childViewControllers[0] as? PageViewController
        
        pageViewController!.callback = { date in
        
        self.selectDateonCalendar(date: date)
        
        }
    }
    
    func setup() {
        
        // Add calendar view
        //
        calendar = CalendarView(frame: CGRect(x:0, y:35, width:360, height:260))
        calendar.translatesAutoresizingMaskIntoConstraints = false
        let date: NSDate = NSDate()
        calendar.selectDate(moment(date:date))
        calendar.delegate = self
        self.view.addSubview(calendar)
        
        calendar.updateConstraints()
        
        //Weather Request
        NetworkManager.init().fireGetWeatherApi({ weather in
            
            
            print(weather!)
            
            self.temperatureLabel.text = weather?.temperatureString
            self.humidityLabel.text = weather?.humidityString
            
        })
    }
    
    func selectDateonCalendar(date:Date) {
        
        //Main Queue
        DispatchQueue.main.async {
            
             self.calendar.selectDate(moment(date: date as NSDate))
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AgendaConatinerViewController: CalendarViewDelegate {
    
    public func calendarDidSelectDate(_ date: Moment) {
        title = date.format(dateFormat: "MMMM d, yyyy")
        
        if let pageViewController = self.pageViewController {
            
            pageViewController.selectedCurrentDate = date.date as Date
            
        }
        
        
        print(title!)
    }
    
    public func calendarDidPageToDate(_ date: Moment) {
        title = date.format(dateFormat: "MMMM d, yyyy")
        
        
        if let pageViewController = self.pageViewController {
            
            pageViewController.selectedCurrentDate = date.date as Date
            
        }
        
        
        print(title!)
    }
    
}

