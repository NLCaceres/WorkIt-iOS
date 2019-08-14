//
//  WorkoutLogViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/19/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import GoogleSignIn
//import FBSDKCoreKit
//import FBSDKLoginKit
import CoreData

class WorkoutLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var exerciseList: [Exercises] = [Exercises(name: "Dips",targetMuscle: "Tricep"), Exercises(name: "Bench Press",targetMuscle: "Chest"), Exercises(name: "Squat", targetMuscle: "Legs"), Exercises(name: "Deadlift",targetMuscle: "Back")]
    var customExercises: [NSManagedObject] = []
    var customExerciseTotalList: [String:[NSManagedObject]] = [:]
    
    var dates: [String] = []
    var tableType : Int?
    
    // Toggle between log of workouts and workout suggestions
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func segmentedControlTapped(_ sender: Any) {
        // 0 is WorkoutLog, 1 is PreloadedWorkoutSuggestions
        tableType = segmentedControl.selectedSegmentIndex
        if (tableType == 0) {
            // Show workout log
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedContext = appDelegate?.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CustomExercise")
            
            do {
                customExercises = try managedContext!.fetch(fetchRequest)
                print(customExercises)
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else {
            // Show workout suggestions
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableType = 0
        tableView.reloadData()
        
        GIDSignIn.sharedInstance().signInSilently() // Auto sign BehindTheScenes if possible
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        // This bit of code simply used to reset coredata for testing purposes
        /* let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomExercise")
        
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext?.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                managedContext?.delete(item)
            }
            
            try managedContext?.save()
            
        } catch {
            // Error Handling
            // ...
        } */
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CustomExercise")
        do {
            customExercises = try managedContext!.fetch(fetchRequest)
            print(customExercises.count)
            if (customExercises.isEmpty == false) {
                for (index, customExercise) in customExercises.enumerated() {
                    let dateString = customExercise.value(forKey: "date") as? String
                    guard let dateStr = dateString else {
                        print("Issue with date string")
                        continue
                    }
                    if (dates.contains(dateStr) == false ) {
                        dates.append(dateStr)
                    }
                    var dateSavedExerciseList = customExerciseTotalList[dateStr]
                    if (dateSavedExerciseList == nil) {
                        dateSavedExerciseList = [customExercise]
                        print(dateSavedExerciseList!)
                        customExerciseTotalList[dateStr] = dateSavedExerciseList
                        print(customExerciseTotalList[dateStr]!)
                    }
                    else {
                        customExerciseTotalList[dateStr]?.append(customExercise)
                    }
                    tableView.reloadData()
                    
                    let sectionIndex = dates.firstIndex(of: dateStr)
                    print("\(sectionIndex!) this is section number")
                    print(index)
                    
                    // Current issue, loading is not working after closing and rerunning app.
                    //let indexPath : IndexPath = IndexPath(row: index, section: sectionIndex!)
                    //self.tableView.insertRows(at: [indexPath], with: .left)
                    

                    /*
                    let exerciseArray = customExerciseTotalList[dateString]!
                    for item in exerciseArray {
                        
                    }
                    if (customExerciseTotalList[dateString]?.contains(customExercise) == false) {
                        customExerciseTotalList[dateString]?.append(customExercise)
                        print("adding to custom exercise total list")
                    }
                    */
                }
                tableView.reloadData()
                print("table should be reloading it all up for you")
                print(customExerciseTotalList.count)
            }
            
            print("\(customExercises.count) hello")
            print(dates.count)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isLoggedIn = GIDSignIn.sharedInstance()?.hasAuthInKeychain()
        if (!isLoggedIn!) { // Not Logged in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier :"LoginVC")
            self.present(loginVC, animated: false, completion: nil)
            return
        }
        // If we reached this part then let's reload table for new data
        tableView.reloadData()
        
        /* Trying to access coredata to automatically load up previous user input workout log
        if (tableType == 0) {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedContext = appDelegate?.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CustomExercise")
            do {
                customExercises = try managedContext!.fetch(fetchRequest)
                if (customExercises.isEmpty == false) {
                    for customExercise in customExercises {
                        let dateString :String! = customExercise.value(forKey: "date") as! String!
                        if (dates.contains(dateString) == false ) {
                            dates.append(dateString)
                        }
                        if (customExerciseTotalList[dateString]?.contains(customExercise) == true) {
                            customExerciseTotalList[dateString]?.append(customExercise)
                            print("adding to custom exercise total list")
                        }
                    }
                    tableView.reloadData()
                }
                print("\(customExercises.count) hello")
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else {
            
        } */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (tableType == 0) {
            return dates[section]
        }
        return "" // Fallthrough else condition
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if (tableType == 0) {
            return dates.count
        }
        return 1 // Fallthrough
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableType == 0) {
            if (dates.isEmpty == false && customExerciseTotalList.isEmpty == false) {
                let sectionTitle = dates[section]
                let dateSavedExerciseList = customExerciseTotalList[sectionTitle]
                return dateSavedExerciseList!.count
            } else {
                return 1
            }
        }
        return exerciseList.count // Load old content
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    let cellId = "cellId1"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        
        if (tableType == 0) {
            // Make sure array and dictionary all set to be loaded up with coredata return values
            if (dates.isEmpty == false && customExerciseTotalList.isEmpty == false) {
                let sectionTitle = dates[indexPath.section]
                let dateSavedExerciseList = customExerciseTotalList[sectionTitle]
                let customExercise = dateSavedExerciseList?[indexPath.row]
                let totalReps = customExercise?.value(forKey: "totalReps")
                let totalSets = customExercise?.value(forKey: "totalSets")
                let exerciseName = customExercise?.value(forKey: "name")
                
                cell?.textLabel?.text = exerciseName as! String?
                cell?.detailTextLabel?.text = "Sets: \(totalSets!) Reps: \(totalReps!)"
                
                print("\(customExercises.count) setting up a cell for you ")
            }
        } else {
            cell?.textLabel?.text = exerciseList[(indexPath as IndexPath).row].name
            cell?.detailTextLabel?.text = exerciseList[(indexPath as IndexPath).row].targetMuscle
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Properly set up delete handling between custom workouts
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    @IBAction func cancelButtonUnwind(segue: UIStoryboardSegue) {
        
    }
    @IBAction func saveButtonUnwind(segue: UIStoryboardSegue) {
        // function to unwind segue all the data from user input VC
        if let customExerciseVC = segue.source as? CustomExerciseViewController {
            if let exerciseName = customExerciseVC.exerciseName {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let entity = NSEntityDescription.entity(forEntityName: "CustomExercise", in: context)
                
                let customExercise = NSManagedObject(entity: entity!, insertInto: context)
                customExercise.setValue(exerciseName, forKey: "name")
                customExercise.setValue(customExerciseVC.totalReps, forKey: "totalReps")
                customExercise.setValue(customExerciseVC.totalSets, forKey: "totalSets")
                
                // Getting date that this was input for proper temporary storage
                // Date is also saved as an attribute for reloading use if app is closed etc.
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                dateFormatter.locale = Locale(identifier: "en_US")
                let dateString = dateFormatter.string(from: Date())
                print(dateString)
                if (dates.isEmpty == true) {
                    dates.append(dateString)
                } else {
                    for (index, date) in dates.enumerated() {
                        if (dateString == date) {
                            break
                        }
                        else if (index == dates.count - 1 && dateString == date) {
                            break
                        }
                        else if (index == dates.count - 1 && dateString != date) {
                            dates.append(dateString)
                        }
                    }
                }
        
                customExercise.setValue(dateString, forKey: "date")
                
                if (customExerciseTotalList.isEmpty == false) {
                    var dateSavedExerciseList = customExerciseTotalList[dateString]
                    dateSavedExerciseList?.append(customExercise)
                    customExerciseTotalList[dateString] = dateSavedExerciseList
                    print("Saving now")
                }
                else {
                    var newDateSavedExerciseList : [NSManagedObject] = []
                    newDateSavedExerciseList.append(customExercise)
                    customExerciseTotalList[dateString] = newDateSavedExerciseList
                    print("Starting a brand new one up for you")
                }
                
                do {
                    try context.save()
                    print("Saved it all up for you!")
                    print(customExercises.count)
                    tableView.reloadData()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*
        var customExerciseVC : CustomExerciseViewController = CustomExerciseViewController()
        let nav = segue.destination as! UINavigationController
        
        
        customExerciseVC.cExerciseCH = {
            exerciseName, totalSets, totalReps in
        }
        tableView.reloadData()
        */
    }
    

}
