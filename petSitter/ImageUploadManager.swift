//
//  ImageUploadManager.swift
//  petSitter
//
//  Created by Harold on 9/12/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import UIKit
import FirebaseStorage

struct Constants {
    struct user{
        static let imagesFolder:String = "userImages"
        
    }
}
class ImageUploadManager: NSObject {

    func uploadImage(_ image: UIImage, progress: (_ percentage:Double) -> Void, completionBlock : @escaping (_ url: String?, _ errorMessage: String?)-> Void){
        let storage = Storage.storage()
        let storageReference = storage.reference()
        //storage/personimages/image.jpg
        let imageName = "\(Date().timeIntervalSince1970).jpg"
        let imagesReference = storageReference.child(Constants.user.imagesFolder).child(imageName)
        if let imageData = UIImageJPEGRepresentation(image, 0.8){
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let uploadTask = imagesReference.putData(imageData, metadata: metadata, completion: { (metadata,error) in
                if let metadata = metadata {
                    completionBlock(metadata.downloadURL(), nil)
                    
                }else{
                    completionBlock(nil, error.localizedDescription)
                    
                }
                
            })
            uploadTask.observe(.progress, handler: {(snapshot) in
                guard let progress = snapshot.progress else{
                    return
                }
                let percentage = Double(progress.completedUnitCount) / Double(progress.totalUnitCount) * 100
                progressBlock(percentage)
                
                
            })
        }else{
            completionBlock(nil, "Issue with the image data")
        }
    }

}
