//
//  FavouritesViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavouritesViewController: BaseButtonBarPagerTabStripViewController<FavouriteTabBarCell> {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: "FavouriteTabBarCell", bundle: Bundle(for: FavouriteTabBarCell.self), width: { (cell: IndicatorInfo) -> CGFloat in
//            return self.buttonBarView.bounds.size.width/2
            return 0
        })
    }
    
    override func viewDidLoad() {
        
        setupPagerTabStrip()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        changeCurrentIndexProgressive = { (oldCell: FavouriteTabBarCell?, newCell: FavouriteTabBarCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.bounds.size.width = self.buttonBarView.bounds.size.width/2
            oldCell?.bounds.size.height = 80
            oldCell?.setCornerRadius(radius:20)
            oldCell?.viewContent.backgroundColor = UIColor.init(hex: "#FAC46B")
            
            newCell?.bounds.size.width = self.buttonBarView.bounds.size.width/2
            newCell?.bounds.size.height = 80
            newCell?.setCornerRadius(radius:20)
            newCell?.viewContent.backgroundColor = UIColor.white
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
        
        let child_1 = EatFavouriteViewController()
        let child_2 = ExFavouriteViewController()
        
        return [child_1,child_2]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //containerView.contentSize.height = Constants.Systems.screen_size.height + 350
    }
    
    override func configure(cell: FavouriteTabBarCell, for indicatorInfo: IndicatorInfo) {
        cell.lblTitle.text = indicatorInfo.title
    }
}
