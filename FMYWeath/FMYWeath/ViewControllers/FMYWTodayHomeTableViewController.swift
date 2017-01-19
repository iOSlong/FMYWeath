//
//  FMYWTodayHomeTableViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/3.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYWTodayHomeTableViewController: UITableViewController {
    var sourceArr:NSMutableArray = {
       let muArr = NSMutableArray()
        muArr.add(["VC":"FMYWAlmanacViewController","name":"黄道在今"])
        muArr.add(["VC":"FMYWTodayNewsViewController","name":"今日头条"])
        muArr.add(["VC":"FMYWTodayHistoryViewController","name":"历史今日"])
        return muArr
    }()
    var platGreGorianCal:GreGorianCalView = {
        let greGorin = GreGorianCalView(frame:.zero)
        greGorin.width    = myScreenW
        greGorin.height   = 110
        return greGorin
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let almanac = FMYWAlmanacModel()
        almanac.yangli = timeShow(time: Date().timeIntervalSince1970, formateStr: .TFy_M_d)
        self.platGreGorianCal.almanac = almanac
        (self.tabBarController as! FMYWTabBarViewController).setBarHidden(hidden:false)
    }

    override init(style: UITableViewStyle) {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableHeaderView = self.platGreGorianCal
        self.tableView.backgroundColor = .clear
        self.tableView?.separatorColor = colorMainBarBack
        
        
        // 将返回按钮的标题设置为空
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifer = NSStringFromClass(self.classForCoder)
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: reuseIdentifer)
        }
        cell?.backgroundColor = .clear
        cell?.textLabel?.textColor = .white
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .blue

        let item:NSDictionary = self.sourceArr[indexPath.row] as! NSDictionary
        let desName = item.object(forKey: "name")

        cell?.textLabel?.text = desName as! String?

        return cell!
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item:NSDictionary = self.sourceArr[indexPath.row] as! NSDictionary
//        let desVCName:String = item.object(forKey: "VC") as! String
        // TODO 字符串转类
//        let desClass:AnyClass = NSClassFromString(desVCName)!
//        let desVC:UIViewController  = desClass.alloc() as! UIViewController
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        var desVC:UIViewController? = nil
        if indexPath.row == 0 {
            desVC = FMYWAlmanacViewController()
        }else if indexPath.row == 1 {
            desVC = FMYWTodayNewsViewController()
        }else if indexPath.row == 2 {
            desVC = FMYWTodayHistoryViewController()
        }
        self.navigationController?.pushViewController(desVC!, animated: true)

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

}
