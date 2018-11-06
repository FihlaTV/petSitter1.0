//
//  InfoViewController.swift
//  petSitter
//
//  Created by Harold on 8/22/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import Firebase

/**
 
 NEED TO CHECK FOR THIS CLASS IF USING A DIFFERENT EMAIL WILL INCREASE THE REQUESTS COMING IN
 
 **/
class InfoViewController: UIViewController{
    
    var userInfo = myUser()
    var userString = String()
    var userString2 = String()
    var userData:[myUser] = []
    var identifier:String?
    var selectedUser = myUser()
    var deleteKey = String()
    var isRequested = false
    
    //error: when going back to map screen
    @IBAction func backToMap(_ sender: Any) {
        performSegue(withIdentifier: "backToMap", sender: nil)
    }
    
    
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!
    var ref: DatabaseReference!
    //request number shouldn't be initialized at 0, if there is a previous count it will have to take that from the previous class
    var requestNumber = 0
    var info = [String:String]()
    var currentUserEmail = String()
    
    
    
    @IBAction func connectionRequest(_ sender: Any) {
        
        
        for user in userData{
            let isEqual = (user.pet_owner == selectedUser.pet_owner)
            if isEqual{
                //cant use email as key, so retracting request error will persist until used key is switched
                //over a unique key per person
                info.updateValue(currentUserEmail, forKey: "Request \(self.requestNumber)")
                self.requestNumber = self.requestNumber + 1
                ref.child("Users").child(user.pet_owner!).child("Request").setValue(info)
                
                
                
            }
        
        denyButton.setTitle("Remove Request", for: .normal)
        connectionButton.setTitle("Pending Request", for: .normal)
        connectionButton.isEnabled = false
        messageButton.isHidden = false
        paymentButton.isHidden = false
        isRequested = true
        denyButton.isHidden = false
        
        viewDidLoad()
        //need to send the users email to the requested users user file in the database
    }
    //currently runs apparently infinitely, but does add to the list accordingly
    
    
    }
    
    
    @IBAction func denyRequest(_ sender: Any) {
        connectionButton.setTitle("Connection Request", for: .normal)
        messageButton.isHidden = true
        paymentButton.isHidden = true
        //finds the key associated with the current user's email. Regular key search will not work because
        //the key uses an int that changes frequently
        //**error: will not be able to see the keys because the current data doesn't know that the requests
        //have been updated
        /**
        for string in selectedUser.requests{
            var isEqual = (string.value == currentUserEmail)
            if isEqual{
                deleteKey = string.key
                
            }
        }
        **/
    ref.child("Users").child(selectedUser.pet_owner!).child("Request").child(currentUserEmail).removeValue()
    connectionButton.isEnabled = true
    denyButton.isHidden = true
    isRequested = false
    }
    
    func remove(parentA: String, child:String){
        
    }
    @IBAction func messages(_ sender: Any) {
    }
    @IBAction func payment(_ sender: Any) {
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        messageButton.isHidden = true
        paymentButton.isHidden = true
        //finds user that matches the identifier
        for user in userData{
            let isEqual = (user.pet_owner == identifier)
            if isEqual{
                selectedUser = user
                
            }
        }
        if selectedUser.requests.count > 0{
            requestNumber = selectedUser.requests.count + 1
        }
        else{
            requestNumber = 1
        }
        for string in selectedUser.requests{
            let isEqual = (string.value == currentUserEmail)
            if isEqual{
                connectionButton.setTitle("Pending Request", for: .normal)
                connectionButton.isEnabled = false
                denyButton.setTitle("Remove Request", for: .normal)
                isRequested = true
            }
        }
        if isRequested == false{
            denyButton.isHidden = true
        }
        //Still need to handle current connections to user
        
        
        
        
        //displays specific users information
        userString = "Address: " + selectedUser.address! + "\n" + "Allergies: " + selectedUser.allergies! + "\n" + "Email: " + selectedUser.email!
        userString2 = "Gender: " + selectedUser.gender! + "\n" + "Latitude: " + "test" + "\n" + "Longitude: " + "test" + "\n" + "Pet_owner: " + selectedUser.pet_owner! + "\n" + "Pictures: " + selectedUser.pictures! + "\n" + "Vet: " + selectedUser.vet!
        
        
        
        infoLabel.text = userString + "\n" + userString2
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMap"{
            let main = segue.destination as! ViewController
            main.sentEmail = currentUserEmail
        }
    }
}
