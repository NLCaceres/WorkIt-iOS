//
//  LoginViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/25/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

// Simple loginview that pops up when not logged in

import UIKit
import GoogleSignIn
//import FBSDKCoreKit
//import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {

//    var loginButton : FBSDKLoginButton!
    var loginButton : GIDSignInButton?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.11, green:0.15, blue:0.45, alpha:1.0)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        googleSignInButton.backgroundColor = UIColor(red:1.00, green: 0.80, blue: 0.00, alpha: 1.0)
        
//        loginButton!.readPermissions = ["public_profile", "email", "user_friends"] // Facebook Only for these 2
//        loginButton!.delegate = self
        //let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 42),
                               //NSAttributedString.Key.foregroundColor: UIColor(red:1.00, green: 0.80, blue: 0.00, alpha: 1.0)]
        //titleLabel.attributedText = NSAttributedString(string: "Work It", attributes: titleAttributes)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Implement following if the GIDSignInUIDelegate is not a VC
//    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        myActivityIndicator.stopAnimating() // IMPORTANT! BE SURE TO STOP ANIMATION
//    }
//    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
//        self.presentViewController(viewController, animated: true, completion: nil) // Present a view that prompts the user to sign in w/ Google
//    }
//    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
//        self.dismissViewControllerAnimated(true, completion: nil) // Dismiss the "Sign in with Google" view
//    }

    // MARK: Facebook Login Funcs
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if (error != nil) {
//            errorMessageLabel.text = "\(error)"
//        } else if (result.token != nil) {
//            self.dismiss(animated: true, completion: nil)
//        } else {
//            errorMessageLabel.text = "Unknown error occured"
//        }
//
//        print("loginButton didCompleteWith \(error)")
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
