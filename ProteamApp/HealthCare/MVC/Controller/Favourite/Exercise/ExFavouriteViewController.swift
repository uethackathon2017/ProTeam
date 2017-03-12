//
//  ExFavouriteViewController.swift
//  HealthCare
//
//  Created by Vinh Nguyen on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class ExFavouriteViewController: BasedTableViewController, IndicatorInfoProvider,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    var dataSource = [String]()
    var cellIdentifier:String! = "FavoriteExTableViewCell"
    var arrExcer = [Exercise]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = ["fav_ex_logo", "fav_eat_logo", "fav_ex_logo"]
        
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
       loadData()
    }
    
    func loadData(){
        self.showProgress()
 
        APIModel.getFavoriteExercise(completion: { (list) in
            self.arrExcer = list
            self.tableView.reloadData()
            self.tableView.emptyDataSetSource = self
            self.tableView.emptyDataSetDelegate = self
            self.tableView.reloadEmptyDataSet()
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
        return -self.tableView!.frame.size.height/5
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSFontAttributeName: UIFont(name: "UTM-Neo-Sans-Intel", size: 16)!]
        return NSAttributedString(string: "Không có dữ liệu", attributes: attributes)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - INDICATORINFO Provider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "Exercises")
    }
    
    // MARK: - Action
    
    func btnDeleteClicked(_ sender: UIButton) {
        let index = sender.tag
        let exercise = arrExcer[index]
        self.showProgress()
        APIModel.unlikeExercise(exercise._id, completion: { (mes) in
        self.dismissProgress()
        self.loadData()
        }, failure: { (error) in
        self.dismissProgress()
        })
        
    }
    
    func btnPlayClicked(_ sender: UIButton) {
        let index = sender.tag
        let exercise = arrExcer[index]
        let neckExcercise = NeckExcerciseViewController()
        neckExcercise.exercise = exercise
        neckExcercise.title = exercise.name
        self.navigationController?.pushViewController(neckExcercise, animated: true)
    }
    
    @IBAction func btnBackTouch(_ sender: Any) {
        super.btnBackClicked(sender)
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrExcer.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 30))
        view.backgroundColor = UIColor.white
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: FavoriteExTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoriteExTableViewCell
        
        if cell == nil {
            cell = FavoriteExTableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        if let img = arrExcer[indexPath.row].thumnail {
            cell.imvContent.sd_setImage(with: URL.init(string: img))
        }
        
        
        cell.btnClose.addTarget(self, action: #selector(ExFavouriteViewController.btnDeleteClicked(_:)), for: .touchUpInside)
        cell.btnClose.tag = indexPath.row
        
        cell.btnPlay.addTarget(self, action: #selector(ExFavouriteViewController.btnPlayClicked(_ :)), for: .touchUpInside)
        cell.btnPlay.tag = indexPath.row
        
        print(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
       print(indexPath.row)
        
    }

}
