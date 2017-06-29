//
//  DetailViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/28/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import UIImageColors

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var backgroundColor: UIView!
    
    var image : UIImage?
    
    
   
    var instaPost: PFObject! 
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.file = instaPost["media"] as? PFFile
        postImageView.loadInBackground()
        image = postImageView.image
        
        //convert PFFile to image
        
        
        
        let text = instaPost?["caption"]
        let author = instaPost?["author"] as? PFUser
        let time = instaPost?.createdAt
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.A"
        let myDate = time
        
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let somedateString = dateFormatter.string(from: myDate!)
        dateLabel.text = "Posted on " + somedateString
        let username = author?.username
        usernameLabel.text = username
        captionLabel.text = text as? String
        
        let colors = image?.getColors()
        backgroundColor.backgroundColor = colors?.primary
        usernameLabel.textColor = colors?.background
        captionLabel.textColor = colors?.secondary
        dateLabel.textColor = colors?.detail

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
