//
//  editProfileViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit

typealias editProfileCompletionHandler = (String?, String?, String?, String?, String?) -> ()

class editProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
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
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        if let ePCH = editProfileCH {
            ePCH(nil, nil, nil, nil, nil)
        }
        
        usernameTextField.text = nil
        ageTextField.text = nil
        heightTextField.text = nil
        weightTextField.text = nil
        activityTextField.text = nil
        
        self .dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let ePCH = editProfileCH {
            ePCH(usernameTextField.text, ageTextField.text, heightTextField.text, weightTextField.text, activityTextField.text)
        }
        
        usernameTextField.text = nil
        ageTextField.text = nil
        heightTextField.text = nil
        weightTextField.text = nil
        activityTextField.text = nil
        
        self .dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let ePCH = editProfileCH {
            ePCH(usernameTextField.text, ageTextField.text, heightTextField.text, weightTextField.text, activityTextField.text)
        }
        
        usernameTextField.text = nil
        ageTextField.text = nil
        heightTextField.text = nil
        weightTextField.text = nil
        activityTextField.text = nil
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let changedString : String = (textField.text! as String) + string
        print(changedString)
        
        if usernameTextField.text!.isEmpty || ageTextField.text!.isEmpty || heightTextField.text!.isEmpty || weightTextField.text!.isEmpty || activityTextField.text!.isEmpty {
            
            saveButton.isEnabled = false
            
        }
        else {
            
            saveButton.isEnabled = true
        }
        
        return true
        
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
