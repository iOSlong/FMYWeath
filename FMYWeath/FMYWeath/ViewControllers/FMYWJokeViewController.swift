//
//  FMYWJokeViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/25.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWJokeViewController: FMYWViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView? =  nil
    var dataSource:NSMutableArray? = ["笑话一排排","笑图乐哈哈"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false


        self.configureTableView()

    }
    
    
    func configureTableView() {
        self.tableView =  UITableView(frame: self.view.frame, style: .grouped)
        self.tableView?.height = self.view.height - myTabBarH - myStatusBarH
        self.view.addSubview(self.tableView!)
        self.tableView?.dataSource   = self
        self.tableView?.delegate     = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSource?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "jokeBaseCellIdentifier"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as! FMYWJokeTableCell?
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.accessoryType = .disclosureIndicator
        
        let title = self.dataSource?[indexPath.row];
        cell?.textLabel?.text = title as! String?;
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let jokeDetailVC:FMYWJokeListViewController = FMYWJokeListViewController()
        jokeDetailVC.jokeSection = self.dataSource?[indexPath.row] as! String?
        self.navigationController?.pushViewController(jokeDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
