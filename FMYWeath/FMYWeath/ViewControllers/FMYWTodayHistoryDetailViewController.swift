//
//  FMYWTodayHistoryDetailViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/26.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWTodayHistoryDetailViewController: FMYWViewController , UITableViewDataSource, UITableViewDelegate{

    var  todayHistoryModel:FMYWTodayHistoryModel? = nil
    private var historyDetail:FMYWTodayHistoryModel? = nil

    var tableView:UITableView? =  nil

    var textViewDetail:UITextView? = nil

    var headerView:UIView = {
        let headerView =  UIView(frame: CGRect(x: 0, y: 0, width: myScreenW, height: 100))
        return headerView
    }()

    var footerView:FMYWImgShowView = {
        let footerView = FMYWImgShowView(frame:CGRect(x: mySpanH, y: mySpanV, width: myScreenW - 2 * mySpanH, height: 300))
        return footerView
    }()
    
    var picURL:NSMutableArray? = nil

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.todayHistoryModel?.title as! String?
        self.historyDetail = FMYWTodayHistoryModel()
        self.picURL = NSMutableArray()

        self.configureUIItems()

        self.refreshDataSource()
        
        
    }

    func configureUIItems() {
        self.tableView =  UITableView(frame: self.view.frame, style: .plain)
        self.tableView?.height = self.view.height
        self.view.addSubview(self.tableView!)
        self.tableView?.dataSource   = self
        self.tableView?.delegate     = self


        self.textViewDetail = UITextView(frame: CGRect(x: mySpanLeft, y: mySpanUp, width: myScreenW - 2 * mySpanLeft, height: self.view.height - myTabBarH))
        self.textViewDetail?.font = UIFont.systemFont(ofSize: 20)
        self.textViewDetail?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.textViewDetail?.textAlignment = .left
        self.textViewDetail?.text = self.todayHistoryModel?.title as! String!
        self.textViewDetail?.bounces = false
        self.textViewDetail?.isEditable = false
        self.headerView.addSubview(self.textViewDetail!)
        self.tableView?.tableHeaderView = self.headerView
        self.tableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: myScreenW, height: 5))


        // MARK: 回调函数    TODO: 图片浏览，图片收藏，
        self.footerView.imgShow { (selectedIndex, picURL) in
            print(selectedIndex,picURL)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  ((self.picURL?.count)! > 0 ? "相关图片" : "") + ((self.picURL?.count)! > 1 ? "(\(self.picURL!.count))" : "")
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.picURL?.count)! > 0 {
            return 1;
        }
        return (self.picURL?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "jokeBaseCellIdentifier"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        }

        cell?.contentView.addSubview(self.footerView)
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.footerView.height + 2 * mySpanH
    }
    

    func reloadUIItems()  {


        let jokeContent = (self.historyDetail?.title as! String) + "\n\n" + (self.historyDetail?.content as! String)
        self.textViewDetail?.text = jokeContent
        self.textViewDetail?.sizeToFit()
        
        self.headerView.height = (self.textViewDetail?.height)! + 2 * mySpanUp
        self.headerView.backgroundColor = UIColor.darkGray

        let picUrls = self.historyDetail?.picUrl as! NSArray
        for element in picUrls {
            print(element)
        }

        self.picURL?.addObjects(from: picUrls as! [Any])
        if (self.picURL?.count)! > 0 {
            self.footerView.setPicUrl(picUrl: self.picURL!)
        }
        

        self.tableView?.reloadData()
    }






    func refreshDataSource() {
        let params:NSDictionary  =    ["key"  :apiKey_today,
                                       "e_id" :self.todayHistoryModel?.ID ?? ""]
        self.netTodayHistoryList(params: params, loadMore: false)
    }




    func netTodayHistoryList(params:NSDictionary, loadMore:Bool) {
        
        let httpSession = FMYHTTPSessionManager(url: URL(string: url_todayOnHistoryDetail), configuration: nil)
        
        _ =  httpSession.net("GET", parameters: params, success: { (dataTask, object) in
            
            DispatchQueue.main.async {
                
            }
            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                
                let resultArray:NSArray? = (responseDict as! NSDictionary).object(forKey: "result") as? NSArray
                
                if (resultArray != nil) {
                    
                    let itemDict = resultArray?.firstObject as! Dictionary<String, Any>
                    
                    //                self.historyDetail = FMYWTodayHistoryModel()
                    self.historyDetail?.setValuesForKeys(itemDict)
                    
                    self.perform(#selector(self.reloadUIItems), on:  Thread.main, with: self, waitUntilDone: false)
                }
                
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




