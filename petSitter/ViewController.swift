//
//  ViewController.swift
//  petSitter
//
//  Created by Harold on 8/22/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
import FirebaseStorage
import Foundation


protocol MyDelegate{
    func populate(data:[myUser])
}

class ViewController: UIViewController, CLLocationManagerDelegate, MyDelegate{

    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    var ref:DatabaseReference!
    var dbRef: DatabaseReference!
    var addresses = [String]()
    var sentEmail:String?
    var userLat:CLLocationDegrees!
    var userLong:CLLocationDegrees!
    var userData: [myUser] = []
    var requestCount:Int!
    var requestees = [String:String]()
    
    var identifier:String?
    
    var currentUserProfile = myUser()
    
    
    
    @IBAction func logOut(_ sender: Any) {
        performSegue(withIdentifier: "logoutSegue", sender: self)
        
    }
    
    @IBAction func profile(_ sender: Any) {
        performSegue(withIdentifier: "profileSegue", sender: self)
        
    }
    
    var selectedUser = myUser()
    
    
    
        
    
    var databaseHandle:DatabaseHandle!
    var string:String? = ""
    
   
    let info = ["address": "1 test drive",
                "allergies": "none"]

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        userLat = location.coordinate.latitude
        userLong = location.coordinate.longitude
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        
    }
    func loadData(){
        dbRef.child("Users").observe(.value, with: {(snapshot) in
            var users = [myUser]()
            guard let value = snapshot.value as? NSDictionary else{
            print("No records returned")
            return
        }
        
            for user in value{
                let thisUser = myUser()
                let dictionary = user.value as! NSDictionary
                //need to check for connections 
                
                if var requests = dictionary["Request"] as? [String:String] {
                    
                    thisUser.requests = requests 
                }
                else{
                    
                }
                if var images = dictionary["Image 44"] as? String{
                    var imageURL = Storage.storage().reference(forURL: images)
                    if let url = URL(string: images){
                        do{
                        
                            let data = try Data(contentsOf: url)
                            var pic = UIImage(data: data)
                            thisUser.profilePics = pic
                        }catch let err{
                            print("Error: ")
                        }
                    }/**
                    imageURL.getData(maxSize: 1 * 1024 * 1024){(data, error) -> Void in
                        
                        var pic = UIImage(data: data!)
                        thisUser.profilePics = pic
                    }
 
                    
                }
                else{
                    
                }
                
                **/
                }
                let address = dictionary["address"] as! String
                let allergies = dictionary["allergies"] as! String
                let email = dictionary["email"] as! String
                let gender = dictionary["gender"] as! String
                var lat = dictionary["latitude"] as! Double
                var long = dictionary["longitude"] as! Double
                //let myLong = NSString(string: long).doubleValue
                let pet_owner = dictionary["pet_owner"] as! String
                let pictures = dictionary["pictures"] as! String
                let vet = dictionary["vet"] as! String
                
                thisUser.address = address
                thisUser.allergies = allergies
                thisUser.email = email
                thisUser.gender = gender
                thisUser.latitude = lat
                thisUser.longitude = long
                thisUser.pet_owner = pet_owner
                thisUser.pictures = pictures
                thisUser.vet = vet
                users.append(thisUser)
                
                
               
                self.string?.append(allergies)
                
            }
            //print(self.string)
            //myUser.shared.printUsers()
            self.populate(data: users)
            
        })
    /**
        databaseHandle = ref?.child("Users").observe(.childAdded, with: {(snapshot) in
            
           
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user2 = User()
                //user2.address = dictionary["address"] as? String
                //user2.allergies = dictionary["allergies"] as? String
                
                    self.databaseInfo.append(user2)
                
                
               // print(user2.address ?? String(), user2.allergies ?? String())
            
               //print(self.databaseInfo.count)
                
            }

             //print(self.databaseInfo.count)
            //where i need to put all the code

        })
    print(self.databaseInfo.count)
 **/
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        map.delegate = self
        dbRef = Database.database().reference()
        
        string?.append("test string")
        loadData()


        

        
        
        //self.ref.child("Users").child("roofus").setValue(info)
        
        
        
       /**
        databaseHandle = ref?.child("Users").observe(.childAdded, with: {(snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user2 = User()
                //user2.address = dictionary["address"] as? String
                //user2.allergies = dictionary["allergies"] as? String
                
                self.databaseInfo.append(user2)
                
                
                // print(user2.address ?? String(), user2.allergies ?? String())
                
                //print(self.databaseInfo.count)
                
            }
            
            //print(self.databaseInfo.count)
            //where i need to put all the code
            
        })
        **/
    }
    func populate(data:[myUser]){
        userData = data 
        //selectedUser = data[0]
        
        let neEmail:String? = sentEmail
        var count:Int = 0
        for user in data{
            
            var newEmail = user.email
            //need to change this to a boolean or something
            let isEqual = (sentEmail == newEmail)
            if (isEqual){
                count = count + 1
            }
        }
            if (count >= 1){
               //if count is greater than or equal to 1 (meaning there's an account for the user), check if there are requests and perform segue is necessary
        
                
            }
            else{
               performSegue(withIdentifier: "registerSegue", sender: nil)
/**
                let popoverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupID") as! PopUpViewController
                self.addChildViewController(popoverVC)
                popoverVC.myLat = userLat
                popoverVC.myLong = userLong
                
             
                
                popoverVC.view.frame = self.view.frame
                self.view.addSubview(popoverVC.view)
                popoverVC.didMove(toParentViewController: self)
                **/

 
            }
        
       
        
        for user in data{
            //this conditional line removes the users profile information from where they are on the map
            if (user.email != sentEmail){
        let artwork = Artwork(title: user.pet_owner!, locationName: user.address!, discipline: user.gender!, coordinate: CLLocationCoordinate2D(latitude: user.latitude!, longitude: user.longitude!))
        
        map.addAnnotation(artwork)
                
            }
                //if it's the current user's profile
            else{
                //sets current profile to variable so it can be transferred to other segues
                
                currentUserProfile = user
                requestCount = user.requests.count
                if requestCount != 0{
                    requestees = user.requests
                    performSegue(withIdentifier: "requestSegue", sender: nil)
                }
                
            }
        }
        
        let emergencyButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapEmergency))
        self.navigationItem.leftBarButtonItem = emergencyButton
        self.navigationController?.isToolbarHidden = false;
        var items = [UIBarButtonItem]()
        items.append(
           emergencyButton)
        
        self.toolbarItems = items
        
        
        
    }
    

    @objc func tapEmergency(){
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

extension ViewController: MKMapViewDelegate {
    // 1/**
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = annotation.title
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier!)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let button = UIButton(type: .detailDisclosure)
            button.frame = CGRect(x:0, y:0, width:30, height:30)
            button.addTarget(self, action: #selector(infoClicked(_sender:)), for: .touchUpInside)
            button.accessibilityIdentifier = annotation.title
            view.rightCalloutAccessoryView = button
        }
        return view
    }
    
    @objc func infoClicked(_sender: UIButton){
        identifier = _sender.accessibilityIdentifier
        performSegue(withIdentifier: "infoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerSegue"{
            let popup = segue.destination as! PopUpViewController
            popup.myLat = userLat
            popup.myLong = userLong
        }
        else if segue.identifier == "infoSegue"{
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.userInfo = selectedUser
            destinationVC.userData = userData
            destinationVC.currentUserEmail = sentEmail!
            destinationVC.identifier = identifier
        }
        else if segue.identifier == "requestSegue"{
            let request = segue.destination as! RequestViewController
            request.requestAmount = requestCount
            request.userData = userData
            request.requestees = requestees
            request.currentUser = currentUserProfile
            
            
            
        }
        else if segue.identifier == "profileSegue"{
            let profile = segue.destination as! ProfileViewController
            profile.user = currentUserProfile
            
        }
    }
    
    
}




