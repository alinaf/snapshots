//
//  UploadViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/27/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    
    var uploadedImage : UIImage? = nil
  
    
    @IBOutlet weak var captionTextView: UITextView!
   
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func didPressPost(_ sender: Any) {
        
        Post.postUserImage(image: uploadedImage, withCaption: captionTextView.text) { (success: Bool, error: Error?) in
            
            if error != nil {
                print (error?.localizedDescription ?? "")
            } else {
                print ("Posted!")
                self.performSegue(withIdentifier: "returnToFeed", sender: nil)
              
            }
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = uploadedImage
        

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



