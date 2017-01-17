//
//  FMYWTodayNewsListViewController.swift
//  FMYWeath
//
//  Created by xw.long on 17/1/1.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit
import MJRefresh


class FMYWTodayNewsListViewController: UITableViewController {

    var arrNewsItems:NSMutableArray = []
    var newsType:FMYWNewsType? = nil
    var refreshHeader:MJRefreshNormalHeader? = nil
    var refreshFooter:MJRefreshBackNormalFooter? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor  = colorMainBlack
        self.tableView.separatorColor   = colorMainBarBack

        self.configureFreshItems()
        
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

        self.tableView.mj_footer = self.refreshFooter
        self.tableView.mj_header = self.refreshHeader

    }


    func loadNewData() {
        let type =  self.newsType?.type as! String
        let param = ["type":type,
                     "key":apiKey_toutiao]
        self.netGetNews(params: param as NSDictionary, loadMore: false)

    }

    func loadMoreData()  {
        let type =  self.newsType?.type as! String
        let param = ["type":type,
                     "key":apiKey_toutiao]
        self.netGetNews(params: param as NSDictionary, loadMore: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNewsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        var cell:FMYWNewsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "newsItemCellreuseID") as? FMYWNewsTableViewCell
        if cell == nil {
            cell = FMYWNewsTableViewCell.init(style: .subtitle, reuseIdentifier: "newsItemCellreuseID")
        }
        if indexPath.row < self.arrNewsItems.count {
            let newsItem = self.arrNewsItems[indexPath.row]

            cell?.newsItem = newsItem as? FMYWNewsItemModel

        }
        cell?.accessoryType = .disclosureIndicator

        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemVC:FMYWNewsDetailViewController = FMYWNewsDetailViewController()
        itemVC.newsItem = self.arrNewsItems[indexPath.row] as? FMYWNewsItemModel
        self.navigationController?.pushViewController(itemVC, animated: true)
    }


    func netGetNews(params:NSDictionary, loadMore:Bool) -> Void {
        _ = FMYHTTPSessionManager(url: URL(string:url_newsToutiao), configuration: nil).net("GET", parameters: params, success: {[unowned self] (dataTask, responsObj) in

            DispatchQueue.main.async {
                self.refreshHeader?.endRefreshing()
                self.refreshFooter?.endRefreshing()
            }

            do {
                let responseDict =  try JSONSerialization.jsonObject(with: responsObj as! Data, options:.mutableLeaves)

                let resultItem:NSDictionary = (responseDict as! NSDictionary).object(forKey: "result") as! NSDictionary

                let dataItem:NSArray  = resultItem.object(forKey: "data") as! NSArray

                self.arrNewsItems.removeAllObjects()
                for item in dataItem {
                    let newsItem = FMYWNewsItemModel()
                    let itemDict:NSDictionary = item as! NSDictionary
                    newsItem.setValuesForKeys(itemDict as! [String : Any])
                    self.arrNewsItems.add(newsItem)
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch (let error) {
                let dataStr =  String(data: responsObj as! Data, encoding: .utf8)
                print(error,dataStr ?? "")
            }

        }, failure: {(dataTask, error ) in
            DispatchQueue.main.async {
                self.refreshHeader?.endRefreshing()
                self.refreshFooter?.endRefreshing()
            }

            print(error)
        })
    }

}
