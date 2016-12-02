//
//  WorkoutLogViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/19/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class WorkoutLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // Used to toggle between viewing workouts done based on date they were done on and suggestions for users to see
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var tableType : Int!
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        var selectedSegment = segmentedControl.selectedSegmentIndex
        if (selectedSegment == 0) {
            // Show workout log
        }
        
        else {
            // Show workout suggestions
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableType = 1

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(FBSDKAccessToken.current() == nil){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier :"LoginVC")
            self.present(loginVC, animated: false, completion: nil)
            return
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    let cellId = "cellId1"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: cellId)
        }
        
        if (tableType == 1) {
            
        }
        
        else {
            
        }
        
        // cell?.textLabel?.text = CCList[(indexPath as IndexPath).row].cardNickName
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
            
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var customExerciseVC : CustomExerciseViewController = CustomExerciseViewController()
        let nav = segue.destination as! UINavigationController
        
        
        customExerciseVC.cExerciseCH = {
            exerciseName, totalSets, totalReps in
            self .dismiss(animated: true, completion: nil)
        }
        tableView.reloadData()
        
    }
    

}
