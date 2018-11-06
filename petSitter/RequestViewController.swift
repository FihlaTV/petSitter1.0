//
//  RequestViewController.swift
//  petSitter
//
//  Created by Harold on 9/17/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    
    var requestAmount = Int()
    var userData:[myUser] = []
    var requestees = [String:String]()
    var currentUser = myUser()
    
    @IBOutlet weak var requestLabel: UILabel!
    
    @IBAction func continueToRequests(_ sender: Any) {
        performSegue(withIdentifier: "requestInfoSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if requestAmount == 1{
            requestLabel.text = "You have \(requestAmount) request!"
        }
        else{
            requestLabel.text = "You have \(requestAmount) requests!"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let request = segue.destination as! RequestInfoViewController
        request.requestCount = requestAmount
        request.userData = userData
        request.requestees = requestees
        request.currentUser = currentUser
        
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
