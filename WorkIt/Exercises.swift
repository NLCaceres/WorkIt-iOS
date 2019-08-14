//
//  Exercises.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 12/6/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

// Simple use to handle preloaded exercise suggestions in tableview

import UIKit

struct Exercises {
 
    // Properties
    var name : String?
    var targetMuscle : String? // Maybe make into array (for set of muscles worked)
    
    init(name: String? = nil, targetMuscle: String? = nil) {
        self.name = name
        self.targetMuscle = targetMuscle
    }
    
}

