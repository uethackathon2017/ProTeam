//
//  EatViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage
class EatViewController: BasedCollectionViewController,IndicatorInfoProvider {
    
    @IBOutlet weak var viewMain: UIView!
    
    var eatCategory = [EatCategory]()
    var lunchs = [Eat]()
    var dinners = [Eat]()
    var freshControl: UIRefreshControl! = UIRefreshControl()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        freshControl.addTarget(self, action: #selector(EatViewController.loadData), for: .valueChanged)
        self.collectionView1.addSubview(freshControl)
        self.collectionView2.addSubview(freshControl)
        
        freshControl.beginRefreshing()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        viewMain.layer.cornerRadius = 20
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        self.showProgress()
        APIModel.getAllEatCategory(completion: { (eats) in
            print(eats)
            self.eatCategory = eats
            self.lunchs = self.eatCategory[0].items!
            self.dinners = self.eatCategory[1].items!
            self.collectionView1.reloadData()
            self.collectionView2.reloadData()
            self.dismissProgress()
            self.freshControl.endRefreshing()
        }) { (error) in
            self.dismissProgress()
            self.freshControl.endRefreshing()
        }
        
        
    }
    
    // MARK: - Action
    override func btnBackClicked(_ sender: Any) {
        slideMenuController()?.openLeft()
    }
    
    @IBAction func btnSeeAllLunchClicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        vc.isLunch = true
        vc.title = "Lunch"
        vc.arrFood = lunchs
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSeeAllDinner(_ sender: Any) {
        let vc: FoodViewController! = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        vc.title = "Dinner"
        vc.isLunch = false
        vc.arrFood = dinners
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Collection View
    
}

extension EatViewController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView1 {
            
            return lunchs.count
        } else {
            return dinners.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        
        let imageView: UIImageView! = cell.contentView.viewWithTag(101) as! UIImageView
        
        if collectionView == self.collectionView1 {
            if let img = lunchs[indexPath.row].img{
                imageView.sd_setImage(with: URL.init(string: img))
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
            }
            
        } else {
            if let img = dinners[indexPath.row].img{
                imageView.sd_setImage(with: URL.init(string: img))
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc: DetailFoodViewController! = mainStoryboard.instantiateViewController(withIdentifier: "DetailFoodViewController") as! DetailFoodViewController
        vc.title = "Detail"
        if collectionView == collectionView1 {
            vc._id = lunchs[indexPath.row]._id
        } else {
            vc._id = dinners[indexPath.row]._id
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
