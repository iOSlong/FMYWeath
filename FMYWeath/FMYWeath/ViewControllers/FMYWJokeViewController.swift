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
    var dataSource:NSMutableArray? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false


        self.configureTableView()

        self.netGetJokeList()
    }

    func configureTableView() {
        self.tableView =  UITableView(frame: self.view.frame, style: .plain)
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
        var cell:FMYWJokeTableCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as! FMYWJokeTableCell?
        if cell == nil {
            cell = FMYWJokeTableCell(style: .default, reuseIdentifier: identifier)
        }

        let jokeItem:FMYWJokeModel = self.dataSource![indexPath.row] as! FMYWJokeModel
        cell?.setJokeModel(jokeModel: jokeItem)

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let jokeItem:FMYWJokeModel = self.dataSource![indexPath.row] as! FMYWJokeModel
        let jokeDetailVC:FMYWJokeDetailViewController = FMYWJokeDetailViewController()
        jokeDetailVC.jokeItem = jokeItem
        self.navigationController?.pushViewController(jokeDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


    func reloadTableItems() {
        self.tableView?.reloadData()
    }

    func netGetJokeList() {

        let httpSession = FMYHTTPSessionManager(url: URL(string: url_jokeList), configuration: nil)

        let date    = Date(timeIntervalSinceNow: 0)
        let params:NSDictionary  =    ["key"  :apiKey_joke,
                                       "sort" :"desc",
                                       "time" :String(Int(date.timeIntervalSince1970)),
                                       "page" :"0",
                                       "pagesize":"10"]

        _ =  httpSession.net("GET", parameters: params, success: { (dataTask, object) in

            print(object)
            print(dataTask ?? "empty")

            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                let resultDict:NSDictionary = (responseDict as! NSDictionary).object(forKey: "result") as! NSDictionary
                let dataElement:NSArray = resultDict.object(forKey: "data") as! NSArray
                for index in 0...dataElement.count-1 {
                    let element = dataElement[index] as! Dictionary<String, Any>
                    let jokeItem = FMYWJokeModel()
                    jokeItem.setValuesForKeys(element)
                    print(jokeItem)
                    self.dataSource?.add(jokeItem)
                }

                self.perform(#selector(self.reloadTableItems), on:  Thread.main, with: self, waitUntilDone: false)

            } catch (let error) {
                let dataStr =  String(data: object as! Data, encoding: .utf8)
                print(error,dataStr ?? "")
            }

        }, failure: { (dataTask, error) in
            print(error)
            print(dataTask ?? "empty    ")
            
        })
        
    }
    
}
