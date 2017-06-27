//
//  FeedViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/27/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController{
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBAction func didLogOut(_ sender: UIButton) {
        
        PFUser.logOutInBackground { (error: Error?) in
            self.performSegue(withIdentifier: "logOutSegue", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("arrived here")
        let name = PFUser.current()!.username!
        print("This is fine")
        helloLabel.text = "Hi " + name + "✨💖"
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
