//
//  FMYWNewsDetailViewController.swift
//  FMYWeath
//
//  Created by xw.long on 17/1/1.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit
import WebKit

class FMYWNewsDetailViewController: FMYWViewController,WKNavigationDelegate {

    var newsItem:FMYWNewsItemModel? = nil

    private var myWebView:WKWebView? = nil
    var mkwebView:WKWebView?{
        get {
            if myWebView == nil {
                myWebView = WKWebView.init(frame:self.view.bounds, configuration: WKWebViewConfiguration())
            }
            return myWebView
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.view.addSubview(self.mkwebView!)

        let request = URLRequest(url: URL(string: self.newsItem?.url as! String)!)
        _ = self.mkwebView?.load(request)
        self.mkwebView?.navigationDelegate = self
    }

}
