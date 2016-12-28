//
//  FMYWAlmanacViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/28.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWAlmanacViewController: FMYWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.netGetAlmanac(date: nil)

    }
    
    func netGetAlmanac(date:String?) {
        let date    = timeShow(time: Date().timeIntervalSince1970, formateStr: .TFy_M_d)
        let param = ["key":apiKey_almanac, "date":date]
        
        _ = FMYHTTPSessionManager(url: URL(string: url_almanac), configuration: nil).net("GET", parameters: param as NSDictionary?, success: { (dataTask, object) in
            
            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                
                let resultItem:NSDictionary = (responseDict as! NSDictionary).object(forKey: "result") as! NSDictionary
                
                print(resultItem)
                
                let almanac = FMYWAlmanacModel()
                almanac.setValuesForKeys(resultItem as! [String : Any])
                
                print(almanac.yiItems)
                                
                
    
                
//                for index in 0...resultArray.count-1 {
//                    let element = resultArray[index] as! Dictionary<String, Any>
//                    let jokeItem = FMYWTodayHistoryModel()
//                    jokeItem.setValuesForKeys(element)
//                    print(jokeItem)
//                    self.dataSource?.add(jokeItem)
//                }
                
//                self.perform(#selector(self.reloadTableItems), on:  Thread.main, with: self, waitUntilDone: false)
                
            } catch (let error) {
                let dataStr =  String(data: object as! Data, encoding: .utf8)
                print(error,dataStr ?? "")
            }
            
        }, failure: { (dataTask, error) in
            
            print(error)
            
        })
    }
}
