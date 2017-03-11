//
//  MainViewController.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        setupPagerTabStrip()
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
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
        
        //
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName as! String)
            print("Font Names = [\(names)]")
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnMenuClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()
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

        let child_3 = DrinkViewController()

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
