//
//  CustomExerciseViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit

typealias customExerciseCompletionHandler = (String?, String?, String?) -> ()

class CustomExerciseViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var totalSetsTextField: UITextField!
    @IBOutlet weak var totalRepsTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var cExerciseCH : customExerciseCompletionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseNameTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        if let ceCH = cExerciseCH {
            ceCH(nil, nil, nil)
        }
        
        exerciseNameTextField.text = nil
        totalRepsTextField.text = nil
        totalSetsTextField.text = nil
        
        self .dismiss(animated: true, completion: nil)
    }

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let ceCH = cExerciseCH {
            ceCH(exerciseNameTextField.text, totalSetsTextField.text, totalRepsTextField.text)
        }
        
        exerciseNameTextField.text = nil
        totalRepsTextField.text = nil
        totalSetsTextField.text = nil
        
        self .dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let ceCH = cExerciseCH {
            ceCH(exerciseNameTextField.text, totalSetsTextField.text, totalRepsTextField.text)
        }
        
        exerciseNameTextField.text = nil
        totalRepsTextField.text = nil
        totalSetsTextField.text = nil

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let changedString : String = (textField.text! as String) + string
        print(changedString)

        
        if (exerciseNameTextField.text!.isEmpty || totalSetsTextField.text!.isEmpty || totalRepsTextField.text!.isEmpty) {
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
