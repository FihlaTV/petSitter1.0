//
//  RequestInfoViewController.swift
//  petSitter
//
//  Created by Harold on 9/17/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import Firebase



class RequestInfoViewController: UITableViewController, buttonDelegate {
    func acceptTapped(requestNum: Int) {
        //**Still has to get the current connection information from each person and use that as count**
        //get the info from the account of the requestNum index and move to connection list
        //print(requestNum)
        var requestee: myUser = subData[requestNum]
        
        //connection
        //need to fix so it will add to subfolder/add more connections instead of overwriting the previous
        //need current users profile
        userConnectionInfo.updateValue(requestee.email!, forKey: "Connection \(userConnectionInfo.count)")
        ref.child("Users").child(currentUser.pet_owner!).child("Connections").setValue(userConnectionInfo)
        //sets connection in requestee account
        requesteeConnectionInfo.updateValue(currentUser.email!, forKey: "Connection \(requesteeConnectionInfo.count)")
        ref.child("Users").child(requestee.pet_owner!).child("Connections").setValue(requesteeConnectionInfo)
    }
    
    func denyTapped(requestNum:Int) {
        //get info from account of requestNum index and delete
        
    }
    
    
   
    @IBOutlet var requestTableview: UITableView!
    
   
    
    
    var userData:[myUser] = []
    var requestCount = Int()
    var requestees = [String:String]()
    var subData:[myUser] = []
    var ref:DatabaseReference!
    var currentUser = myUser()
    var userConnectionInfo = [String:String]()
    var requesteeConnectionInfo = [String:String]()
    
  

    
    
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        requestTableview.delegate = self
        requestTableview.dataSource = self
        ref = Database.database().reference()
        
        for user in userData{
            for email in requestees{
                let isEqual = (email.value == user.email)
                if isEqual{
                    subData.append(user)
                }
                
            }
        }
        //self.tableView.register(CustomCell.self, forCellReuseIdentifier: "Custom")
        
        
        

        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let personData = subData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom") as! CustomCell
        //cell.mainImage = data[indexPath.row].image
        cell.setImage(pic: personData.profilePics!)
        cell.setText(text: personData.pet_owner!)
        cell.setNum(num: indexPath.row)
        
        cell.delegate = self
        
        
        //where user info goes on request
        //var cellMessage = subData[indexPath.row].pet_owner! + "\n" + subData[indexPath.row].address!
        //cell.message = subData[indexPath.row].pet_owner! + "\n" + subData[indexPath.row].address!
      //  cell.delegate = self
        //cell.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subData.count
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
