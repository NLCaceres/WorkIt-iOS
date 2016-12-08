//
//  editProfileViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

// Similar to customexerciseVC, this was intended for use with completion handler
// Instead unwind used and profileVC updated

import UIKit

typealias editProfileCompletionHandler = (String?, String?, String?, String?, String?, String?) -> ()

class editProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var username : String?
    var age : String?
    var height : String?
    var weight : String?
    var activity : String?
    var gender : String?
    
    
    var editProfileCH : editProfileCompletionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancelButtonTapped() {
        
        if let ePCH = editProfileCH {
            ePCH(nil, nil, nil, nil, nil, nil)
        }
        
        usernameTextField.text = nil
        ageTextField.text = nil
        heightTextField.text = nil
        weightTextField.text = nil
        activityTextField.text = nil
        genderTextField.text = nil
        
    }

    
    func saveButtonTapped() {
        
        username = usernameTextField.text!
        age = ageTextField.text!
        height = heightTextField.text!
        weight = weightTextField.text!
        activity = activityTextField.text!
        gender = genderTextField.text!
        
        if let ePCH = editProfileCH {
            ePCH(usernameTextField.text, ageTextField.text, heightTextField.text, weightTextField.text, activityTextField.text, genderTextField.text)
        }
        
        usernameTextField.text = nil
        ageTextField.text = nil
        heightTextField.text = nil
        weightTextField.text = nil
        activityTextField.text = nil
        genderTextField.text = nil
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveButtonTapped()
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let changedString : String = (textField.text! as String) + string
        print(changedString)
        
        if usernameTextField.text!.isEmpty || ageTextField.text!.isEmpty || heightTextField.text!.isEmpty || weightTextField.text!.isEmpty || activityTextField.text!.isEmpty || genderTextField.text!.isEmpty {
            
            saveButton.isEnabled = false
            
        }
        else {
            
            saveButton.isEnabled = true
        }
        
        return true
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "cancelButtonUnwind") {
            cancelButtonTapped()
        } else {
            saveButtonTapped()
        }
        
    }

}
