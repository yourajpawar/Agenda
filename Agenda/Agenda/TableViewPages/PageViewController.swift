//
//  TablePageViewController.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/14/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{

    var customViewControllers:[UIViewController] = [UIViewController]()
    
    var selectedCurrentDate:Date = Date() {
        
        didSet{
        
            if currentViewController != nil {
                
                let dateString = moment(date: selectedCurrentDate as NSDate).format(dateFormat: "MMMM d, yyyy")

                
                (currentViewController as! MainPageTableViewController).updateForSelectedDate(dateString)
            }
        }
    }
    
    var callback:(_ select:Date)->Void = { select in }
    
    var currentViewController:UIViewController!

    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        self.title = "Calendar"
//        self.tabBarItem.title = "Calendar"
       
        self.delegate = self
        self.dataSource = self
        

        let pagesStoryBoard = UIStoryboard.init(name: "TableViewPages", bundle: nil)
        
        let mainTableViewController = pagesStoryBoard.instantiateViewController(withIdentifier: "MainPage")
        
         let pageTableViewController = pagesStoryBoard.instantiateViewController(withIdentifier: "Page")
        
        customViewControllers.append(mainTableViewController)
        customViewControllers.append(pageTableViewController)
        
        currentViewController = mainTableViewController
        
        //Setting up first TableViewController on main page
        self.setViewControllers([mainTableViewController], direction:.forward, animated: true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAt(_ index:Int) -> UIViewController? {
        
        guard index < customViewControllers.count else {
            
            return nil
        }
     
        return customViewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        
        print((pendingViewControllers[0] as! MainPageTableViewController).tableView.tag)
        
        currentViewController = pendingViewControllers[0]
    }
    
    //MARK: UIPageViewController Delegates and Datasource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        var index = customViewControllers.index(of: viewController)
        
    
        index = index! - 1
        
        if index == -1{
            index = 1
        }
        
        index = index! % customViewControllers.count
        
//        currentViewController = customViewControllers[index!]
        
        let prevDate = self.previousDay()
        
        //Callabck
        self.callback(prevDate)
        
//        let dateString = moment(date: prevDate as NSDate).format(dateFormat: "MMMM d, yyyy")
        
//        (customViewControllers[index!] as! MainPageTableViewController).updateForSelectedDate(dateString)
        
        
        
        return customViewControllers[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        var index = customViewControllers.index(of: viewController)
        index = index! + 1;
        index = index! % customViewControllers.count
        
        
//         currentViewController = customViewControllers[index!]
        
        //Callabck
        let nextDate = self.nextDay()
        
        //update cal
        self.callback(nextDate)
        
//        let dateString = moment(date: nextDate as NSDate).format(dateFormat: "MMMM d, yyyy")

//        (customViewControllers[index!] as! MainPageTableViewController).updateForSelectedDate(dateString)
        
       
        
        return customViewControllers[index!]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func previousDay()->Date {
        
        let calendar = Calendar.current
        let previousDay = calendar.date(byAdding: .day, value: -1, to: selectedCurrentDate)
        
        selectedCurrentDate = previousDay!
        
        return previousDay!
    }
    
    func nextDay()-> Date {
        
        let calendar = Calendar.current
        let nextDay = calendar.date(byAdding: .day, value: 1, to: selectedCurrentDate)
        
        selectedCurrentDate = nextDay!
        
        return nextDay!
    }
    
    
    
}
