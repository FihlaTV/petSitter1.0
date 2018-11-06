//
//  PopUpViewController.swift
//  petSitter
//
//  Created by Harold on 8/29/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import Foundation
import FirebaseStorage


class PopUpViewController: UIViewController {

    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var allergies: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var petOwner: UITextField!
    
    @IBOutlet weak var vet: UITextField!
    
    var myLat:CLLocationDegrees!
    var myLong:CLLocationDegrees!
    var ref: DatabaseReference!
    var sentEmail:String?
    var owner:String?
    
    @IBAction func next(_ sender: Any) {
        let ad = address.text
        let al = allergies.text
        sentEmail = email.text
        let gen = gender.text
        owner = petOwner.text
        let ve = vet.text
        
        
        
        let info = ["address": ad,
                    "allergies": al,
                    "email": sentEmail,
                    "gender": gen,
                    "latitude": myLat,
                    "longitude": myLong,
                    "pet_owner": owner,
                    "pictures": "no",
                    "vet": ve] as [String : Any]
        
        ref.child("Users").child(owner!).setValue(info)
        
        ref.child("Users").child(owner!).child("Connections").setValue("")
        
        performSegue(withIdentifier: "imageSegue", sender: self)
        
        
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let image = segue.destination as! ImageViewController
        image.email = sentEmail
        image.owner = owner
        
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func register(_ sender: UIButton) {
        
        
        
        
        
    }
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
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
