//
//  EatViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class EatViewController: BasedCollectionViewController,IndicatorInfoProvider {
    
    @IBOutlet weak var viewMain: UIView!
    var arrLunch = [String]()
    var arrDinner = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstInit()
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - First Init
    
    func firstInit() {
        arrLunch = ["lunch_0" , "lunch_1", "lunch_2", "lunch_0" , "lunch_1", "lunch_2"]
        arrDinner = ["dinner_0", "dinner_1", "dinner_2", "dinner_0", "dinner_1", "dinner_2"]
        
        viewMain.layer.cornerRadius = 20
    }
    
    // MARK: - Action
    
    override func btnBackClicked(_ sender: Any) {
        slideMenuController()?.openLeft()
    }
    
    @IBAction func btnSeeAllLunchClicked(_ sender: Any) {
        let vc: FoodViewController! = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        vc.isLunch = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSeeAllDinner(_ sender: Any) {
        let vc: FoodViewController! = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        vc.isLunch = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Collection View
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView1 {
            return arrLunch.count
        } else {
            return arrDinner.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        
        let imageView: UIImageView! = cell.contentView.viewWithTag(101) as! UIImageView
        
        if collectionView == self.collectionView1 {
            
            //cell.frame = CGRect.init(x: 0, y: 0, width: collectionView1.bounds.size.height, height: collectionView1.bounds.size.height)
            imageView.image = UIImage.init(named: arrLunch[indexPath.row])
            
        } else {
            
            //cell.frame = CGRect.init(x: 0, y: 0, width: collectionView2.bounds.size.height, height: collectionView2.bounds.size.height)
            imageView.image = UIImage.init(named: arrDinner[indexPath.row])
            
        }
        
        return cell
    }
    
}
