//
//  CameraViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/27/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var dismissIsTrue = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // use the images
        // dismiss
        
        dismiss(animated: true, completion: nil)
        dismissIsTrue = true
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if !dismissIsTrue {
        
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.camera
        
            self.present(vc, animated: true, completion: nil)
        
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                print("Camera available!")
                vc.sourceType = .camera
            } else {
                print("Camera unavailable!")
                vc.sourceType = .photoLibrary
            }
            
        }
        
        else {print("yay")}
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
