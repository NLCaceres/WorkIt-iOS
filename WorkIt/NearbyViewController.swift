//
//  NearbyViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import GooglePlacePicker
import SwiftyJSON

/*
 UI may change for this particular view controller due to plans to add a button that will switch out views
 if possible. Hope is make this particular VC similar to a yelp search design with button on top right 
 that toggles between a map and the search results table view
 */

class NearbyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate
{

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var placesClient : GMSPlacesClient!
    
    @IBOutlet weak var tableView: UITableView!
    var tablePlaces : [NearbyPlaces] = []
    
    var tableType : Int!
    var displayingTable : Bool = true
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    var userLong : Double = 0.0
    var userLat : Double = 0.0
    @IBOutlet weak var containerView: UIView!

    @IBAction func mapButtonTapped(_ sender: Any) {
        
        // Map animation plus adjustment of data points to map markers, and vice versa for return to tableview
        UIView.transition(with: containerView, duration: 0.5, options: .transitionFlipFromRight, animations:
            {
                if (self.displayingTable)
                {
                    self.tablePlaces = []
                    self.tableView.isHidden = true
                    self.mapView.isHidden = false
                    self.displayingTable = false
                    print(self.displayingTable)
                }
                else
                {
                    self.tablePlaces = []
                    self.tableView.isHidden = false
                    self.mapView.isHidden = true
                    self.displayingTable = true
                    print(self.displayingTable)
                }
        },
            completion:
            { (finished) -> () in
            if (self.displayingTable)
            {
                if (self.tableType == 0)
                {
                    // Show google places tagged gyms
                    self.tablePlaces = []
                    self.tableView.reloadData()
                    self.fetchPlacesNearCoordinate(type: "gym")
                    self.tableView.reloadData()
                }
                    
                else if (self.tableType == 1)
                {
                    // Show google places tagged restaurants
                    self.tablePlaces = []
                    self.tableView.reloadData()
                    self.fetchPlacesNearCoordinate(type: "restaurant")
                    self.tableView.reloadData()
                    
                }
                    
                else
                {
                    // Show google places tagged markets
                    self.tablePlaces = []
                    self.tableView.reloadData()
                    self.fetchPlacesNearCoordinate(type: "grocery_or_supermarket")
                    self.tableView.reloadData()
                }

            }
            else
            {
                // Map set up
                self.mapView.camera = GMSCameraPosition.camera(withLatitude: self.userLat, longitude: self.userLong, zoom: 12.0)
                self.mapView.isMyLocationEnabled = true
                self.mapView.settings.compassButton = true
                self.mapView.settings.myLocationButton = true
                self.mapView.settings.zoomGestures = true
                self.mapView.settings.scrollGestures = true
                self.mapView.settings.rotateGestures = true
                
                // Map markers set up based on table type
                // Table type here corresponds as following
                // 0 is gyms
                // 1 is restaurant
                // 2 is markets
                if (self.tableType == 0)
                {
                    // Show google places tagged gyms
                    self.tablePlaces = []
                    self.mapView.clear()
                    self.fetchPlacesNearCoordinate(type: "gym")
                    print(self.tablePlaces.count)
                    for place in self.tablePlaces {
                        let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                        let marker = GMSMarker(position: position)
                        marker.title = place.name
                        marker.map = self.mapView
                    }
                }
                    
                else if (self.tableType == 1)
                {
                    // Show google places tagged restaurants
                    self.tablePlaces = []
                    self.mapView.clear()
                    self.fetchPlacesNearCoordinate(type: "restaurant")
                    for place in self.tablePlaces {
                        let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                        let marker = GMSMarker(position: position)
                        marker.title = place.name
                        marker.map = self.mapView
                    }
                }
                    
                else
                {
                    // Show google places tagged markets
                    self.tablePlaces = []
                    self.mapView.clear()
                    self.fetchPlacesNearCoordinate(type: "grocery_or_supermarket")
                    for place in self.tablePlaces {
                        let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                        let marker = GMSMarker(position: position)
                        marker.title = place.name
                        marker.map = self.mapView
                    }
                }

                
            }
        
        })
    }
    
