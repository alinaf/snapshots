//
//  UploadViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/27/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var uploadedImage : UIImage? = nil
    
    @IBOutlet weak var displayImage: PFImageView!
    
    @IBOutlet weak var uploadImageView: PFImageView!
    
    @IBAction func selectCamera(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        
        //alert
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (UIAlertAction) in
            vc.sourceType = .camera
            vc.allowsEditing = true
            self.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            (UIAlertAction) in
            vc.sourceType = .photoLibrary
            vc.allowsEditing = true
            self.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Camera available!")
            vc.sourceType = .camera
        } else {
            print("Camera unavailable!")
            vc.sourceType = .photoLibrary
        }
  
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    

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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        uploadedImage = resize(image: editedImage!, newSize: CGSize(width: 750, height: 750 ))
        self.displayImage.image = self.uploadedImage

        dismiss(animated: true, completion: nil)
    }
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        

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



