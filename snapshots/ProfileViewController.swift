 //
//  ProfileViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/28/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var allPosts: [PFObject]?
    var numPosts = 0

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postNumberLabel: UILabel!
    @IBOutlet weak var profileImageView: PFImageView!
    
    @IBAction func logOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("logoutNotification"), object: nil)
    }
    
    
    @IBAction func didTapImage(_ sender: Any) {
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        getProfPic()
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // get image and resize it
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        let resizedImage = resize(image: editedImage!, newSize: CGSize(width: 750, height: 750 ))
                dismiss(animated: true, completion: nil)
        
        // upload image to Parse
        Post.uploadProfPic(image: resizedImage) { (success: Bool, error: Error?) in
            if error != nil {
                print (error?.localizedDescription ?? "")
            } else {
                print ("pic sent to parse!")
            }
        }
        
        getProfPic()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        getPosts()
        getProfPic()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        numPosts = allPosts?.count ?? 0
        
        // I put this here because viewDidLoad was too fast
        
        let postNumString = String(numPosts)
        postNumberLabel.text = postNumString + " posts"
        
        let name = PFUser.current()!.username!
        usernameLabel.text = "@" + name
        
        return numPosts
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let post = allPosts?[indexPath.item]
        cell.instaPost = post
        return cell
        
        
       // return cell
    }
    
    
    func getPosts() {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current())
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil {
                self.allPosts = posts
                self.collectionView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func getProfPic() {
        let query = PFQuery(className: "ProfilePic")
        query.includeKey("author")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current())
        query.getFirstObjectInBackground { (post: PFObject?, error: Error?) in
            if error == nil {
                self.profileImageView.file = post?["media"] as? PFFile
                self.profileImageView.loadInBackground()
                
            } else {
                print(error?.localizedDescription as Any)
            }
        }

    }
        
        
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell){
            let post = allPosts?[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.instaPost = post
        }
        
    }


}
