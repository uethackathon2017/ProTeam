//
//  EatFavouriteViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class EatFavouriteViewController: BasedCollectionViewController, IndicatorInfoProvider {

    var dataSource = [String]()
    var cellIdentifier:String! = "FavEatCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = ["lunch_0" , "lunch_1", "lunch_2", "lunch_0" , "lunch_1", "lunch_2"]
        self.collectionView1.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK: - Action
    
    @IBAction func btnBackTouch(_ sender: Any) {
        super.btnBackClicked(sender)
    }
    
    func btnDeleteClicked(_ sender: UIButton) {
        let index = sender.tag
        self.dataSource.remove(at: index)
        self.collectionView1.reloadData()
    }
    
    // MARK: - INDICATORINFO Provider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "")
    }

    // MARK: - Collection View
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FavEatCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FavEatCollectionViewCell
        
        cell.imvContent.image = UIImage.init(named: dataSource[indexPath.row])
        cell.btnDelete.addTarget(self, action: #selector(EatFavouriteViewController.btnDeleteClicked(_ :)), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        
        return cell
    }
    
}
