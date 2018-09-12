//
//  InfoViewController.swift
//  petSitter
//
//  Created by Harold on 8/22/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var userInfo = myUser()
    var userString = String()
    var userString2 = String()
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userString = "Address: " + userInfo.address! + "\n" + "Allergies: " + userInfo.allergies! + "\n" + "Email: " + userInfo.email!
        userString2 = "Gender: " + userInfo.gender! + "\n" + "Latitude: " + "test" + "\n" + "Longitude: " + "test" + "\n" + "Pet_owner: " + userInfo.pet_owner! + "\n" + "Pictures: " + userInfo.pictures! + "\n" + "Vet: " + userInfo.vet!
        
        
        
        infoLabel.text = userString + "\n" + userString2
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
