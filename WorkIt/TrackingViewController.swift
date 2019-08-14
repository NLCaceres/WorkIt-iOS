//
//  ViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/17/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import CoreMotion

class TrackingViewController: UIViewController {

    @IBOutlet weak var stepCounterLabel: UILabel!
    @IBOutlet weak var distanceCounterLabel: UILabel!
    @IBOutlet weak var calorieBurnedLabel: UILabel!
    @IBOutlet weak var suggestedCalorieIntakeLabel: UILabel!
    
    let kProfileUsername : String = "ProfileUsernameKey"
    let kProfileAge : String = "ProfileAgeKey"
    let kProfileHeight : String = "ProfileHeightKey"
    let kProfileWeight : String = "ProfileWeightKey"
    let kProfileActivity : String = "ProfileActivityKey"
    let kProfileGender : String = "ProfileGenderKey"
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    // viewDidLoad and ViewWillAppear currently EXACT SAME - MAKE INTO SEPARATE FUNCS!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Sets length of time to consider for updates
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Foundation.Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = NSTimeZone.system
        cal.timeZone = timeZone
        let midnightOfToday = cal.date(from: comps)!
        //let fromDate = Foundation.Date(timeIntervalSinceNow: 86400)
        
        if (CMPedometer.isStepCountingAvailable()) {
            /* pedoMeter.queryPedometerData(from: fromDate, to: Foundation.Date(), withHandler: { (data: CMPedometerData?, error) -> Void in
                print(data)
                if (error == nil) {
                    self.stepCounterLabel.text = "Steps: \(data?.numberOfSteps)"
                }
            }) */
            // Important to check for steps updates
            self.pedoMeter.startUpdates(from: midnightOfToday, withHandler: { (data: CMPedometerData?, error :Error?) in
                print(data)
                if (error == nil) {
                    self.stepCounterLabel.text = "Steps: \(data?.numberOfSteps)"
                }
            })
        }
        if (CMPedometer.isDistanceAvailable()) {
            /* pedoMeter.queryPedometerData(from: fromDate, to: Foundation.Date(), withHandler: { (data: CMPedometerData?, error) -> Void in
                print(data)
                if (error == nil) {
                    let milesConversion : Double = (data?.distance?.doubleValue)! / 1609.0
                    self.stepCounterLabel.text = "Steps: \(milesConversion) mi"
                }
            }) */
            
            // important to check for distance updates
            self.pedoMeter.startUpdates(from: midnightOfToday, withHandler: { (data: CMPedometerData?, error :Error?) in
                print(data)
                if (error == nil) {
                    let milesConversion : Double = (data?.distance?.doubleValue)! / 1609.0
                    self.stepCounterLabel.text = "Steps: \(milesConversion) mi"
                }
            })

        }
        if (userAlreadyExist(kUsernameKey: kProfileUsername)) {
            
            let defaults = UserDefaults.standard
            
            let age = defaults.integer(forKey: kProfileAge)
            let ageString = String(age)
            let height = defaults.string(forKey: kProfileHeight)
            let weight = defaults.string(forKey: kProfileWeight)
            let activity = defaults.string(forKey: kProfileActivity)
            let gender = defaults.string(forKey: kProfileGender)
            
            var finalCalorieCalc : Double = 0.0
            
            if (gender! == "male") {
                
                let weightCalc : Double = (10.0 * (Double(weight!)!/2.20462))
                let heightCalc : Double = (6.25 * (Double(height!)! * 2.54))
                let calculatatedCalories : Double = weightCalc + heightCalc - 5.0 * Double(age) - 161.0

                if (activity!.count == 3) {
                    finalCalorieCalc = calculatatedCalories * 1.375
                } else if (activity!.count == 6) {
                    finalCalorieCalc = calculatatedCalories * 1.55
                } else if (activity!.count == 4) {
                    finalCalorieCalc = calculatatedCalories * 1.7
                } else {
                    print("User input incorrect for activity level")
                }
            } else if (gender! == "female") {
                
                let weightCalc : Double = (10.0 * (Double(weight!)!/2.20462))
                let heightCalc : Double = (6.25 * (Double(height!)! * 2.54))
                let calculatatedCalories : Double = weightCalc + heightCalc - 5.0 * Double(age) - 161.0
                
                if (activity!.count == 3) {
                    finalCalorieCalc = calculatatedCalories * 1.375
                } else if (activity!.count == 6) {
                    finalCalorieCalc = calculatatedCalories * 1.55
                } else if (activity!.count == 4) {
                    finalCalorieCalc = calculatatedCalories * 1.7
                } else {
                    print("User input incorrect for activity level")
                }
            } else {
                print("User input incorrect for gender")
            }
            
            self.suggestedCalorieIntakeLabel.text = "Suggested calories: \(Int(finalCalorieCalc))"
        }
        
    }
    
    // Quick function to check if userdefaults is available
    func userAlreadyExist(kUsernameKey: String) -> Bool {
        return UserDefaults.standard.object(forKey: kProfileUsername) != nil
    }
    
    // Will update for every reappearance
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Sets how far back it will get updates in steps or distance
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Foundation.Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = NSTimeZone.system
        cal.timeZone = timeZone
        let midnightOfToday = cal.date(from: comps)!
