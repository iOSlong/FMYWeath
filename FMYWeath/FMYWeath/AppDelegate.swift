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
        let homeVC      = FMYWHomeViewController()
        let exponentVC  = FMYWExponentViewController()
        let cityIntroVC = FMYWCityInfoViewController()
        let favorVC     = FMYWFavorViewController()
        let cityListVC  = FMYWCityListViewController()

        let navHome         = FMYWNavigationController(rootViewController:homeVC)
        let navExponent     = FMYWNavigationController(rootViewController:exponentVC)
        let navCityIntro    = FMYWNavigationController(rootViewController:cityIntroVC)
        let navFavor        = FMYWNavigationController(rootViewController:favorVC)
        let navCityList     = FMYWNavigationController(rootViewController:cityListVC)

        homeVC.title       = "城市天气"
        exponentVC.title   = "指数详情"
        cityIntroVC.title  = "城市介绍"
        favorVC.title      = "收藏管理"
        cityListVC.title   = "更多城市"

        navHome.title       = "城市天气"
        navExponent.title   = "指数详情"
        navCityIntro.title  = "城市介绍"
        navFavor.title      = "收藏管理"
        navCityList.title   = "更多城市"

        let tabBar  =   FMYWTabBarViewController()
        tabBar.setViewControllers([navHome,navExponent,navCityIntro,navFavor,navCityList], animated: true)

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

