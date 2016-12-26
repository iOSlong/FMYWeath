//
//  FMYWTodayHistoryViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/26.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit
import MJRefresh

class FMYWTodayHistoryViewController: FMYWViewController , UITableViewDelegate, UITableViewDataSource{

    var tableView:UITableView? =  nil
    var dataSource:NSMutableArray? = []
    var refreshHeader:MJRefreshHeader? = nil
    var refreshFooter:MJRefreshBackNormalFooter? = nil
    
    var pageCurrent = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
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
            let modelItem:FMYWTodayHistoryModel = self.dataSource![indexPath.row] as! FMYWTodayHistoryModel
            cell?.textLabel?.text = modelItem.title as? String;
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellItem:FMYWTodayHistoryModel = self.dataSource![indexPath.row] as! FMYWTodayHistoryModel
        let detailVC = FMYWTodayHistoryDetailViewController()
        detailVC.todayHistoryModel = cellItem
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func reloadTableItems() {
        self.tableView?.reloadData()
    }
    
    
    
    func loadNewData() {
        
//        TODO：处理时间 格式，
        let date    = timeShow(time: Date().timeIntervalSince1970, formateStr: .TFM_d)
        self.pageCurrent += 0
        let params:NSDictionary  =    ["key"  :apiKey_today,
                                       "date" :date]
        
        self.netTodayHistoryList(params: params, loadMore: false)
    }
    
    func loadMoreData()  {
        let date    = timeShow(time: Date().timeIntervalSince1970, formateStr: .TFM_d)
        let params:NSDictionary  =    ["key"  :apiKey_today,
                                       "date" :date]
        
        self.netTodayHistoryList(params: params, loadMore: false)
    }
    
    
    
    func netTodayHistoryList(params:NSDictionary, loadMore:Bool) {
        
        let httpSession = FMYHTTPSessionManager(url: URL(string: url_todayOnHistory), configuration: nil)
        
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
                let resultArray:NSArray = (responseDict as! NSDictionary).object(forKey: "result") as! NSArray
                
                if loadMore == false && resultArray.count > 0 {
                    self.dataSource?.removeAllObjects()
                }else if loadMore == true && resultArray.count == Int(pageSize) {
                    
                }
                
                for index in 0...resultArray.count-1 {
                    let element = resultArray[index] as! Dictionary<String, Any>
                    let jokeItem = FMYWTodayHistoryModel()
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
