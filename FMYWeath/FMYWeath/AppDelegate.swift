//
//  AppDelegate.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/19.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager:CLLocationManager?
    var locality:String?
    var country:String?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let todayHomeVC     = FMYWTodayHomeTableViewController(style: UITableView.Style.grouped)
        let jokeVC          = FMYWJokeViewController()
        let todayHistoryVC  = FMYWTodayHistoryViewController()
        let favorVC         = FMYWFavorViewController()
        let cityListVC      = FMYWeatherViewController()

        let navTodayHome    = FMYWNavigationController(rootViewController:todayHomeVC)
        let navJokes        = FMYWNavigationController(rootViewController:jokeVC)
        let navtodayHistory = FMYWNavigationController(rootViewController:todayHistoryVC)
        let navFavor        = FMYWNavigationController(rootViewController:favorVC)
        let navCityList     = FMYWNavigationController(rootViewController:cityListVC)

        todayHomeVC.title       = "关注今日"  //   = "黄道在今"
        jokeVC.title            = "哈哈知乐"
        todayHistoryVC.title    = "历史今日"
        favorVC.title           = "收藏管理"
        cityListVC.title        = "袖里乾坤"

        navTodayHome.title      = "关注今日"
        navJokes.title          = "哈哈知乐"
        navtodayHistory.title   = "历史今日"
        navFavor.title          = "收藏管理"
        navCityList.title       = "袖里乾坤"

        let tabBar  =   FMYWTabBarViewController()
        tabBar.setViewControllers([navTodayHome,navJokes,navFavor,navCityList], animated: true)

        self.window?.rootViewController = tabBar

        _ = fileGetNewsItems()

        _ = self.colorHexFunc()

        self.locationLoad()
//        UserDefaults.standard
        return true
    }

    func colorHexFunc() -> Bool {
        let scannner = Scanner.init(string: "#112233")
        let hexNum:UnsafeMutablePointer<UInt32>? = UnsafeMutablePointer.init(bitPattern: 0)
        let boolV = scannner.scanHexInt32(hexNum)
        print(boolV,hexNum ?? "")
        return boolV
    }


    func locationLoad() {
        self.locationManager = CLLocationManager.init()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.requestWhenInUseAuthorization()
            self.locationManager?.delegate = self
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.distanceFilter = kCLLocationAccuracyHundredMeters
            self.locationManager?.startUpdatingLocation()
        }else{
            print("定位服务当前可能尚未打开，请设置打开！")
            return
        }
    }

    //MARK - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //取得locations数组的最后一个：因定位一直在移动，所以取数组最后一个准确经纬度
        let location: CLLocation = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            let lat = Float(location.coordinate.latitude)
            let lon = Float(location.coordinate.longitude)

            print("[OTTLocationManager locationManager:didUpdateLocations] lat = \(lat),  lon = \(lon)")
            let oldLs =  UserDefaults.standard.object(forKey: "AppleLanguages")
            UserDefaults.standard.set(["zh-hans"], forKey: "AppleLanguages")
            //反地理编码：将经纬度转换成城市，地区，街道
            CLGeocoder().reverseGeocodeLocation(location) { (placemakes, error) in
                guard let placemark = placemakes?.first else {
                    return
                }
                //国家 + 城市 +  地区"
                self.country    = placemark.country
                self.locality   = placemark.locality
                let subLocality = placemark.subLocality
                print("[OTTLocationManager locationManager:didUpdateLocations] locality = \(String(describing: self.locality)), sublocality = \(String(describing: subLocality)), subthoroughfare = \(String(describing: placemark.subThoroughfare))")  //详细街道
                // 还原Device 的语言
                UserDefaults.standard.set(oldLs, forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
            }
        }
        // 停止定位服务
        self.locationManager?.stopUpdatingLocation()
    }
    //检测是否获取到定位
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //如果未开启定位服务或者获取不到定位，会走此代理方法
        self.locationManager?.stopUpdatingLocation()
        print("[OTTLocationManager locationManager:didFailWithError] 无法获取到定位")
    }

    //MARK:定位错误信息
    private func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print("[OTTLocationManager locationManager:didFinishDeferredUpdatesWithError] \(String(describing: error))\(String(describing: error?.description))")
    }


    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

