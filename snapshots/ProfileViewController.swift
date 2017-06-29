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

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    var allPosts: [PFObject]?
    var numPosts = 0
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postNumberLabel: UILabel!
    
    @IBAction func logOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("logoutNotification"), object: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        getPosts()
        
  
        
        // Do any additional setup after loading the view.
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
