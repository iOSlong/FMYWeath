//
//  FMYWJokePicViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/11.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit
import MJRefresh

class FMYWJokePicViewController: FMYWViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:FMYTableView? =  nil
    var dataSource:NSMutableArray? = []
    var refreshHeader:MJRefreshHeader? = nil
    var refreshFooter:MJRefreshBackNormalFooter? = nil

    var pageCurrent = 0

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as! FMYWTabBarViewController).setBarHidden(hidden:true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
        
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
        self.tableView =  FMYTableView(frame: self.view.frame, style: .plain)
        self.tableView?.height = self.view.height - myNavBarH
        self.tableView?.dataSource   = self
        self.tableView?.delegate     = self
//        self.tableView?.separatorColor = colorMainBack
        
        self.tableView?.mj_header   = self.refreshHeader
        self.tableView?.mj_footer   = self.refreshFooter

        self.view.addSubview(self.tableView!)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSource?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = NSStringFromClass(self.classForCoder)
        var cell:FMYWJokePicTableCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FMYWJokePicTableCell
        if cell == nil {
            cell = FMYWJokePicTableCell(style: .default, reuseIdentifier: identifier)
        }
        
        if (self.dataSource?.count)! > indexPath.row {
            let jokePicModel = self.dataSource?[indexPath.row]
            cell?.jokePicModel = jokePicModel as! FMYWJokePicModel?;
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    @objc func reloadTableItems() {
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
        
        self.netGetJokPic(param: params, loadMore: false)
    }
    
    func loadMoreData()  {
        let date    = Date(timeIntervalSinceNow: 0)
        let params:NSDictionary  =    ["key"  :apiKey_joke,
                                       "sort" :"desc",
                                       "time" :String(Int(date.timeIntervalSince1970)),
                                       "page" :String(pageCurrent),
                                       "pagesize":pageSize]
        
        self.netGetJokPic(param: params, loadMore: true)
    }
    

    func netGetJokPic(param:NSDictionary?, loadMore:Bool) -> Void {
        
        _ = FMYHTTPSessionManager(url: URL(string: url_jokeListImage), configuration: nil).net("GET", parameters: param, success: { (dataTask, object) in
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
                    let tempItem = FMYWJokePicModel.deserialize(from:element)
                    self.dataSource?.add(tempItem as Any)
                }
                
                self.perform(#selector(self.reloadTableItems), on:  Thread.main, with: self, waitUntilDone: false)
                
            } catch (let error) {
                let dataStr =  String(data: object as! Data, encoding: .utf8)
                print(error,dataStr ?? "")
            }
            
            
        }, failure: { (dataTask, error) in
            
            print(error)
            print(dataTask ?? "empty    ")

            DispatchQueue.main.async {
                self.refreshHeader?.endRefreshing()
                self.refreshFooter?.endRefreshing()
            }

        })
    }
    
    
}
