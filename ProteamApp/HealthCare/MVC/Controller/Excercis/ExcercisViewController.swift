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
    let cellIdentifier1 = "ExcercisCell1"
    @IBOutlet weak var tableView: UITableView!
    
    var exerciseCate = [ExerciseCategory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.register(UINib(nibName: cellIdentifier1, bundle: nil), forCellReuseIdentifier: cellIdentifier1)
        
        tableView.separatorStyle = .none
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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
    
    func didSelectRowAtSliderCell(exercise:Exercise,title:String){
        let neckExcercise = NeckExcerciseViewController()
        neckExcercise.exercise = exercise
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
        if indexPath.section == 0 {
            return 50
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return exerciseCate.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1, for: indexPath) as! ExcercisCell
            cell.selectionStyle = .none
            return cell
        }
        
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
