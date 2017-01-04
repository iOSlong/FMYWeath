//
//  FMYWTabBarViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/19.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWTabBarViewController: UITabBarController {
    var imgvBar:UIImageView? = nil
    var tabItems:NSMutableArray? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureImgvBar()

        self.tabBar.isHidden = true
    }

    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: true)

        self.configureTabItems()
    }

    func configureImgvBar() {
        self.imgvBar = UIImageView(frame:self.tabBar.bounds)
        self.imgvBar?.backgroundColor = UIColor.yellow
        self.imgvBar?.isUserInteractionEnabled = true
        self.imgvBar?.bottom    = self.view.height
        self.imgvBar?.image     = UIImage(named: "tabbar_bg")
        self.view.addSubview(self.imgvBar!)
    }

    func configureTabItems() {
        let spanH   = mySpanH
        let tabW    = (self.view.width - CGFloat(((viewControllers?.count)! + 1))*spanH)/CGFloat((viewControllers?.count)!)
        let tabH    = self.tabBar.height

        var lastX:CGFloat   = 0.0

        for index in 0...(viewControllers?.count)!-1 {
            let barItem:UITabBarItem =  self.tabBar.items![index]

            lastX = CGFloat(CGFloat(index) * (tabW + spanH) + spanH)
            let btnTab = FMYWBtnTab(frame:CGRect.init(x: lastX, y: 0, width: tabW, height: tabH))
            btnTab.addTarget(self, action: #selector(tabItemClick(_:)), for: .touchUpInside)
            btnTab.labelTitle?.text = barItem.title
            self.tabItems?.add(btnTab)
            self.imgvBar?.addSubview(btnTab)
        }
        (self.tabItems?.object(at:0) as! FMYWBtnTab).isSelected = true
    }


    func tabItemClick(_ tabItem:FMYWBtnTab) {
        let index = self.tabItems?.index(of: tabItem)
        if index == self.selectedIndex {
            print("do nothing!")
        }else {
            (self.tabItems?.object(at: self.selectedIndex) as! FMYWBtnTab).isSelected = false
            self.selectedIndex = index!
            (self.tabItems?.object(at: index!) as! FMYWBtnTab).isSelected = true
        }
    }

    public func setBarHidden(hidden:Bool) -> Void {
        //self.tabBarController?.tabBar.isHidden = hidden
        if hidden {
            UIView.animate(withDuration: 0.25, animations: { 
                self.imgvBar?.top    = self.view.height
            });
        }else{
            UIView.animate(withDuration: 0.25, animations: {
                self.imgvBar?.bottom    = self.view.height
            });
        }
    }
}
