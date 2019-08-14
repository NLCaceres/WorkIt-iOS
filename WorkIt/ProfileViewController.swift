//
//  ProfileViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import CoreData
import GoogleSignIn
//import FBSDKCoreKit
//import FBSDKLoginKit


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    let kProfileUsername : String = "ProfileUsernameKey"
    let kProfileAge : String = "ProfileAgeKey"
    let kProfileHeight : String = "ProfileHeightKey"
    let kProfileWeight : String = "ProfileWeightKey"
    let kProfileActivity : String = "ProfileActivityKey"
    let kProfileGender : String = "ProfileGenderKey"

    @IBAction func logoutButtonTapped(_ sender: Any) {
//        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
//        loginManager.logOut()
        GIDSignIn.sharedInstance().signOut()
        if let tabBar = self.tabBarController {
            //tabBar.selectedViewController = tabBar.viewControllers![2]
            tabBar.selectedIndex = 2;
        }
    }
    
    // Quick check for user defaults data
    func userAlreadyExist(kUsernameKey: String) -> Bool {
        return UserDefaults.standard.object(forKey: kProfileUsername) != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading any userDefault pre-exisiting data
        if (userAlreadyExist(kUsernameKey: kProfileUsername)) {
            let defaults = UserDefaults.standard
            self.usernameLabel.text = defaults.string(forKey: kProfileUsername)
            self.ageLabel.text = String(defaults.integer(forKey: kProfileAge))
            self.heightLabel.text = defaults.string(forKey: kProfileHeight)
            self.weightLabel.text = defaults.string(forKey: kProfileWeight)
            self.activityLabel.text = defaults.string(forKey: kProfileActivity)
            self.genderLabel.text = defaults.string(forKey: kProfileGender)
        }
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refreshing user defaults after unwind or changing of tabs
        if (userAlreadyExist(kUsernameKey: kProfileUsername)) {
            let defaults = UserDefaults.standard
            self.usernameLabel.text = defaults.string(forKey: kProfileUsername)
            self.ageLabel.text = String(defaults.integer(forKey: kProfileAge))
            self.heightLabel.text = defaults.string(forKey: kProfileHeight)
            self.weightLabel.text = defaults.string(forKey: kProfileWeight)
            self.activityLabel.text = defaults.string(forKey: kProfileActivity)
            self.genderLabel.text = defaults.string(forKey: kProfileGender)
        }
        /* let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        
        do {
            personProfile = try managedContext!.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        } */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func saveButtonUnwind(segue: UIStoryboardSegue) {
        if let editProfileVC = segue.source as? EditProfileViewController {
            
            // Pulling data from unwind for editProfile VC input
            if let username = editProfileVC.username {
                self.usernameLabel.text = username
                self.ageLabel.text = editProfileVC.age
                self.heightLabel.text = editProfileVC.height
                self.weightLabel.text = editProfileVC.weight
                self.activityLabel.text = editProfileVC.activity
                self.genderLabel.text = editProfileVC.gender
                
                let defaults = UserDefaults.standard
                defaults.set(editProfileVC.username, forKey: self.kProfileUsername)
                defaults.set(Int(editProfileVC.age!), forKey: self.kProfileAge)
                defaults.set(editProfileVC.height, forKey: self.kProfileHeight)
                defaults.set(editProfileVC.weight, forKey: self.kProfileWeight)
                defaults.set(editProfileVC.activity, forKey: self.kProfileActivity)
                defaults.set(editProfileVC.gender, forKey: self.kProfileGender)
                
                /* let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                 let entity = NSEntityDescription.entity(forEntityName: "Profile", in: context)
                 let profile = NSManagedObject(entity: entity!, insertInto: context)
                 profile.setValue(Username, forKey: "username")
                 profile.setValue(Int(age!), forKey: "age")
                 profile.setValue(height, forKey: "height")
                 profile.setValue(weight, forKey: "weight")
                 profile.setValue(activity, forKey: "activity")
                 
                 do {
                    try context.save()
                 } catch let error as NSError {
                 print("Could not save. \(error), \(error.userInfo)")
                 } */
            }
        }
    }
    
    @IBAction func cancelButtonUnwind(segue: UIStoryboardSegue) {
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to the new view controller. Grab navVC.Children first
        
        var editProfileVC : EditProfileViewController = EditProfileViewController()
        let navVC = segue.destination as! UINavigationController
        
        /* if let Username = usernameLabel.text {
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
        } */
        
        /* editProfileVC.editProfileCH = { username, age, height, weight, activity, gender in
            
            if let Username = username {
                self.usernameLabel.text = Username
                self.ageLabel.text = age
                self.heightLabel.text = height
                self.weightLabel.text = weight
                self.activityLabel.text = activity
                self.genderLabel.text = gender
                
                let defaults = UserDefaults.standard
                defaults.set(Username, forKey: self.kProfileUsername)
                defaults.set(Int(age!), forKey: self.kProfileAge)
                defaults.set(height, forKey: self.kProfileHeight)
                defaults.set(weight, forKey: self.kProfileWeight)
                defaults.set(activity, forKey: self.kProfileActivity)
                defaults.set(gender, forKey: self.kProfileGender)

                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Profile", in: context)
                let profile = NSManagedObject(entity: entity!, insertInto: context)
                profile.setValue(Username, forKey: "username")
                profile.setValue(Int(age!), forKey: "age")
                profile.setValue(height, forKey: "height")
                profile.setValue(weight, forKey: "weight")
                profile.setValue(activity, forKey: "activity")
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        } */
    }
}
