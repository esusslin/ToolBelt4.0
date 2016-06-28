//
//  ToolTableViewCell.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/27/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import UIKit
class ToolTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet var toolListTitle: UILabel!
    @IBOutlet var distance: UILabel!
 
    @IBOutlet var toolListDescription: UILabel!

    var ownerId = Int()
    
}
