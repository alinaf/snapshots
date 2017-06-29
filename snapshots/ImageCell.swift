//
//  ImageCell.swift
//  snapshots
//
//  Created by Alina Abidi on 6/29/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: PFImageView!
    
    
    var instaPost: PFObject! {
        
        didSet {
            self.postImageView.file = instaPost["media"] as? PFFile
            self.postImageView.loadInBackground()
        }
    }
    
    
    
    
    
    
    
    
}
