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

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var instaPost: PFObject! 
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.file = instaPost["media"] as? PFFile
        postImageView.loadInBackground()
        
        
        let text = instaPost?["caption"]
        let author = instaPost?["author"] as? PFUser
        let time = instaPost?.createdAt
        print(time ?? 0)
        let username = author?.username
        usernameLabel.text = username
        captionLabel.text = text as? String

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
