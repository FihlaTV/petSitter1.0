//
//  LogoutViewController.swift
//  petSitter
//
//  Created by Harold on 9/5/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Foundation

class LogoutViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        performSegue(withIdentifier: "backtoLogin", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLogin = FBSDKLoginButton()
        fbLogin.readPermissions = ["public_profile", "email", "user_friends"]
        fbLogin.delegate = self
        
        if let token = FBSDKAccessToken.current(){
            //performSegue(withIdentifier: "mainSegue", sender: self)
        }
        fbLogin.center = self.view.center
        self.view.addSubview(fbLogin)
        

        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
        let button = UIButton(frame: CGRect(x:100, y:100, width: 100, height: 50))
        self.view.addSubview(button)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print(result)
                
            }
            var email = String()
            let data:[String:AnyObject] = result as! [String : AnyObject]
            email.append(data["email"]! as! String)
           
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let destinationVC = segue.destination as! ViewController
                destinationVC.sentEmail = email
                
            }
            
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
