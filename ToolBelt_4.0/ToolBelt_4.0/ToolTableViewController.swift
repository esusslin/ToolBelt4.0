//
//  ToolTableViewController.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/26/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class ToolTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    // MARK - Outlets
    
    var tools = [Tool]()
    
    @IBOutlet weak var toolListSearchBar: UISearchBar!
    
    
    // MARK - Load sample tools
    
    let locationManager = CLLocationManager()
//    var currentLat: CLLocationDegrees = 0.0
//    var currentLong: CLLocationDegrees = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
        // Load the sample data.
    }
    
    func searchBarSearchButtonClicked(searchbar: UISearchBar)
    {
        searchbar.resignFirstResponder()
        tools = []
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let searchTerm = String(toolListSearchBar.text!)
        print(searchTerm)
//         print(user_id)
        
//        
//        Alamofire.request(.GET, "http://afternoon-bayou-17340.herokuapp.com/tools/search", parameters: ["keyword": searchTerm, "latitude": currentLat, "longitude": currentLong]) .responseJSON {response in
//            if let JSON = response.result.value {
//                print("\(JSON)")
//                
//                for var i = 0; i < JSON.count; i++ {
//                    
//                    let owner = JSON[i].objectForKey("owner")
//                    let tool = JSON[i].objectForKey("tool")
//                    let title = tool!["title"] as? String!
//                    let ownerId = owner!["id"] as? Int!
//                    let distanceToTool = JSON[i].objectForKey("distance") as! Double
//                    var description: String
//                    
//                    if let des = tool!["description"] as?  NSNull {
//                        description = ""
//                    } else {
//                        description = (tool!["description"] as? String!)!
//                    }
//                    
//                    let myTool = Tool(title: title!, description: description, ownerId: ownerId!, distance: distanceToTool)
//                    
//                    self.tools += [myTool]
//                }
//                self.tableView.reloadData()
//                
//            } else {
//                print("Sent search term, but no response")
//            }
//        }
//        
    }

    

    
    
}

