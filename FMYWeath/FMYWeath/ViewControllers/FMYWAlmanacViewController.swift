//
//  FMYWAlmanacViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/28.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWAlmanacViewController: FMYWViewController, UIScrollViewDelegate, AlmanacPlatViewDelegate {
    
    let timeDaySpan = 24 * 60 * 60
    var showDayIndex = 1
    var showDayLocation = 0
    private var scroll:UIScrollView?
    var scrollView:UIScrollView {
        get {
            if scroll == nil {
                scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: myScreenW, height: myScreenH - myTabBarH - myNavBarH))
                scroll?.isPagingEnabled = true
                scroll?.delegate = self
                scroll?.showsHorizontalScrollIndicator = false
//                scroll?.bounces  = false
            }
            return scroll!
        }
    }

    var almanacPlarArr:NSMutableArray = NSMutableArray()
    var almanacModelArr:NSMutableArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.configureUIItems()
        
        let dateNow         = Date()
        let dayToday        = dateFrom(span: 0, date: dateNow)
        let dayTomorrow     = dateFrom(span: TimeInterval(timeDaySpan), date: dateNow)
        let dayYesterday    = dateFrom(span:TimeInterval(-timeDaySpan), date: dateNow)
        
        for ival in [dayYesterday,dayToday,dayTomorrow] {
            self.netGetAlmanac(date: ival, add: true)
        }
    }
    
    func dateFrom(span:TimeInterval,date:Date) -> String {
        let newDate = date.addingTimeInterval(span)
        let showDate    = timeShow(time: newDate.timeIntervalSince1970, formateStr: .TFy_M_d)
        return showDate
    }
    
    func configureUIItems() {
        self.view.addSubview(self.scrollView)
        
        for index in 0...2 {
            let almanacPlat = FMYWAlmanacPlatView(frame: self.scrollView.bounds)
            almanacPlat.delegate = self
            almanacPlat.left = CGFloat(index) * self.scrollView.width
            self.scrollView.addSubview(almanacPlat)
            self.almanacPlarArr.add(almanacPlat)
        }
        
        self.scrollView.contentSize = CGSize(width: CGFloat(self.almanacPlarArr.count) * self.scrollView.width, height: self.scrollView.height)
    }
    
    
    //AlmanacPlatViewDelegate
    func almanacPlatEvent(almanacModel: FMYWAlmanacModel?) {
        let almanacDigestVC = FMYWAlmanacPartTimeTableViewController()
        almanacDigestVC.almanacModel =  almanacModel
        self.navigationController?.pushViewController(almanacDigestVC, animated: true)
    }
    
    func loadAlmanacPlatFromData(almanacModel:FMYWAlmanacModel?, add:Bool) -> Void {
        if almanacModel == nil {
            return
        }
        if add {
            self.almanacModelArr.add(almanacModel!)
            self.showDayLocation = self.almanacModelArr.count >= 3 ? self.almanacModelArr.count - 3 : 0
        }else {
            self.almanacModelArr.insert(almanacModel!, at: 0)
            self.showDayLocation = 0
        }
        
        self.reloadScrollItems()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex   = Int(scrollView.contentOffset.x/self.scrollView.width)
        print("currentPageIndex = :",pageIndex)
        
        let currentPlat:FMYWAlmanacPlatView = self.almanacPlarArr[pageIndex] as! FMYWAlmanacPlatView;
        let currentAlmanac:FMYWAlmanacModel = currentPlat.almanacModel!
        let currentShowIndex = self.almanacModelArr.index(of: currentAlmanac)
        print(currentShowIndex, currentAlmanac.baiji ?? "")
        
        let timeInterval = currentAlmanac.timerInterval
        
        let dateNow      = Date(timeIntervalSince1970: timeInterval!)
        let dayToday     = dateFrom(span: 0, date: dateNow);         print(dayToday)
        let dayBefore    = dateFrom(span:TimeInterval(-timeDaySpan), date: dateNow)
        let dayAfter     = dateFrom(span: TimeInterval(timeDaySpan), date: dateNow)

        if pageIndex == 0 {
            //TODO  判断是否有前一个元素
            if currentShowIndex == 0 {
                self.netGetAlmanac(date: dayBefore, add: false)
            }else{
                showDayLocation = currentShowIndex - 1
                self.reloadScrollItems()
            }
        }else if pageIndex == 2 {
            //TODO 判断是否有后一个元素
            if currentShowIndex == (self.almanacModelArr.count - 1) {
                self.netGetAlmanac(date: dayAfter, add: true)
            }else{
                showDayLocation = currentShowIndex - 1
                self.reloadScrollItems()
            }
        }else{

        }
    }
    
    
    func reloadScrollItems() -> Void {
        DispatchQueue.main.async {
            
            let lengthShow = self.almanacModelArr.count >= 3 ? 3 : self.almanacModelArr.count
            
            let almanacArr:NSArray = self.almanacModelArr.subarray(with: NSRange(location:self.showDayLocation, length:lengthShow )) as NSArray;
            
            for index  in 0...(almanacArr.count - 1) {
                let almanacPlat:FMYWAlmanacPlatView = self.almanacPlarArr[index] as! FMYWAlmanacPlatView
                let almanacModelShow = almanacArr[index] as? FMYWAlmanacModel;
                almanacPlat.almanacModel = almanacModelShow
            }
            self.scrollView.contentOffset = CGPoint(x: CGFloat(self.showDayIndex) * self.scrollView.width, y: 0)
        }
    }
    
    
    
    
    
    
    
    
    
    
    func netGetAlmanac(date:String?, add:Bool) {
        let param = ["key":apiKey_almanac, "date":date]
        // TODO： 处理队列访问机制，
        _ = FMYHTTPSessionManager(url: URL(string: url_almanac), configuration: nil).net("GET", parameters: param as NSDictionary?, success: { (dataTask, object) in
            
            do {
                let responseDict =  try JSONSerialization.jsonObject(with: object as! Data, options:.mutableLeaves)
                
                let resultItem:NSDictionary = (responseDict as! NSDictionary).object(forKey: "result") as! NSDictionary
                
                print(resultItem)
                
                let almanac = FMYWAlmanacModel()
                almanac.setValuesForKeys(resultItem as! [String : Any])
                
                if self.almanacModelArr.count >= 3 {
                    self.loadAlmanacPlatFromData(almanacModel: almanac, add: add)
                }else {
                    self.almanacModelArr.add(almanac)
                    if self.almanacModelArr.count == 3 {
                        self.almanacModelArr.sort(comparator: { (one, two) -> ComparisonResult in
                            let oneAlm = one as! FMYWAlmanacModel
                            let twoAlm = two as! FMYWAlmanacModel
                            let result = oneAlm.timerInterval! >= twoAlm.timerInterval!
                            if result == true {
                                return .orderedDescending
                            }else{
                                return .orderedAscending
                            }
                        })
                        self.reloadScrollItems()
                    }
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











