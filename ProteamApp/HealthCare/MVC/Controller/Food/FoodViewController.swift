//
//  FoodViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class FoodViewController: BasedCollectionViewController {
    
    var arrFood = [Eat]()
    var isLunch: Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func btnBackClicked(_ sender: Any) {
        super.btnBackClicked(Any.self)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
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
        if let img = arrFood[indexPath.row].img{
            imageView.sd_setImage(with: URL.init(string: img))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let mainStoryboard: UIStoryboard! = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc: DetailFoodViewController! = mainStoryboard.instantiateViewController(withIdentifier: "DetailFoodViewController") as! DetailFoodViewController
        vc.title = "Detail"
        vc._id = arrFood[indexPath.row]._id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
