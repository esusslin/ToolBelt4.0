//
//  MyAnnotation.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/27/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import MapKit
import AddressBook

class MyAnnotation: NSObject, MKAnnotation
{
    let identifier : Int?
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(identifier: Int, title: String, subtitle: String, coordinate: CLLocationCoordinate2D)
    {
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
