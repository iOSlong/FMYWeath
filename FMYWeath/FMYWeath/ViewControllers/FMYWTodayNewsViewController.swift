//
//  FMYWTodayNewsViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/31.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWTodayNewsViewController: FMYWViewController ,FMYWNewsItemViewControllerDelegate{

    var pageVC:FMYWTodayNewsPageViewController? = nil

    private var _segmentView:CNSegmentView? = nil
    var segmentView:CNSegmentView {
        get {
            if _segmentView == nil {
                _segmentView = CNSegmentView(frame:CGRect(x: 0, y: 0, width: myScreenW, height:CNSegmentView.segmentHeight()))

                _segmentView?.cn_segBlock({ (index, segEvent) in
                    if (segEvent == CNSegmentEvent.addClick) {

                        self.gotoNewsItemsVC()

                    }else if (segEvent == CNSegmentEvent.itemClick){
                        print(index)
                        self.pageVC?.setViewControllers([self.arrVCItems[index] as! UIViewController], direction: self.selectedIndex < index ? .forward : .reverse, animated: true, completion: nil)
                        self.selectedIndex = index
                    }
                })
            }
            return _segmentView!
        }
    }


    var selectedIndex = 0
    var arrNewsType:NSMutableArray      = NSMutableArray()
    var arrVCItems:NSMutableArray       = NSMutableArray()
    var currentVC:FMYWTodayNewsListViewController? = nil


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as! FMYWTabBarViewController).setBarHidden(hidden:true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "今日头条"

        self.setSegmentView()


        self.displayPageViewController()
    }

    func setSegmentView() -> Void {
        self.view.addSubview(self.segmentView)
    }


    func displayPageViewController() {
        let pageVC:FMYWTodayNewsPageViewController = FMYWTodayNewsPageViewController()
        pageVC.view.top     = self.segmentView.height
        pageVC.view.height  = self.view.height - self.segmentView.height
        self.pageVC = pageVC
        self.pageVC?.segmentView = self.segmentView
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)

        self.setItemViewControllers()
        
    }

    func setItemViewControllers() -> Void {

        let defualItems = UserDefaults.standard.object(forKey: default_key_newsItems)


        if defualItems == nil {

            self.gotoNewsItemsVC()

            return

        }else{

            let items:NSArray = defualItems as! NSArray

            self.arrNewsType.removeAllObjects()



            for index in 0...items.count - 1 {

                let item:NSDictionary = items[index] as! NSDictionary;

                let checkBool:AnyObject = item.object(forKey: "check") as AnyObject

                if checkBool.boolValue == true
                {
                    let newsType:FMYWNewsType = FMYWNewsType()
                    newsType.setValuesForKeys(item as! [String : Any])
                    self.arrNewsType.add(newsType)
                }
            }
        }


        self.segmentView.arrItem = self.arrNewsType

        self.arrVCItems.removeAllObjects()

        for index in 0...self.arrNewsType.count - 1 {

            let itemVC:FMYWTodayNewsListViewController = FMYWTodayNewsListViewController()
            itemVC.newsType = self.arrNewsType[index] as? FMYWNewsType
            itemVC.view.frame = CGRect(x: 0, y:64.0 + self.segmentView.height + self.segmentView.top + 20, width:self.view.width, height: self.view.height)

            self.arrVCItems.add(itemVC)
        }

        self.pageVC?.arrVCItems = self.arrVCItems;

        self.currentVC = self.arrVCItems.firstObject as! FMYWTodayNewsListViewController?
        
        self.pageVC?.setViewControllers([self.arrVCItems[0] as! UIViewController], direction: .forward, animated: true, completion: {over in
            print("show over is ", over)
        })
    }


    func ifContainSameNewsType(oldNewsTypArr:NSArray, newsTypeN:FMYWNewsType) -> Bool {
        if oldNewsTypArr.count == 0 {
            return false
        }
        for index in 0...oldNewsTypArr.count - 1 {
            let newsTypeO:FMYWNewsType = oldNewsTypArr[index] as! FMYWNewsType
            let nameO:String = newsTypeO.name as! String
            let nameN:String = newsTypeN.name as! String
            if nameO == nameN {
                return true
            }
        }
        return false
    }


    func newsItemViewControllerDelegate() {

        self.setItemViewControllers()

    }

    public func gotoNewsItemsVC() -> Void {
        let itemVC = FMYWNewsItemViewController()
        itemVC.delegate = self
        self.present(itemVC, animated: true, completion: {
            print("int to item editing")
        })
    }

    
    deinit {
        print("release all useless obj!" + self.classForCoder.description())
    }
}
