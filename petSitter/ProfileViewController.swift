//
//  ProfileViewController.swift
//  petSitter
//
//  Created by Harold on 9/18/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseCore
import Firebase

class ProfileViewController: UIViewController {
    
    var user:myUser?

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = user?.profilePics
        

        
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
