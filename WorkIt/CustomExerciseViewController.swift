//
//  CustomExerciseViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

// VC used to gather input for a custom exercise that will be logged in workoutlogVC
// Originally intended to be used with a completion handler to handle data instead unwind used

import UIKit

typealias customExerciseCompletionHandler = (String?, String?, String?) -> ()

class CustomExerciseViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var totalSetsTextField: UITextField!
    @IBOutlet weak var totalRepsTextField: UITextField!
    
    var exerciseName : String?
    var totalSets : String?
    var totalReps : String?
    
    
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
    
    func cancelButtonTapped() {
        
        if let ceCH = cExerciseCH {
            ceCH(nil, nil, nil)
        }
        
        exerciseNameTextField.text = nil
        totalRepsTextField.text = nil
        totalSetsTextField.text = nil
        
    }

    
    func saveButtonTapped() {
        
        exerciseName = exerciseNameTextField.text!
        totalSets = totalSetsTextField.text!
        totalReps = totalRepsTextField.text!
        
        if let ceCH = cExerciseCH {
            ceCH(exerciseNameTextField.text, totalSetsTextField.text, totalRepsTextField.text)
        }
        
        exerciseNameTextField.text = nil
        totalRepsTextField.text = nil
        totalSetsTextField.text = nil
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveButtonTapped()

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
