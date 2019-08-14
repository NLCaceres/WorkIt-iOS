//
//  GoalsViewController.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/22/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

// Idea originally to use this VC for achievements page but idea scrapped
// VC remains in storyboard

import UIKit

class GoalsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "AchievementCell"
    private let sectionInsets = UIEdgeInsets(top: 25.0,
                                             left: 50.0,
                                             bottom: 25.0,
                                             right: 50.0)
    private let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(GoalsCollectionReusableView.self)",
                    for: indexPath) as? GoalsCollectionReusableView
                else {
                fatalError("Invalid view type")
            }
            
            let sectionNum = indexPath.section
            if (sectionNum == 0) {
                headerView.headerLabel.text = "Daily Achievements"
            } else if sectionNum == 1 {
                headerView.headerLabel.text = "Weekly Achievements"
            } else {
                headerView.headerLabel.text = "Trophies"
            }
            
            return headerView
            
        default:
            assert(false, "Invalid element type") // Basically Guard condition
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    // MARK: - CollectionViewDelegate
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GoalsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ : UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        // Establishes padding (basic algebra in a sense)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

}
