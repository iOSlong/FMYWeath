//
//  AppDelegate.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/19.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let almanacVC       = FMYWAlmanacViewController()
        let jokeVC          = FMYWJokeViewController()
        let todayHistoryVC  = FMYWTodayHistoryViewController()
        let favorVC         = FMYWFavorViewController()
        let cityListVC      = FMYWCityListViewController()

        let navAlmanac      = FMYWNavigationController(rootViewController:almanacVC)
        let navJokes        = FMYWNavigationController(rootViewController:jokeVC)
        let navtodayHistory = FMYWNavigationController(rootViewController:todayHistoryVC)
        let navFavor        = FMYWNavigationController(rootViewController:favorVC)
        let navCityList     = FMYWNavigationController(rootViewController:cityListVC)

        almanacVC.title         = "黄道在今"
        jokeVC.title            = "笑话大全"
        todayHistoryVC.title    = "历史今日"
        favorVC.title           = "收藏管理"
        cityListVC.title        = "更多城市"

        navAlmanac.title        = "黄道在今"
        navJokes.title          = "笑话大全"
        navtodayHistory.title   = "历史今日"
        navFavor.title          = "收藏管理"
        navCityList.title       = "更多城市"

        let tabBar  =   FMYWTabBarViewController()
        tabBar.setViewControllers([navAlmanac,navJokes,navtodayHistory,navFavor,navCityList], animated: true)

        self.window?.rootViewController = tabBar





        return true
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

