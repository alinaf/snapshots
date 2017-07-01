//
//  PostCell.swift
//  snapshots
//
//  Created by Alina Abidi on 6/28/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var profileImageView: PFImageView!
    
    @IBOutlet weak var topUsernameLabel: UILabel!
    
    @IBOutlet weak var postImageView: PFImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var instaPost: PFObject! {
        
        didSet {
            self.postImageView.file = instaPost["media"] as? PFFile
            self.postImageView.loadInBackground()
            profileImageView.layer.cornerRadius = 20
            profileImageView.clipsToBounds = true
        }
    }
    
    
    
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
