//
//  FMYWDrivingLicenseViewController.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYWDrivingLicenseViewController: FMYWViewController {

    var subjectOne:FMYWCheckItemView? = nil
    var subjectFour:FMYWCheckItemView? = nil
    
    var tempModeCheck:FMYWCheckItemView? = nil
    var arrModeChek:NSMutableArray = NSMutableArray()
    
    var submitBtn:FMYButton? = nil
    var subject:String? = ""   //科目
    var subMode:String? = ""   //驾照类型
    
    var testType:String? = "rand"
    var testTypeRand:FMYWCheckItemView? = nil   //rand:随机测试（随机100个题目），
    var testTypeOrder:FMYWCheckItemView? = nil  //order：顺序测试（所选科目全部题目）

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as! FMYWTabBarViewController).setBarHidden(hidden:true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        self.displayRequiredItems()


    }

    func displayAccessItems() -> Void {
        self.submitBtn = FMYButton(type: .roundedRect)
        self.submitBtn?.frame = CGRect.init(x: myScreenW * 0.5 - 50, y: 380, width: 100, height: 36)
        self.submitBtn?.addTarget(self, action: #selector(submitBtnClick(_:)), for: .touchUpInside)
        self.submitBtn?.setTitle("开题 ~ GO", for: .normal)
        self.submitBtn?.setTitleColor(colorMainWhite, for: .normal)
        self.submitBtn?.layer.borderColor = colorMainBarBack.cgColor
        self.submitBtn?.layer.borderWidth = 2
        self.submitBtn?.layer.cornerRadius = (self.submitBtn?.height)! * 0.38
        self.view.addSubview(self.submitBtn!)
        self.enableSubmitBtn(inActivity: false)

        self.testTypeRand     = FMYWCheckItemView(frame: CGRect(x: 0, y: 0, width: 100, height: 28))
        self.testTypeOrder    = FMYWCheckItemView(frame: CGRect(x: 0, y: 0, width: 100, height: 28))
        self.testTypeRand?.itemTitle  = "随机题 100个"
        self.testTypeOrder?.itemTitle = "所选科目全部题目"

        self.testTypeRand?.bottom  = (self.submitBtn?.top)! - 30
        self.testTypeOrder?.bottom = (self.submitBtn?.top)! - 30
        self.testTypeRand?.left =  (self.subjectOne?.left)!
        self.testTypeOrder?.centerX = myScreenW * 0.75
        self.view.addSubview(self.testTypeRand!)
        self.view.addSubview(self.testTypeOrder!)
        self.testTypeRand?.isSelected = true

        self.testTypeRand?.fmycheckItem(checkHander: { [unowned self] (isSelected) in
            self.testTypeOrder?.isSelected = !isSelected
        })
        self.testTypeOrder?.fmycheckItem(checkHander: {[unowned self]  (isSelected) in
            self.testTypeRand?.isSelected = !isSelected
        })

        
    }

    @objc func submitBtnClick(_ :FMYButton) -> Void {
        let examSVC:FMYWDrivingExamSystemViewController = FMYWDrivingExamSystemViewController()
        if (self.testTypeRand?.isSelected)! == true {
            self.testType = "rand"
        }else{
            self.testType = "order"
        }

        examSVC.rootInfo =
            ["title" : self.subject! + "  " + self.subMode!,
             "subject" : self.subject!,
             "testType" : self.testType ?? "",
             "model" : self.subMode ?? ""]
        self.navigationController?.pushViewController(examSVC, animated: true)
    }
    

    
    func displayRequiredItems() {
        let itemTitle = FMYLabel.fmylabel(frame: CGRect.zero,
                                          font: UIFont.systemFont(ofSize: myFont.font_big01.rawValue),
                                          textColor: colorMainWhite,
                                          numberOfLines: 1, textAlignment: .center)
        
        itemTitle?.text     = "选择考试科目类型";
        itemTitle?.sizeToFit()
        itemTitle?.center   = CGPoint(x:myScreenW * 0.5, y: myTabBarH)
        self.view.addSubview(itemTitle!)
        
        
        self.subjectOne     = FMYWCheckItemView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        self.subjectFour    = FMYWCheckItemView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        self.subjectFour?.centerY   = (itemTitle?.bottom)! + myTabBarH
        self.subjectOne?.centerY    = (self.subjectFour?.centerY)!
        
        self.subjectOne?.centerX    = myScreenW * 0.25
        self.subjectFour?.centerX   = myScreenW * 0.75
        
        self.subjectOne?.itemTitle = "科目 1"
        self.subjectFour?.itemTitle = "科目 4"
        
        
        self.view.addSubview(self.subjectOne!)
        self.view.addSubview(self.subjectFour!)
        
        
        self.subjectOne?.fmycheckItem(checkHander: { [unowned self] (isSelected) in
            if isSelected == true {
                self.subjectFour?.isSelected = false
                self.enableSubObject(inActivity: true)
            }else{
                self.enableSubObject(inActivity: false)
            }
            self.judgeSubmitBtnState()
        })
        self.subjectFour?.fmycheckItem(checkHander: {[unowned self]  (isSelected) in
            if isSelected == true {
                self.subjectOne?.isSelected = false
                self.enableSubObject(inActivity: false)
            }
            self.judgeSubmitBtnState()
        })
        
        
        
        let subTitle = FMYLabel.fmylabel(frame: CGRect.zero,
                                          font: UIFont.systemFont(ofSize: myFont.font_min02.rawValue),
                                          textColor: colorMainWhite,
                                          numberOfLines: 1, textAlignment: .center)
        
        subTitle?.text     = "驾照类型(科 1)";
        subTitle?.sizeToFit()
        
        let subPointTop  = CGPoint(x:(self.subjectOne?.centerX)!, y:(self.subjectOne?.bottom)! + 30)
        self.view.addSubview(subTitle!)
        subTitle?.center   = subPointTop
        
        
        let modelArr = ["c1","c2","a1","a2","b1","b2"]
        for model in modelArr {
            let checkItem = FMYWCheckItemView(frame: CGRect(x: 0, y: 0, width: 70, height: 32))
            checkItem.itemTitle = model
            checkItem.fmycheckItem(checkHander: {[unowned self]  (isSelected) in
                self.tempModeCheck = checkItem
                self.judgeRefreshConfigure(tempCheck: checkItem)
            })
            self.arrModeChek.add(checkItem)
        }
        
        for index in 0...modelArr.count-1 {
            
            let item:FMYWCheckItemView = self.arrModeChek[index] as! FMYWCheckItemView
            item.top    =  CGFloat(index/2) * 1.5 * item.height + subPointTop.y + 20
            item.left   = (self.subjectOne?.left)!  + CGFloat(index%2 * 85)
            self.view.addSubview(item)
        }
        
        
        
        self.enableSubObject(inActivity: false)
        
        self.displayAccessItems()

    }
    
    
    func enableSubObject(inActivity:Bool) -> Void {
        if inActivity {
            for item in self.arrModeChek {
                (item as! FMYWCheckItemView).alpha = 1;
                (item as! FMYWCheckItemView).isUserInteractionEnabled = true
            }
        }else{
            for item in self.arrModeChek {
                (item as! FMYWCheckItemView).isSelected = false
                (item as! FMYWCheckItemView).alpha = 0.5;
                (item as! FMYWCheckItemView).isUserInteractionEnabled = false
            }
        }
    }
    func enableSubmitBtn(inActivity:Bool) -> Void {
        if inActivity {
            self.submitBtn?.isUserInteractionEnabled = true
            self.submitBtn?.alpha = 1
        }else{
            self.submitBtn?.isUserInteractionEnabled = false
            self.submitBtn?.alpha = 0.5
        }
    }
    
    func judgeSubmitBtnState() -> Void {
        if self.subjectOne?.isSelected == true {
            self.subject = "1"
            for item in self.arrModeChek {
                if ((item as! FMYWCheckItemView).isSelected == true)
                {
        
                    self.subMode = (item as! FMYWCheckItemView).itemTitle
                   
                    self.enableSubmitBtn(inActivity: true)
                    return
                }
            }
        }
        else if self.subjectFour?.isSelected == true {
            self.subject = "4"
            self.subMode = ""
            
            self.enableSubmitBtn(inActivity: true)
            return
        }
        self.enableSubmitBtn(inActivity: false)
    }
    
    
    func judgeRefreshConfigure(tempCheck:FMYWCheckItemView?) {
        for item in self.arrModeChek {
            (item as! FMYWCheckItemView).isSelected = false
        }
        self.tempModeCheck?.isSelected = true
        self.enableSubmitBtn(inActivity: true)
        
        self.subject = "1"
        self.subMode = tempCheck?.itemTitle
    }
    
    override func centerBtnTest(_: UIButton) {
        let desVC = FMYWDrivingExamSystemViewController()
        self.navigationController?.pushViewController(desVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        print("release all useless obj!" + self.classForCoder.description())
    }
}
