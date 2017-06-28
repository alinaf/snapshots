//
//  FeedViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/27/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var allPosts: [PFObject]?
    @IBAction func didLogOut(_ sender: UIButton) {
        
        PFUser.logOutInBackground { (error: Error?) in
            self.performSegue(withIdentifier: "logOutSegue", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: UIControlEvents.valueChanged)
        tableView.dataSource = self
        tableView.insertSubview(refreshControl, at: 0)
        let name = PFUser.current()!.username!
        helloLabel.text = "Hi " + name + "✨💖"
        getPosts()
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        getPosts()
        refreshControl.endRefreshing()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = allPosts![indexPath.row]
        let text = post["caption"]
        let author = post["author"] as? PFUser
        let username = author?.username
        cell.instaPost = post
        
        
        cell.usernameLabel.text = username
        cell.captionLabel.text = text as? String
    
        
        return cell
    }
    
    func getPosts() {
        var query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil {
                self.allPosts = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = allPosts?[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.instaPost = post
        }
        
    }

}
