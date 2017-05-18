//
//  FMYWFavorViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/20.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWFavorViewController: FMYWViewController {

    
    let baseView:UIView = {
        let view    = UIView()
        view.frame  = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        view.backgroundColor = colorMainPurple
        return view
    }()
    
    
    let subView:UIView = {
        let view    = UIView()
        view.frame  = CGRect.init(x: 10, y: 10, width: 20, height: 20)
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.view.addSubview(self.baseView)
        self.baseView.addSubview(self.subView)
        
        
        
        self.baseView.layoutWidth(222)
        self.baseView.layoutHeight(300)
        

        
        
        
//        let con3 = NSLayoutConstraint(item: self.baseView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 100);
//        let con4 = NSLayoutConstraint(item: self.baseView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 100);
//        self.view.addConstraints([con3, con4]);
        
        
        self.baseView.layoutAuthor(CGPoint(x: 100, y: 100))
        
        self.subView.layoutSize(CGSize(width: 50, height: 50))
        self.subView.layoutCenter()
        
        
        
        
        
//        let const1 = NSLayoutConstraint(item: self.subView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.baseView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0);
//        let const2 = NSLayoutConstraint(item: self.subView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.baseView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0);
//        self.baseView.addConstraints([const1,const2])
        
    }

    
}
