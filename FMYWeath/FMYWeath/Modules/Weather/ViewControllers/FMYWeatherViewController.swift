//
//  FMYWeatherViewController.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/6.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit

class FMYWeatherViewController: FMYWViewController {

    var pageVC:FMYWeatherPageViewController? = nil

    var selectedIndex = 0
    var arrRegion:NSMutableArray      = NSMutableArray()
    var arrVC:NSMutableArray          = NSMutableArray()
    var currentVC:FMYWeatherPageItemViewController? = nil

    private var navigationBarView:FMYWeatherNavigationBarView = {
        let navBar = FMYWeatherNavigationBarView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 46))
        navBar.showBorderLine()
        return navBar
    }()


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "袖里乾坤"
        self.view.backgroundColor = .lightGray

        self.configureNavgationBar()

        self.displayPageViewController()
    }

    func configureNavgationBar()  {
        self.view.addSubview(self.navigationBarView)
        self.navigationBarView.snp.makeConstraints { (make) in
            make.top.left.width.equalTo(self.view)
            if UIDevice.isIPhoneX() {
                make.height.equalTo(88)
            } else {
                make.height.equalTo(64)
            }
        }
        self.navigationBarView.navigationHandle = {eventType in
            switch eventType {
            case .eventMoreLocation:
                self.showRegionListViewController()
            }
        }
    }

    func displayPageViewController() {
        let pageVC:FMYWeatherPageViewController = FMYWeatherPageViewController()
        self.pageVC = pageVC
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(self.navigationBarView.snp.bottom)
        }
        pageVC.weatherPageHandle = { currentIndex in
            self.navigationBarView.pageController.currentPage = currentIndex
            let region = self.arrRegion[currentIndex]
            self.navigationBarView.region = (region as! FMYRegion)
        }

        self.setItemViewControllers()

    }

    public func showRegionListViewController() -> Void {
        let regionsVC = FMYWRegionsViewController()
        self.navigationController?.pushViewController(regionsVC, animated: true)
//        self.present(regionsVC, animated: true, completion: {
//            print("int to item editing")
//        })
    }

    
    func setItemViewControllers()  {
        var defaultItems = UserDefaults.standard.object(forKey: default_key_locations)

        if defaultItems == nil {
            let region0 = ["regionID":"792","regionName":"北京"]
            let region1 = ["regionName":"上海","regionID":"2013"]
            let region2 = ["regionName":"贵阳","regionID":"1747"]
            let region3 = ["regionName":"毕节","regionID":"1679"]

            defaultItems = [region0,region1,region2,region3]
        }

        let items:NSArray = defaultItems as! NSArray

        self.arrRegion.removeAllObjects()

        for index in 0...items.count - 1 {

            let item:NSDictionary = items[index] as! NSDictionary;
            let region:FMYRegion = FMYRegion.regionFrom(dict: item);
            self.arrRegion.add(region)
        }

        self.navigationBarView.pageController.numberOfPages = self.arrRegion.count

        self.arrVC.removeAllObjects()

        for index in 0...self.arrRegion.count - 1 {
            let itemVC:FMYWeatherPageItemViewController = FMYWeatherPageItemViewController()
            itemVC.region = self.arrRegion[index] as? FMYRegion
            self.arrVC.add(itemVC)
        }
        self.pageVC?.arrVCItems = self.arrVC;

        self.currentVC = self.arrVC.firstObject as! FMYWeatherPageItemViewController?

        self.pageVC?.setViewControllers([self.arrVC[0] as! UIViewController], direction: .forward, animated: true, completion: {over in
            print("show over is ", over)
        })
    }

    deinit {
        print("release all useless obj!" + self.classForCoder.description())
    }

}
