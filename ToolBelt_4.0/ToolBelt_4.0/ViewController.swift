//
//  ViewController.swift
//  ToolBelt_4.0
//
//  Created by Emmet Susslin on 6/19/16.
//  Copyright © 2016 Emmet Susslin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email", "user_friends"]
        return button
    }()
    
        let email = ""
        let first_name = ""
        let last_name = ""
        let image = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(loginButton)
        loginButton.center = self.view.center
        loginButton.delegate = self
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
            super.performSegueWithIdentifier("oauthtotabs", sender: self)
        }
        
    }
    
    func fetchProfile() {
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
                        let email = (result["email"] as? String)!
                        let first_name = (result["first_name"] as? String)!
                        let last_name = (result["last_name"] as? String)!
                        let image = (result["picture"]!!["data"]!!["url"] as? String)!
            
            Alamofire.request(.POST, "http://localhost:3000/users", parameters: ["email": email, "first_name": first_name, "last_name": last_name, "image": image]).responseJSON { response in
                if let JSON = response.result.value {
                    print("hello!")
                    print(JSON)
                    let user_id = (JSON["user_id"] as! Int)
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(user_id, forKey: "toolBeltUserID")
                    defaults.synchronize()
                }
            }

        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
       print("login complete")
        fetchProfile()
        super.performSegueWithIdentifier("oauthtotabs", sender: self)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
//        print("user logged out..")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

