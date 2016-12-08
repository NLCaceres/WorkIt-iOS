//
//  NearbyPlaces.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 12/6/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

// Used to handle the many places that Google API webservice returns 

import UIKit

class NearbyPlaces {
    
    // Properties
    
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var icon: UIImage
    
    // Initialization
    init(name: String, address: String, latitude: Double, longitude: Double, icon: UIImage) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.icon = icon 
    }
    
}
