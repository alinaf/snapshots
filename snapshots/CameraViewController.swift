//
//  CameraViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/27/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var editedImage : UIImage? = nil
    

    
    @IBAction func takePhoto(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .camera
        self.present(vc, animated: true, completion: nil)
        
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
    
    
    
    @IBAction func choosePhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType =  .photoLibrary
        self.present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
         editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        
        self.performSegue(withIdentifier: "uploadSegue", sender: nil)
        
        dismiss(animated: true, completion: nil)
        
        
       // let resizedImage = resize(image: editedImage, newSize: )
        
        // use the images
        // dismiss
        
     
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let uploadViewController = segue.destination as! UploadViewController
        uploadViewController.uploadedImage = editedImage
        
        

        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
