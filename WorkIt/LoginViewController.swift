//
//  LoginViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/25/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton : FBSDKLoginButton!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if (error != nil) {
            errorMessageLabel.text = "\(error)"
            
        } else if(result.token != nil) {
            self.dismiss(animated: true, completion: nil)
            
        } else {
            errorMessageLabel.text = "Unknown error occured"
        }
        
        
        
        print("loginButton didCompleteWith \(error)")
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
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
