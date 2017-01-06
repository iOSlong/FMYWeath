
//
//  FMYWJokeListViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/26.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit
import MJRefresh

class FMYWJokeListViewController: FMYWViewController,UITableViewDataSource, UITableViewDelegate {
    
    var jokeSection:String? = nil
    
    var tableView:UITableView? =  nil
    var dataSource:NSMutableArray? = []
    var refreshHeader:MJRefreshHeader? = nil
    var refreshFooter:MJRefreshBackNormalFooter? = nil
    
    var pageCurrent = 0
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as! FMYWTabBarViewController).setBarHidden(hidden:true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (self.tabBarController as! FMYWTabBarViewController).setBarHidden(hidden:false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = self.jokeSection
        
        self.configureFreshItems()
        
        self.configureTableView()
        
        self.refreshHeader?.beginRefreshing()
    }
    func configureFreshItems()  {
        self.refreshHeader = MJRefreshNormalHeader(refreshingBlock: {
            print("下拉刷新 ……")
            self.loadNewData()
        })
        
        self.refreshFooter = MJRefreshBackNormalFooter.init(refreshingBlock: {
            print("上拉加载 ……")
            self.loadMoreData()
        })
    }
    func configureTableView() {
        self.tableView =  UITableView(frame: self.view.frame, style: .plain)
        self.tableView?.height = self.view.height - myTabBarH - myStatusBarH
        self.view.addSubview(self.tableView!)
        self.tableView?.dataSource   = self
        self.tableView?.delegate     = self
        self.tableView?.mj_header   = self.refreshHeader
        self.tableView?.mj_footer   = self.refreshFooter
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
        cell?.accessoryType = .disclosureIndicator

        if (self.dataSource?.count)! > indexPath.row {
            let jokeItem:FMYWJokeModel = self.dataSource![indexPath.row] as! FMYWJokeModel
            cell?.setJokeModel(jokeModel: jokeItem)
        }
        
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
    
    
    
    func loadNewData() {
        
        let date    = Date(timeIntervalSinceNow: 0)
        self.pageCurrent += 0
        let params:NSDictionary  =    ["key"  :apiKey_joke,
                                       "sort" :"desc",
                                       "time" :String(Int(date.timeIntervalSince1970)),
                                       "page" :"0",
                                       "pagesize":pageSize]
        
        self.netGetJokeList(params: params, loadMore: false)
    }
    
    func loadMoreData()  {
        let date    = Date(timeIntervalSinceNow: 0)
        let params:NSDictionary  =    ["key"  :apiKey_joke,
                                       "sort" :"desc",
                                       "time" :String(Int(date.timeIntervalSince1970)),
                                       "page" :String(pageCurrent),
                                       "pagesize":pageSize]
        
        self.netGetJokeList(params: params, loadMore: true)
    }
    
    
    
    func netGetJokeList(params:NSDictionary, loadMore:Bool) {
        
        let httpSession = FMYHTTPSessionManager(url: URL(string: url_jokeList), configuration: nil)
        
        _ =  httpSession.net("GET", parameters: params, success: { (dataTask, object) in
            
            DispatchQueue.main.async {
                self.refreshHeader?.endRefreshing()
                self.refreshFooter?.endRefreshing()
            }
            self.pageCurrent += 1
            
            print(object)
            print(dataTask ?? "empty")
            
            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                let resultDict:NSDictionary = (responseDict as! NSDictionary).object(forKey: "result") as! NSDictionary
                let dataElement:NSArray = resultDict.object(forKey: "data") as! NSArray
                
                if loadMore == false && dataElement.count > 0 {
                    self.dataSource?.removeAllObjects()
                }else if loadMore == true && dataElement.count == Int(pageSize) {
                    
                }
                
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
