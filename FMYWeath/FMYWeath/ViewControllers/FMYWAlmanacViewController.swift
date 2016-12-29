//
//  FMYWAlmanacViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/28.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWAlmanacViewController: FMYWViewController, UIScrollViewDelegate {
    
    private var scroll:UIScrollView?
    var scrollView:UIScrollView {
        get {
            if scroll == nil {
                scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: myScreenW, height: myScreenH - myTabBarH - myNavBarH))
                scroll?.isPagingEnabled = true
                scroll?.delegate = self
//                scroll?.bounces  = false
            }
            return scroll!
        }
    }

    var almanacPlarArr:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.configureUIItems()
        
        for ival in ["",""] {
            self.netGetAlmanac(date: ival)
        }
        
        self.netGetAlmanac(date: "")

    }
    
    func configureUIItems() {
        self.view.addSubview(self.scrollView)
    }
    
    
    func loadAlmanacPlatFromData(almanacModel:FMYWAlmanacModel?) -> Void {
        if almanacModel != nil {
            let almanacPlat = FMYWAlmanacPlatView(frame: self.scrollView.bounds)
            almanacPlat.almanacModel = almanacModel
            self.scrollView.addSubview(almanacPlat)
            self.almanacPlarArr.add(almanacPlat)
        }
        
        for index in 0...self.almanacPlarArr.count - 1 {
            let almanacPlat:FMYWAlmanacPlatView = self.almanacPlarArr[index] as! FMYWAlmanacPlatView
            almanacPlat.left = CGFloat(index) * self.scrollView.width
            if index == 1 {
                almanacPlat.backgroundColor = .yellow
            }
        }
        self.scrollView.contentSize = CGSize(width: CGFloat(self.almanacPlarArr.count) * self.scrollView.width, height: self.scrollView.height)
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
                
                DispatchQueue.main.async {
                    self.loadAlmanacPlatFromData(almanacModel: almanac)
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
