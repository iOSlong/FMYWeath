//
//  FMYWAlmanacPartTimeTableViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/30.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWAlmanacPartTimeTableViewController: UITableViewController {

    var almanacModel:FMYWAlmanacModel?
    var partTimeModeArr:NSMutableArray = NSMutableArray()

    var dateInfo:UIButton? = nil
    private var _sectionHader:UIView? = nil
    var sectionHeader:UIView? {
        get {
            if _sectionHader == nil {
                _sectionHader = UIView(frame: CGRect(x: 0, y: 0, width: mySpanH, height: 50))
//                _sectionHader?.backgroundColor = .white
                self.dateInfo = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 25))
                self.dateInfo?.layer.cornerRadius = (self.dateInfo?.height)! * 0.5
                self.dateInfo?.layer.borderColor    = UIColor.blue.cgColor
                self.dateInfo?.layer.borderWidth    = 1
                self.dateInfo?.left = mySpanLeft * 2
                self.dateInfo?.centerY = (_sectionHader?.height)! * 0.5
                self.dateInfo?.setTitleColor(.blue, for: .normal)
                self.dateInfo?.setTitle((self.almanacModel?.showTime)!, for: .normal)
                self.dateInfo?.titleLabel?.font = UIFont.boldSystemFont(ofSize: myFont.font_min02.rawValue)
                _sectionHader?.addSubview(self.dateInfo!)
            }
            return _sectionHader
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "子丑寅卯"

        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .black
    
        self.netGetTimeDestiny(date: self.almanacModel?.showTime)
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionHeader
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (self.sectionHeader?.height)!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.partTimeModeArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifer:String = NSStringFromClass(self.classForCoder)
        var cell:FMYWAlmanacPartTimeTableCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) as? FMYWAlmanacPartTimeTableCell
        if cell == nil {
            cell = FMYWAlmanacPartTimeTableCell(style: .default, reuseIdentifier: cellIdentifer)
        }
        cell?.selectionStyle = .none
        
        let ptModel = self.partTimeModeArr[indexPath.row];
        cell?.partMode = ptModel as? AlmanacPartTimeMode
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func netGetTimeDestiny(date:String?) -> Void {
        let param = ["key":apiKey_almanac, "date":date]
        _ = FMYHTTPSessionManager(url: URL(string: url_almanac_h), configuration: nil).net("GET", parameters: param as NSDictionary?, success: { (dataTask, object) in
            
            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                
                let resultItem:NSArray = (responseDict as! NSDictionary).object(forKey: "result") as! NSArray
                
                for item in resultItem {
                    let ptModel:AlmanacPartTimeMode = AlmanacPartTimeMode()
                    ptModel.setValuesForKeys(item as! [String : Any])
                    self.partTimeModeArr.add(ptModel)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch (let error) {
                let dataStr =  String(data: object as! Data, encoding: .utf8)
                print(error,dataStr ?? "")
            }
            
        }, failure: { (dataTask, error) in
            
            print(error)
            
        })
    }

}
