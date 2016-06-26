//
//  SearchViewController.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/22/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performSegue(sender: AnyObject) {
        self.performSegueWithIdentifier("customSegue", sender: self)
    }
  
}