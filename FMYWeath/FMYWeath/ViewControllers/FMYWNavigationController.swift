//
//  FMYWNavigationController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/19.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWNavigationController: UINavigationController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.navigationBar.backgroundColor = colorMainBlack

    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.backgroundColor = colorMainBlack
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorMainBlack
    

        /// 1. 设置背景颜色  Item图标颜色
        self.navigationBar.barTintColor = colorMainBarBack
        self.navigationBar.tintColor = .white
        

        /// 2. 设置导航条上的字体颜色
        let attributes = NSDictionary.init(objects: [UIColor.white, UIFont.italicSystemFont(ofSize: 23)], forKeys: [NSAttributedString.Key.foregroundColor as NSCopying,NSAttributedString.Key.font as NSCopying])
        self.navigationBar.titleTextAttributes = attributes as? [NSAttributedString.Key : Any]
        
        
        self.navigationBar.isTranslucent = true
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: UIStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
