//
//  SearchListController.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/24/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class ListViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    var tools = [Tool]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLat: CLLocationDegrees = 0.0
    var currentLong: CLLocationDegrees = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchBar.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 116
//        self.tableView.registerClass(ToolTableViewCell.self, forCellReuseIdentifier: "ToolTableViewCell")
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
//        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = locations.last! as CLLocation
        currentLat = location.coordinate.latitude
        currentLong = location.coordinate.longitude
     
    }
    
    func searchBarSearchButtonClicked(searchbar: UISearchBar)
    {
        searchbar.resignFirstResponder()
        tools = []
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let searchTerm = String(searchBar.text!)
        print(searchTerm)
        
        
        Alamofire.request(.GET, "http://localhost:3000/tools/search", parameters: ["keyword": searchTerm, "latitude": currentLat, "longitude": currentLong,
            "user": userid]) .responseJSON {response in
                if let JSON = response.result.value {
                    print("\(JSON)")
                    
                    for i in 0 ..< JSON.count {
                        
                        let owner = JSON[i].objectForKey("owner")
                        let tool = JSON[i].objectForKey("tool")
                        let title = tool!["title"] as! String!
                        let ownerId = owner!["id"] as! Int!
                        let distanceToTool = JSON[i].objectForKey("distance") as! Double
                        var description: String
                        
                        if let des = tool!["description"] as?  NSNull {
                            description = ""
                        } else {
                            description = (tool!["description"] as? String!)!
                        }
                        
                        let myTool = Tool(title: title!, description: description, ownerId: ownerId!, distance: distanceToTool)
                        
                        
                        self.tools.append(myTool)
                        
                    }
                    
//                    dispatch_async(dispatch_get_main_queue(), {
                    
                        self.refresh()
                        
//                    })
                
                } else {
                    print("Sent search term, but no response")
                }
        }
        
    }
    
    func refresh() {
    
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.reloadData()
        });
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("hello")
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tools.count)
        return tools.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellIdentifier = "ToolTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as!ToolTableViewCell
        let tool = tools[indexPath.row]
        
       
        cell.title.text = tool.title
        //       print(tool.title)
        //        cell.toolListDescription?.text = tool.description
        cell.ownerId = tool.ownerId
        //        print(tool.ownerId)
        //       print(tool.distance)
        //        cell.distance?.text = "\(tool.distance)mi"
        
        
        print(cell)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if  segue.identifier == "contactOwnerSegue",
                let destination = segue.destinationViewController as? ChatController,
                toolIndex = tableView.indexPathForSelectedRow?.row
            {
                destination.contact = tools[toolIndex].ownerId
            }
        }
    
        func tapRowAtIndex(index:Int) {
            let rowToSelect:NSIndexPath = NSIndexPath(forRow: index, inSection: 0)
            self.tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
//            self.tableView(self.tableView, didSelectRowAtIndexPath: rowToSelect)
    
    
//        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            performSegueWithIdentifier("contactOwnerSegue", sender: ToolTableViewCell.self)
//        }

    }
}