//
//  NearbyViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit


/*
 UI may change for this particular view controller due to plans to add a button that will switch out views
 if possible. Hope is make this particular VC similar to a yelp search design with button on top right 
 that toggles between a map and the search results table view
 */

class NearbyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableType : Int!
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        var selectedSegment = segmentedControl.selectedSegmentIndex
        if (selectedSegment == 0) {
            // Show google places tagged gyms
        }
            
        else if (selectedSegment == 1) {
            // Show google places tagged restaurants
        }
            
        else {
            // Show google places tagged markets
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableType = 1

        // Do any additional setup after loading the view.
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
        return 50
    }
    
    let cellId = "cellId1"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        if (tableType == 1) {
            
        }
        else if (tableType == 2) {
            
        }
        else {
            
        }
        
        
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
        }
        
        tableView.deleteRows(at: [indexPath], with: .bottom)
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
