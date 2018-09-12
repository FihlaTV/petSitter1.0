//
//  LoginViewController.swift
//  petSitter
//
//  Created by Harold on 8/29/18.
//  Copyright © 2018 Harold. All rights reserved.
//
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Foundation

protocol MyDelegate2{
    func fetchProfile(email:String)
}

class LoginViewController:UIViewController, FBSDKLoginButtonDelegate{
   
    @IBOutlet weak var mapButton: UIButton!
    @IBAction func toMap(_ sender: Any) {
        performSegue(withIdentifier: "mainSegue", sender: self)
    }
    var sentEmail = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FBSDKAccessToken.current() != nil{
            let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
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
                self.fetchProfile(email1: email)
                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    let destinationVC = segue.destination as! ViewController
                    destinationVC.sentEmail = email
                }
            })
           mapButton.isHidden = false
        }
        else{
        mapButton.isHidden = true
        let fbLogin = FBSDKLoginButton()
        fbLogin.readPermissions = ["public_profile", "email", "user_friends"]
        fbLogin.delegate = self
        
        if let token = FBSDKAccessToken.current(){
            //performSegue(withIdentifier: "mainSegue", sender: self)
        }
        fbLogin.center = self.view.center
        self.view.addSubview(fbLogin)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
        let button = UIButton(frame: CGRect(x:100, y:100, width: 100, height: 50))
        button.setTitle("Go to Map", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
            self.fetchProfile(email1: email)
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let destinationVC = segue.destination as! ViewController
                destinationVC.sentEmail = email
                
            }
            
            
        })
        
        
    }
    
    @objc func buttonAction(sender: UIButton!){
        performSegue(withIdentifier: "mainSegue", sender: self)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //what to do on logout
    }
    
    func fetchProfile(email1:String){
        sentEmail = email1 
        infoClicked(_sender: self)
        
        
    }
    @objc func infoClicked(_sender: AnyObject?){
        performSegue(withIdentifier: "mainSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        destinationVC.sentEmail = sentEmail
        
    }
}
