//
//  EatFavouriteViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage
import DZNEmptyDataSet
class EatFavouriteViewController: BasedCollectionViewController, IndicatorInfoProvider, UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    var cellIdentifier:String! = "FavEatCollectionViewCell"
    var arrEat = [Eat]()
    var cellWidth: CGFloat! = Constants.Systems.screen_size.width / 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView1.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        loadData()
    }
    
    func loadData(){
        self.showProgress()
        APIModel.getFavoriteEat(completion: { (list) in
            self.arrEat = list
            self.collectionView1.reloadData()
            self.collectionView1.emptyDataSetSource = self
            self.collectionView1.emptyDataSetDelegate = self
            self.collectionView1.reloadEmptyDataSet()
            self.dismissProgress()
        }) { (error) in
            self.dismissProgress()
        }
    }
    
    //MARK: EmptyData
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let img = UIImage(named:"nodata_icon")
        return img!
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -self.collectionView1!.frame.size.height/5
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSFontAttributeName: UIFont(name: "UTM-Neo-Sans-Intel", size: 16)!]
        return NSAttributedString(string: "Không có dữ liệu", attributes: attributes)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Action
    
    @IBAction func btnBackTouch(_ sender: Any) {
        super.btnBackClicked(sender)
    }
    
    func btnDeleteClicked(_ sender: UIButton) {
        let index = sender.tag
    
        let eat = arrEat[index]
        self.showProgress()
        APIModel.unlikeFood(eat._id, completion: { (mes) in
            self.dismissProgress()
            self.loadData()
        }, failure: { (error) in
            self.dismissProgress()
        })
    }
    
    // MARK: - INDICATORINFO Provider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "Foods")
    }

    // MARK: - Collection View
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrEat.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FavEatCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FavEatCollectionViewCell
        
        if let img = arrEat[indexPath.row].img {
            cell.imvContent.sd_setImage(with: URL.init(string: img))
            cell.imvContent.contentMode = .scaleAspectFill
            cell.imvContent.clipsToBounds = true            
        }
        
        cell.btnDelete.addTarget(self, action: #selector(EatFavouriteViewController.btnDeleteClicked(_ :)), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 5
        let numberOfItemsPerRow: CGFloat = 3.0
            
        self.view.layoutIfNeeded()
        let bounds = collectionView1.bounds
        let width = (bounds.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow
        return CGSize.init(width: width, height: width)
    }
    
}

