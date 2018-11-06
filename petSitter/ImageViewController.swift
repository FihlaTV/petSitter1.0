//
//  ImageViewController.swift
//  petSitter
//
//  Created by Harold on 9/12/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class ImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageButton1: UIButton!
    @IBOutlet weak var uploadedImage: UIImageView!
    @IBOutlet weak var uploadedImage2: UIImageView!
    var email:String?
    @IBOutlet weak var uploadedImage3: UIImageView!
    @IBOutlet weak var uploadedImage4: UIImageView!
    
    var imageArray = [UIImageView]()
    var owner:String?
    var urlString:(String) -> Void = {_ in }
    var ref: DatabaseReference!
    var imageCount:Int = 0
    
    
    
    let filename = "animalPic1.jpg"
    @IBAction func browse(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            //after complete can write in code here
        }
        //crappy way of limiting the amount of uploads a person can make
        imageCount = imageCount + 1
        if imageCount >= 4{
            imageButton1.isHidden = true
        }
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            if imageCount == 1{
            uploadedImage.image = image
                imageArray.append(uploadedImage)
            }
            else if imageCount == 2{
                uploadedImage2.image = image
                imageArray.append(uploadedImage2)
            }
            else if imageCount == 3{
                uploadedImage3.image = image
                imageArray.append(uploadedImage3)
            }
            else{
                uploadedImage4.image = image
                imageArray.append(uploadedImage4)
            }
        }
        else{
            //error message
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    func upload(completion: @escaping ((String) -> Void)){
        var count = 1
        for image in imageArray{
           var strURL = ""
            guard let currentImage = image.image else{
                return
            }
            guard let imageData = UIImageJPEGRepresentation(currentImage, 1) else {
                return
            }
            let uploadImageRef = imageReference.child(email!).child(" \(count)")
            
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil, completion:  {(metadata,error) in
                uploadImageRef.downloadURL(completion: {(url, error) in
                    if let urlText = url?.absoluteString{
                        strURL = urlText
                        print("////////////tttttttt//////// \(strURL)  ////////")
                        self.ref.child("Users").child(self.owner!).child("Images").child("Image \(Int(arc4random_uniform(100)))").setValue(strURL)
                        completion(strURL)
                    }
                    print("UPLOAD TASK FINISHED")
                    print(metadata ?? "NO METADATA")
                    print(error ?? "NO ERROR")
                })
                
            })
            uploadTask.observe(.progress){(snapshot) in
                print(snapshot.progress ?? "NO MORE PROGRESS")
                
            }
            uploadTask.resume()
            
            count = count + 1
        }
        
        
        
        
        dismiss(animated: true)
        
        
    }
    
    @IBAction func uploadTapped(_ sender: Any) {
        
        upload(completion: urlString)
        /**
        var strURL = ""
        guard let image = uploadedImage.image else{
            return
        }
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            return
        }
        let uploadImageRef = imageReference.child(filename)
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil, completion:  {(metadata,error) in
                uploadImageRef.downloadURL(completion: {(url, error) in
                    if let urlText = url?.absoluteString{
                        strURL = urlText
                        print("////////////tttttttt//////// \(strURL)  ////////")
                        completion(strURL)
                    }
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
                })
            
        })
        
        uploadTask.observe(.progress){(snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
            
        }
        uploadTask.resume()
        **/
        print("test")
        
    }
    
    
    var imageReference:StorageReference{
        return Storage.storage().reference().child("images")
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
