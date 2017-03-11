//
//  ExFavouriteViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ExFavouriteViewController: BasedTableViewController, IndicatorInfoProvider {

    var dataSource = [String]()
    var cellIdentifier:String! = "FavoriteExTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource.insert("img-demo", at: 0)
        dataSource.insert("img-demo", at: 1)
        dataSource.insert("img-demo", at: 2)
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - INDICATORINFO Provider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "")
    }
    
    @IBAction func btnBackTouch(_ sender: Any) {
        super.btnBackClicked(sender)
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: FavoriteExTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoriteExTableViewCell
        
        if cell == nil {
            cell = FavoriteExTableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell.imvContent.image = UIImage.init(named: dataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
       
        
    }

}
