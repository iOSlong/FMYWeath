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
    
    
    var tempIndicator:UIActivityIndicatorView? = nil
    var activityIndicator:UIActivityIndicatorView? {
        get {
            if tempIndicator == nil {
                tempIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
                tempIndicator?.center = CGPoint(x: self.view.width * 0.5, y: self.view.height * 0.5 - myNavBarH)
//                tempIndicator?.backgroundColor = .purple
                tempIndicator?.tintColor = .red
                
            }
            return tempIndicator
        }
    }


    // MARK: 除了public 子类访问可用什么约束关键字 ？
    func startActivityIndicatorAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }
    // MARK: 这个地方不处理到主线程也是可以的，然而却有一个延迟！可以猜测stopAnimation的hidden操作是延迟了
    public func stopActivityIndicatorAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorMainBlack
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.backgroundColor = colorMainBlack
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "tabbar_bg"), for: .defaultPrompt)


        self.hiddenBackItemTitle()
        
        
        self.title = self.rootInfo?.object(forKey: "title") as! String?;
        
        
        let centerBtn:UIButton = UIButton.init(type: .roundedRect)
        centerBtn.frame = CGRect.init(x: 0, y: 0, width: 80, height: 25)
        centerBtn.center = self.view.center
        centerBtn.top  = myNavBarH + myTabBarH
        centerBtn.addTarget(self, action: #selector(centerBtnTest(_:)), for: .touchUpInside)
        centerBtn.layer.borderColor = UIColor.purple.cgColor
        centerBtn.layer.borderWidth = 2
//        self.view.addSubview(centerBtn)


        self.view.addSubview(self.activityIndicator!)
//        self.activityIndicator?.startAnimating()

        
    }
    
    func centerBtnTest(_ : UIButton) -> Void {
        if (self.activityIndicator?.isAnimating)! {
            self.activityIndicator?.stopAnimating()
        }else{
            self.activityIndicator?.startAnimating()
        }
        print("centerBtnClick")
    }


    public func hiddenBackItemTitle() -> Void {
        // 将返回按钮的标题设置为空
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
    }

}
