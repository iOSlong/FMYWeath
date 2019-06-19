//
//  FMYWNewsItemViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/31.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit


@objc protocol FMYWNewsItemViewControllerDelegate {
    @objc
    optional func newsItemViewControllerDelegate() -> Void
}

class FMYWNewsItemViewController: FMYWViewController {

    var btnBack:UIButton?
    var imgvBack:UIImageView = UIImageView(image:UIImage(named: "moonback"))
    var newsItems:NSMutableArray? = []
    var controlBPlat:ControlBezierPlat? = nil
    var delegate:FMYWNewsItemViewControllerDelegate? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureUIItems()


    }

    func configureUIItems() -> Void {
        self.view.addSubview(self.imgvBack)
        self.imgvBack.frame = self.view.bounds

        self.btnBack = UIButton.init(type: .roundedRect)
        self.btnBack?.frame = CGRect.init(x: 0, y:0, width: 100*myScreenW/320, height: 30*myScreenW/320)
        self.btnBack?.center = CGPoint.init(x: self.view.width * 0.5, y: self.view.height * 0.92)
        self.btnBack?.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)
        self.btnBack?.setBackgroundImage(UIImage(named: "btn_check_no"), for: .normal)
        self.view.addSubview(self.btnBack!)

        self.configureControlBezierPlat()
    }


    @objc func btnBackClick(_ :UIButton) -> Void {

        for index in 0...(self.controlBPlat?.arrControl_BP.count)! - 1 {

            let controlBP:Control_BezierPath = self.controlBPlat?.arrControl_BP[index] as! Control_BezierPath

            let checkBool:AnyObject = controlBP.item.object(forKey: "check") as AnyObject

            if checkBool.boolValue == true {

                self.newsItems?.removeAllObjects()

                for index in 0...(self.controlBPlat?.arrControl_BP.count)! - 1 {

                    let cBP:Control_BezierPath = self.controlBPlat?.arrControl_BP[index] as! Control_BezierPath
                    self.newsItems?.add(cBP.item);

                }
                
                UserDefaults.standard.set(self.newsItems, forKey: default_key_newsItems)

                UserDefaults.standard.synchronize()

                self.dismiss(animated: true) {
                    self.delegate?.newsItemViewControllerDelegate!()
                    print("dismiss over!")
                }
                break
            }
        }

        print("you should choose one!")
    }


    func configureControlBezierPlat() {
        
        let defualItems = UserDefaults.standard.object(forKey: default_key_newsItems)

        if defualItems == nil {
            self.newsItems?.addObjects(from:fileGetNewsItems() as! [Any])
        }else{
            self.newsItems?.addObjects(from: defualItems as! [Any] )
        }

        self.controlBPlat   = ControlBezierPlat(frame: CGRect(x: 0, y: 80, width: self.view.width, height: self.view.height * 0.7), withTitles: nil, andYS: nil, andNS: nil)
        controlBPlat?.arrNewsItems = self.newsItems
        let ratio = myScreenW/320.0
        controlBPlat?.cbp_w    = 32.0 * ratio
        controlBPlat?.span     = 10.0 * ratio

        controlBPlat?.cbpBlock = { (index, newsItem) -> Void in

            print(index,newsItem ?? "")

            self.reloadBtnState()
        }

        self.reloadBtnState()

        self.view.addSubview(controlBPlat!)
    }



    func reloadBtnState() -> Void {

        for index in 0...(self.controlBPlat?.arrControl_BP.count)! - 1 {

            let controlBP:Control_BezierPath = self.controlBPlat?.arrControl_BP[index] as! Control_BezierPath

            let checkBool:AnyObject = controlBP.item.object(forKey: "check") as AnyObject
            
            if checkBool.boolValue == true {
                
                self.btnBack?.setBackgroundImage(UIImage(named: "btn_check_yes"), for: .normal)
                
                break
            }
            
            self.btnBack?.setBackgroundImage(UIImage(named: "btn_check_no"), for: .normal)
            
        }
        
    }
    
}
