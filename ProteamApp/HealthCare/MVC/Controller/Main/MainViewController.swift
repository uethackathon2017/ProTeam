//
//  MainViewController.swift
//  HealthCare
//
//  Created by IchIT on 3/5/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        setupPagerTabStrip()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.font = UIFont(name: "UTM Avo", size: 14)
            oldCell?.label.textColor = UIColor(hex:"000000")
            newCell?.label.textColor = UIColor(hex:"ff81a5")
            newCell?.label.font = UIFont(name: "UTM Avo", size: 14)
            
            oldCell?.bounds.size.width = 6
            oldCell?.setCornerRadius(radius: ((oldCell?.bounds.size.width)!/2))
            oldCell?.backgroundColor = UIColor.red
            
            newCell?.bounds.size.width = 6
            newCell?.setCornerRadius(radius: ((newCell?.bounds.size.width)!/2))
            newCell?.backgroundColor = UIColor.blue
        }
        self.automaticallyAdjustsScrollViewInsets = false
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
        let child_1 = ExcercisViewController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let child_2 = storyboard.instantiateViewController(withIdentifier: "EatViewController") as! EatViewController

        let child_3 = ExcercisViewController()

        return [child_1,child_2,child_3]
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
