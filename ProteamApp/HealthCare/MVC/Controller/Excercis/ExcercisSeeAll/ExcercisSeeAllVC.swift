//
//  ExcercisSeeAllVC.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import SDWebImage
import DZNEmptyDataSet
class ExcercisSeeAllVC: BasedViewController,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate  {
    
    let cellWidth = Constants.Systems.screen_size.width*(160/375)
    let cellHeight = (Constants.Systems.screen_size.height - 117)*(117/558)
    
    let cellIdentifier = "ExcercisSeeAllCell"
    var exercises = [Exercise]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName:cellIdentifier,bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        self.navigationController?.navigationBar.isHidden = false
        self.collectionView.emptyDataSetSource = self
        self.collectionView.emptyDataSetDelegate = self
    }
    
    override func btnBackClicked(_ sender: Any) {
        super.btnBackClicked(Any.self)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: EmptyData
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let img = UIImage(named:"nodata_icon")
        return img!
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -self.collectionView!.frame.size.height/5
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSFontAttributeName: UIFont(name: "UTM-Neo-Sans-Intel", size: 16)!]
        return NSAttributedString(string: "Không có dữ liệu", attributes: attributes)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ExcercisSeeAllVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // MARK: - UICollectionViewDataSource protocol
    internal func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ExcercisSeeAllCell
        
        if let imgVideo = exercises[indexPath.row].thumnail {
            cell.imgVideo.sd_setImage(with: URL.init(string: imgVideo))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let neckExcercise = NeckExcerciseViewController()
        neckExcercise.exercise = exercises[indexPath.row]
        neckExcercise.title = exercises[indexPath.row].name
        self.navigationController?.pushViewController(neckExcercise, animated: true)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
}
