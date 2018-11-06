//
//  CustomCell.swift
//  petSitter
//
//  Created by Harold on 9/18/18.
//  Copyright © 2018 Harold. All rights reserved.
//

import Foundation
import UIKit

protocol buttonDelegate{
    func acceptTapped(requestNum:Int)
    func denyTapped(requestNum:Int)
    
}

class CustomCell:UITableViewCell{
    
    @IBAction func acceptWasTapped(_ sender: Any) {
        delegate?.acceptTapped(requestNum: rowNum)
        
    }
    
    @IBAction func denyWasTapped(_ sender: Any) {
        delegate?.denyTapped(requestNum: rowNum)
    }
    //need to send the entire user account over
    var delegate: buttonDelegate?
    
    @IBOutlet weak var info: UILabel!

    @IBOutlet weak var profileImage: UIImageView!
    
    var rowNum:Int!
    
    
    
    
    func setImage(pic:UIImage){
        profileImage.image = pic
    }
    
    func setText(text:String){
        info.text = text
    }
    
    func setNum(num:Int){
        rowNum = num 
    }
    
    
    
   
    
  
    
  
        
 
        
        
        
   
    
 
}
