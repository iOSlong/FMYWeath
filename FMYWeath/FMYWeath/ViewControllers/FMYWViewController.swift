//
//  FMYWViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/19.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWViewController: UIViewController {

    public var rootInfo:NSDictionary? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "tabbar_bg"), for: .defaultPrompt)


        self.hiddenBackItemTitle()
        
        
        self.title = self.rootInfo?.object(forKey: "title") as! String?;

    }


    public func hiddenBackItemTitle() -> Void {
        // 将返回按钮的标题设置为空
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
    }

}
