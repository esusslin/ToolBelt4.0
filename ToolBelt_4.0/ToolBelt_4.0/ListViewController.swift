//
//  SearchListController.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/24/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit

class ListViewController: SearchViewController, UISearchBarDelegate {
    
    var searchBar: UISearchBar!
    var mytools = [Tool]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
//        self.userLocation = UserLocation()
        
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self
        self.searchBar.placeholder = "e.g. sushi, cheeseburger"
        self.navigationItem.titleView = self.searchBar
    }

}