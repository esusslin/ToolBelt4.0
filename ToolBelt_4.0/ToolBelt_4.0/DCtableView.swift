//
//  DCtableView.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/23/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import Foundation
import UIKit
class DCtableView: UITableView, UITableViewDelegate
{
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var hitView = super.hitTest(point, withEvent: event)
        if (point.y<0){
            return nil
        }
        return hitView
    }
    
}