    func fetchPlacesNearCoordinate(type : String)
    {
        // Originally would have used this particular query but for some reason simulator
        // Randomly deletes the values of userlat and userlong
        // Print values originally set up to see when they get deleted but seemed random
        print("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD8f0ADYBUqqUV2UEcBE1nHJKfcpTHFPWA&location=\(userLat),\(userLong)&radius=16000&type=\(type)&rankby=prominence&sensor=true")
        print(userLat)
        print(userLong)
        // This request with only a dynamic type keyword is the the one used
        // Can still easily modify lat,long keyword in query to change set of data returned
        let request = URLRequest(url: URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD8f0ADYBUqqUV2UEcBE1nHJKfcpTHFPWA&location=33.6403466,-117.8247005&radius=16000&type=\(type)&rankby=prominence&sensor=true")!)
        let session = URLSession.shared
        // Query for the json data from Google Places webservice API
        // Requires separate API key to make nearby search with json return
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print("had an error")
                print("error")
            } else {
                if let data = data {
                    print("Got data")
                    
                    do {
                        let json = JSON(data: data)
                        dump(json)
                        
                        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low).async {
                            
                            var bTask : UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
                            bTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                                UIApplication.shared.endBackgroundTask(bTask)
                                bTask = UIBackgroundTaskInvalid
                            })
                            
                            // SwiftyJSON
                            // Originally tried to use JSONSerialization but incredibly difficult
                            var index = 0
                            for result in json["results"].arrayValue {
                                print(result["name"].stringValue)
                                print(result["vicinity"].stringValue)
                                print(result["geometry"]["location"]["lat"].doubleValue)
                                print(result["geometry"]["location"]["lng"].doubleValue)
                                print(result["icon"].stringValue)
                                
                                print("time left")
                                print(UIApplication.shared.backgroundTimeRemaining)
                                
                                if (UIApplication.shared.backgroundTimeRemaining < 2.0) {
                                    print("Not enough time, skipping")
                                    break
                                }
                                
                                print("getting image")
                                
                                let url = URL(string: result["icon"].stringValue)
                                let imageData = try? Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
                                let image = UIImage(data: imageData!)
                                // self.tableImages.append(image!)
                                
                                DispatchQueue.main.sync(execute: {
                                    
                                    self.tablePlaces.append(NearbyPlaces(name: result["name"].stringValue, address: result["vicinity"].stringValue, latitude: result["geometry"]["location"]["lat"].doubleValue, longitude: result["geometry"]["location"]["lng"].doubleValue, icon: image!))
                                    
                                    if (self.tableView.isHidden == false) {
                                        print("still in async technically")
                                        let indexPath : IndexPath = IndexPath(row: index, section: 0)
                                        self.tableView.insertRows(at: [indexPath], with: .left)
                                    }
                                    else {
                                        print("still in async technically")
                                        for place in self.tablePlaces {
                                            let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                                            let marker = GMSMarker(position: position)
                                            marker.title = place.name
                                            marker.map = self.mapView
                                            self.mapView.animate(toZoom: 12.0)
                                        }
                                    }
                                })

                                /*
                                if (self.tableView.isHidden == false) {
                                    DispatchQueue.main.sync(execute: {
                                        print("still in async technically")
                                        let indexPath : IndexPath = IndexPath(row: index, section: 0)
                                        self.tableView.insertRows(at: [indexPath], with: .left)
                                    })
                                }
                                else {
                                    DispatchQueue.main.sync(execute: {
                                        print("still in async technically")
                                        for place in self.tablePlaces {
                                            let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                                            let marker = GMSMarker(position: position)
                                            marker.title = place.name
                                            marker.map = self.mapView
                                        }
                                    })
                                }
                                 */
                                
                                index += 1
                            }
                            print(self.tablePlaces.count)
                            
                            // Original attempt at parsing JSON with foundation
                            
                            /*
                            for result in json["results"].arrayValue {
                                print(result["vicinity"].stringValue)
                                self.tableAddress.append(result["vicinity"].stringValue)
                            }
                            
                            for result in json["results"].arrayValue {
                                print(result["location"]["lat"])
                                print(result["location"]["lng"])
                                self.tableLat.append(result["location"]["lat"].doubleValue)
                                self.tableLong.append(result["location"]["lng"].doubleValue)
                            }
 
                            for icon in json["results"].arrayValue {
                                print("time left")
                                print(UIApplication.shared.backgroundTimeRemaining)
                                        
                                if (UIApplication.shared.backgroundTimeRemaining < 2.0) {
                                    print("Not enough time, skipping")
                                    break
                                }
                                
                                print("getting image")
                                        
                                let url = URL(string: icon["icon"].stringValue)
                                let imageData = try? Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
                                let image = UIImage(data: imageData!)
                                self.tableImages.append(image!)
                                
                             */
                                    
                            print("All done")
                            UIApplication.shared.endBackgroundTask(bTask)
                            bTask = UIBackgroundTaskInvalid
                                    
                        }
                    }
                    catch let error as NSError {
                        print(error)
                    }
                
                }
            }
        })
        print(tablePlaces.count)
        task.resume()
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any)
    {
        
        tableType = segmentedControl.selectedSegmentIndex
        if (self.displayingTable)
        {
            if (tableType == 0)
            {
                // Show google places tagged gyms
                tablePlaces = []
                tableView.reloadData()
                fetchPlacesNearCoordinate(type: "gym")
                tableView.reloadData()
            }
                
            else if (tableType == 1)
            {
                // Show google places tagged restaurants
                tablePlaces = []
                tableView.reloadData()
                fetchPlacesNearCoordinate(type: "restaurant")
                tableView.reloadData()
                
            }
                    
            else
            {
                // Show google places tagged markets
                tablePlaces = []
                tableView.reloadData()
                fetchPlacesNearCoordinate(type: "grocery_or_supermarket")
                tableView.reloadData()

            }

        }
        else
        {
            self.mapView.camera = GMSCameraPosition.camera(withLatitude: self.userLat, longitude: self.userLong, zoom: 15.0)
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.compassButton = true
            self.mapView.settings.myLocationButton = true
            self.mapView.settings.zoomGestures = true
            self.mapView.settings.scrollGestures = true
            self.mapView.settings.rotateGestures = true
            
            
            if (tableType == 0)
            {
                // Show google places tagged gyms
                self.tablePlaces = []
                self.mapView.clear()
                self.fetchPlacesNearCoordinate(type: "gym")
                print(self.tablePlaces.count)
                for place in self.tablePlaces {
                    let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    let marker = GMSMarker(position: position)
                    marker.title = place.name
                    marker.map = self.mapView
                }
            }
                
            else if (tableType == 1)
            {
                // Show google places tagged restaurants
                self.tablePlaces = []
                self.mapView.clear()
                self.fetchPlacesNearCoordinate(type: "restaurant")
                print(self.tablePlaces.count)
                for place in self.tablePlaces {
                    let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    let marker = GMSMarker(position: position)
                    marker.title = place.name
                    marker.map = self.mapView
                }
            }
                
            else
            {
                // Show google places tagged markets
                self.tablePlaces = []
                self.mapView.clear()
                self.fetchPlacesNearCoordinate(type: "grocery_or_supermarket")
                for place in self.tablePlaces {
                    let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    let marker = GMSMarker(position: position)
                    marker.title = place.name
                    marker.map = self.mapView
                }
            }
        }
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: Any)
    {
        // Will update userlat and userlong doubles assuming they don't get wiped clean
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        displayingTable = true
        tableType = 0
        
        // Make sure that location manager asks permission for user location
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        // Begin user location updates
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if (displayingTable)
        {
            if (tableType == 0)
            {
                // Show google places tagged gyms
                tablePlaces = []
                tableView.reloadData()
                fetchPlacesNearCoordinate(type: "gym")
                tableView.reloadData()
            }
                
            else if (tableType == 1)
            {
                // Show google places tagged restaurants
                tablePlaces = []
                tableView.reloadData()
                fetchPlacesNearCoordinate(type: "restaurant")
                tableView.reloadData()
                
            }
                
            else
            {
                // Show google places tagged markets
                tablePlaces = []
                tableView.reloadData()
                fetchPlacesNearCoordinate(type: "grocery_or_supermarket")
                tableView.reloadData()
                
            }
            
        }
        else
        {
            self.mapView.camera = GMSCameraPosition.camera(withLatitude: self.userLat, longitude: self.userLong, zoom: 15.0)
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.compassButton = true
            self.mapView.settings.myLocationButton = true
            self.mapView.settings.zoomGestures = true
            self.mapView.settings.scrollGestures = true
            self.mapView.settings.rotateGestures = true
            
            
            if (tableType == 0)
            {
                // Show google places tagged gyms
                self.tablePlaces = []
                self.mapView.clear()
                self.fetchPlacesNearCoordinate(type: "gym")
                for place in self.tablePlaces {
                    let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    let marker = GMSMarker(position: position)
                    marker.title = place.name
                    marker.map = self.mapView
                }

            }
                
            else if (tableType == 1)
            {
                // Show google places tagged restaurants
                self.tablePlaces = []
                self.mapView.clear()
                self.fetchPlacesNearCoordinate(type: "restaurant")
                for place in self.tablePlaces {
                    let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    let marker = GMSMarker(position: position)
                    marker.title = place.name
                    marker.map = self.mapView
                }
            }
                
            else
            {
                // Show google places tagged markets
                self.tablePlaces = []
                self.mapView.clear()
                self.fetchPlacesNearCoordinate(type: "grocery_or_supermarket")
                for place in self.tablePlaces {
                    let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    let marker = GMSMarker(position: position)
                    marker.title = place.name
                    marker.map = self.mapView
                }

            }
        }
        

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        // Quickly get a couple data points on user location then stop
        var userLocation:CLLocation = locations[0] 
        userLong = userLocation.coordinate.longitude
        userLat = userLocation.coordinate.latitude
        print(userLong)
        print(userLat)
        locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tablePlaces.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    let cellId = "cellId1"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil)
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.imageView?.image = tablePlaces[(indexPath as IndexPath).row].icon
        cell?.textLabel?.text = tablePlaces[(indexPath as IndexPath).row].name
        cell?.detailTextLabel?.text = tablePlaces[(indexPath as IndexPath).row].address

        return cell!
        
    }
    
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
        }
        
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
