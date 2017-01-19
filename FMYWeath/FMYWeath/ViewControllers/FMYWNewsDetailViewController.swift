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
                myWebView?.backgroundColor = .clear
                myWebView?.isOpaque = false
            }
            return myWebView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        self.view.addSubview(self.mkwebView!)

        var urlStr = "http://images.juheapi.com/jztk/subject4/524.swf"
        urlStr = self.newsItem?.url as! String
        let request = URLRequest(url: URL(string: urlStr)!)
        _ = self.mkwebView?.load(request)
        self.mkwebView?.navigationDelegate = self
    }

    
    func tryToChangeWebBackGroundColor() -> Void {
        //修改背景颜色
        let jsbackColor = "document.getElementsByTagName('body')[0].style.background='#222E3E'"
        self.mkwebView?.evaluateJavaScript(jsbackColor, completionHandler: { (anyResponse, error) in
            print(anyResponse ?? error ?? "")
        })
        
        //字体颜色
        let jsfontColor = "document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'"
        self.mkwebView?.evaluateJavaScript(jsfontColor, completionHandler: { (anyResponse, error) in
            print(anyResponse ?? error ?? "")
        })
    }
    
    
    //MARK: WKNavigationDelegate & WKUIDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.startActivityIndicatorAnimation()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.stopActivityIndicatorAnimation()
        
        self.tryToChangeWebBackGroundColor()
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.stopActivityIndicatorAnimation()
    }
    
    
    
}
