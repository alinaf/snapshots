//
//  LoginViewController.swift
//  snapshots
//
//  Created by Alina Abidi on 6/27/17.
//  Copyright © 2017 Alina Abidi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    
    func showAlert(){
        let alertController = UIAlertController(title: "Error", message: "Did not enter a username or password.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //handle response here
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true){
            //optional code for what happens after the alert controller has finished presenting
        }
        
    }
    
    
    @IBAction func onSignIn(_ sender: Any) {
        
        if (self.usernameTextField.text?.isEmpty == true || (self.passwordTextField.text?.isEmpty == true)){
            showAlert()
        } else {

            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
                if user != nil {
                    print("Login successful.")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func onRegister(_ sender: UIButton) {
        
        if (self.usernameTextField.text?.isEmpty == true || (self.passwordTextField.text?.isEmpty == true)){
            showAlert()
        } else {

        
            let newUser = PFUser()
            newUser.username = usernameTextField.text ?? ""
            newUser.password = passwordTextField.text ?? ""
        
            // Parse does the hashing
        
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Sign Up Successful!")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
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
