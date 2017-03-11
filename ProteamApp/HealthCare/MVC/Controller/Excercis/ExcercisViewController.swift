//
//  ExcercisViewController.swift
//  HealthCare
//
//  Created by IchIT on 3/10/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ExcercisViewController: BasedViewController,IndicatorInfoProvider,ExcercisCellDelegate {
    
    let cellIdentifier = "ExcercisCell"
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseCate = [ExerciseCategory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
//        for family: String in UIFont.familyNames
//        {
//            print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
        loadData()
    }
    
    func loadData(){
        self.showProgress()
        APIModel.getAllExerciseCategory(completion: { (exerciseCate) in
            self.dismissProgress()
            self.exerciseCate = exerciseCate
            self.tableView.reloadData()
        }) { (error) in
            self.dismissProgress()
        }
    }
    
    @IBAction func btnMenuClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    //MARK: EXCERCIS CELL DELEGATE
    func btnSeeAllTouchup(_ index: Int){
        
        let excerSeeAll = ExcercisSeeAllVC()
        let excerCate = exerciseCate[index]
        excerSeeAll.title = excerCate.name
        
        if let items = exerciseCate[index].items {
            excerSeeAll.exercises = items
        }
        
        self.navigationController?.pushViewController(excerSeeAll, animated: true)
        print("sell all")
    }
    
    func didSelectRowAtSliderCell(youtube_id:String,title:String){
        let neckExcercise = NeckExcerciseViewController()
        neckExcercise.youtube_id = youtube_id
        neckExcercise.title = title
        self.navigationController?.pushViewController(neckExcercise, animated: true)
    }
    
    // MARK: - INDICATORINFO Provider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ExcercisViewController: UITableViewDelegate,UITableViewDataSource{
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseCate.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExcercisCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        if let excers = exerciseCate[indexPath.row].items {
            cell.excercises = excers
            cell.tbvTopicExcercis.reloadData()
        }
        
        if let name = exerciseCate[indexPath.row].name{
            cell.lblTitle.text = name
        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
