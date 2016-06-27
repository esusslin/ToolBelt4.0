//
//  Tool.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/26/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//
import UIKit

class Tool {
    var title: String
    var description: String
    var ownerId: Int
    var distance: Double
    
    // MARK: Initialization
    
    init(title: String, description: String, ownerId: Int, distance: Double) {
        
        // Initialize tool with title and description
        self.title = title
        self.description = description
        self.ownerId = ownerId
        self.distance = distance
    }
}
