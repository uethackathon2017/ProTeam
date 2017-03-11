//
//  FavouritesViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavouritesViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        setupPagerTabStrip()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.font = UIFont(name: "UTM Avo", size: 14)
            oldCell?.layer.borderColor = UIColor(hex:"471500").cgColor
            oldCell?.layer.borderWidth = 1
            oldCell?.label.textColor = UIColor.clear
            newCell?.label.textColor = UIColor(hex:"471500")
            newCell?.label.font = UIFont(name: "UTM Avo", size: 14)
            
            oldCell?.bounds.size.width = 8
            oldCell?.setCornerRadius(radius: ((oldCell?.bounds.size.width)!/2))
            oldCell?.backgroundColor = UIColor.clear
            
            newCell?.bounds.size.width = 8
            newCell?.setCornerRadius(radius: ((newCell?.bounds.size.width)!/2))
            newCell?.backgroundColor = UIColor(hex:"471500")
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        if self.navigationController != nil {
           self.navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func setupPagerTabStrip(){
        settings.style.buttonBarBackgroundColor = UIColor.clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor(hex:"f578a2")
        settings.style.selectedBarHeight = 0.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = ExFavouriteViewController()
        let child_2 = EatFavouriteViewController()
        
        return [child_1,child_2]
    }
    
    override func configureCell(_ cell: ButtonBarViewCell, indicatorInfo: IndicatorInfo) {
        super.configureCell(cell, indicatorInfo: indicatorInfo)
        cell.backgroundColor = UIColor.clear
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
