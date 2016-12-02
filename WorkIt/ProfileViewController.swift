//
//  ProfileViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var editProfileVC : editProfileViewController = editProfileViewController()
        let navVC = segue.destination as! UINavigationController
        
        /*
        
        if let Username = usernameLabel.text {
            editProfileVC.usernameTextField.text = Username
        }
        if let Age = ageLabel.text {
            editProfileVC.ageTextField.text = Age
        }
        if let Height = heightLabel.text {
            editProfileVC.heightTextField.text = Height
        }
        if let Weight = weightLabel.text {
            editProfileVC.weightTextField.text = Weight
        }
        if let ActivityLevel = activityLabel.text {
            editProfileVC.activityTextField.text = ActivityLevel
        }
 
        */
        
        editProfileVC.editProfileCH = { username, age, height, weight, activity in
            
            if let Username = username {
                self.usernameLabel.text = Username
                self.ageLabel.text = age
                self.heightLabel.text = height
                self.weightLabel.text = weight
                self.activityLabel.text = activity
            }
            
            self .dismiss(animated: true, completion: nil)
        
        }
        
        
    }

}