//        let fromDate = Foundation.Date(timeIntervalSinceNow: 86400)
        
        if (CMPedometer.isStepCountingAvailable()) {
            /* pedoMeter.queryPedometerData(from: fromDate, to: Foundation.Date(), withHandler: { (data: CMPedometerData?, error) -> Void in
             print(data)
             if (error == nil) {
             self.stepCounterLabel.text = "Steps: \(data?.numberOfSteps)"
             }
             }) */
            
            // Important so it can begin updates to set label with steps
            
            self.pedoMeter.startUpdates(from: midnightOfToday, withHandler: { (data: CMPedometerData?, error :Error?) in
                print(data)
                if (error == nil) {
                    self.stepCounterLabel.text = "Steps: \(data?.numberOfSteps)"
                }
            })
            
        }
        
        if (CMPedometer.isDistanceAvailable()) {
            /* pedoMeter.queryPedometerData(from: fromDate, to: Foundation.Date(), withHandler: { (data: CMPedometerData?, error) -> Void in
             print(data)
             if (error == nil) {
             let milesConversion : Double = (data?.distance?.doubleValue)! / 1609.0
             self.stepCounterLabel.text = "Steps: \(milesConversion) mi"
             }
             })*/
            
            // Important for updates so that it can set the distance in middle label
            self.pedoMeter.startUpdates(from: midnightOfToday, withHandler: { (data: CMPedometerData?, error :Error?) in
                print(data)
                if (error == nil) {
                    let milesConversion : Double = (data?.distance?.doubleValue)! / 1609.0
                    self.stepCounterLabel.text = "Steps: \(milesConversion) mi"
                }
            })
        }
        
        if (userAlreadyExist(kUsernameKey: kProfileUsername)) {
            
            // Checks userdefaults to add necessary info to calculate suggested calories
            
            let defaults = UserDefaults.standard
            
            let age = defaults.integer(forKey: kProfileAge)
            let ageString = String(age)
            let height = defaults.string(forKey: kProfileHeight)
            let weight = defaults.string(forKey: kProfileWeight)
            let activity = defaults.string(forKey: kProfileActivity)
            let gender = defaults.string(forKey: kProfileGender)
            
            var finalCalorieCalc : Double = 0.0
            
            if (gender!.count == 4) { // male
                // gender differentiation
                let weightCalc : Double = (10.0 * (Double(weight!)!/2.20462))
                let heightCalc : Double = (6.25 * (Double(height!)! * 2.54))
                let calculatatedCalories : Double = weightCalc + heightCalc - 5.0 * Double(age) - 161.0
                
                // Currently the activity runs simply by checking letter count instead of validating string
                // Low = 3, Medium = 6, High = 4
                if (activity!.count == 3) {
                    finalCalorieCalc = calculatatedCalories * 1.375
                } else if (activity!.count == 6) {
                    finalCalorieCalc = calculatatedCalories * 1.55
                } else if (activity!.count == 4) {
                    finalCalorieCalc = calculatatedCalories * 1.7
                } else {
                    print("User input incorrect for activity level")
                }
            } else if (gender!.count == 6) { // female
                // gender differentiation
                let weightCalc : Double = (10.0 * (Double(weight!)!/2.20462))
                let heightCalc : Double = (6.25 * (Double(height!)! * 2.54))
                let calculatatedCalories : Double = weightCalc + heightCalc - 5.0 * Double(age) - 161.0
                
                if (activity!.count == 3) {
                    finalCalorieCalc = calculatatedCalories * 1.375
                } else if (activity!.count == 6) {
                    finalCalorieCalc = calculatatedCalories * 1.55
                } else if (activity!.count == 4) {
                    finalCalorieCalc = calculatatedCalories * 1.7
                } else {
                    print("User input incorrect for activity level")
                }
            } else {
                print("User input incorrect for gender")
            }
            
            self.suggestedCalorieIntakeLabel.text = "Suggested calories: \(Int(finalCalorieCalc))"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

