//
//  Exercises.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 12/6/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

// Simple use to handle preloaded exercise suggestions in tableview

import UIKit

class Exercises {
 
    // Properties
    var name : String
    var targetMuscle : String
    
    init(name: String, targetMuscle: String) {
        self.name = name
        self.targetMuscle = targetMuscle
    }
    
}
