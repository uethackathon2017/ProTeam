//
//  FoodViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class FoodViewController: BasedCollectionViewController {
    
    var arrFood = [String]()
    var isLunch: Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrFood = ["lunch_0" , "lunch_1", "lunch_2", "lunch_0" , "lunch_1", "lunch_2", "lunch_0" , "lunch_1", "lunch_2", "lunch_0" , "lunch_1", "lunch_2", "lunch_0" , "lunch_1", "lunch_2", "lunch_0" , "lunch_1", "lunch_2"]
        
//        if isLunch == true {
//            
//        } else {
//            
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Collection View
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFood.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        let imageView: UIImageView! = cell.contentView.viewWithTag(101) as! UIImageView
        imageView.image = UIImage.init(named: arrFood[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc: UIViewController! = mainStoryboard.instantiateViewController(withIdentifier: "DetailFoodViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
