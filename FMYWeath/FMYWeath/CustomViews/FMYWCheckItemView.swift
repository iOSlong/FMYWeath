//
//  FMYWCheckItemView.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit


typealias FMYCheckItemHander = (_ selected:Bool) -> Void

class FMYWCheckItemView: UIView {
    
    private var btnCheck:FMYButton? = nil
    
    private var labelItem:FMYLabel? = nil
    
    private var eventHander:FMYCheckItemHander? = nil

    // MARK: 内部代码繁琐一点，是为了实现外部调用时候简单方便
//    private var tempSelected:Bool? = false
    var isSelected:Bool? {
        didSet{
            self.refreshBtnCheckState() //更新UI
        }
//        set{
//            self.tempSelected = newValue
//            self.refreshBtnCheckState() //更新UI
//        }
//        get {
//            return self.tempSelected!
//        }
    }
//    private var tempItemTitle:String? = nil
    var itemTitle:String? {
        didSet{
            self.refreshItemTitle() //更新UI
        }
//        set{
//            if (newValue != nil) {
//                tempItemTitle = newValue
//                self.refreshItemTitle() //更新UI
//            }
//        }
//        get {
//            return self.tempItemTitle
//        }
    }
    

    //MARK: 界面布局刷新处理
    private func refreshBtnCheckState() {
        self.btnCheck?.isSelected = self.isSelected!
    }
    
    private func refreshItemTitle()  {
        if (self.itemTitle != nil) && ((self.itemTitle?.lengthOfBytes(using: .utf8)) != nil) {
            self.labelItem?.width = myScreenW
            self.labelItem?.text = self.itemTitle
            self.labelItem?.sizeToFit()
            if ((self.labelItem?.width)! < CGFloat(30.0)) {
                self.labelItem?.width = 30
            }
        }else {
            self.labelItem?.size = CGSize(width: 30, height: 20)
        }
        
        self.refreshDisplay()
    }
    
    private func refreshDisplay() {
        self.labelItem?.left = (self.btnCheck?.right)! + mySpanH
        self.labelItem?.centerY = (self.btnCheck?.centerY)!
        self.width = (self.labelItem?.width)! + (self.btnCheck?.width)! + 3 * mySpanH
    }
    
    

    override init(frame: CGRect) {
        var newFrame = frame
        if frame == CGRect.zero {
            newFrame = CGRect.init(x: 0, y: 0, width: 40, height: 30)
        }
        super.init(frame: newFrame)

        self.isSelected = false
        self.layer.borderColor = colorMainBarBack.cgColor
        self.layer.borderWidth = 2
        
        self.displayUIItems()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func displayUIItems() -> Void {
        let checkW = self.height -  mySpanH
        self.btnCheck = FMYButton.fmyButtonWith(
            frame: CGRect(x: 0, y: 0, width:checkW, height:checkW),
            imgNormal: "market_unselected_button",
            imgSelected: "market_selected_button",
            target: self,
            action: #selector(fmybuttonClick(btn :)),
            circleLayer: false)
        
        
        let itemW = self.width - mySpanH - (self.btnCheck?.width)!
        self.labelItem = FMYLabel.fmylabel(
            frame: CGRect(x: 0, y: 0, width: itemW, height: self.height),
            font: UIFont.systemFont(ofSize: myFont.font_min02.rawValue),
            textColor: colorMainWhite,
            numberOfLines: 2,
            textAlignment: .left)
        self.labelItem?.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(checkItemTap(tapG:))))
     
        
        self.btnCheck?.left = 0
        self.btnCheck?.centerY = self.height * 0.5
        
        
        self.labelItem?.left = (self.btnCheck?.right)! + mySpanH
        self.labelItem?.centerY = (self.btnCheck?.centerY)!
        
        self.addSubview(self.btnCheck!)
        self.addSubview(self.labelItem!)

    }
    
    @objc private func checkItemTap(tapG : UITapGestureRecognizer) -> Void {
        self.isSelected = !self.isSelected!
        if (self.eventHander != nil) {
            self.eventHander!(self.isSelected!)
        }
        print("checkItemTap")
    }
    
    
    @objc private func fmybuttonClick(btn : UIButton) {
        btn.isSelected = !btn.isSelected
        self.isSelected = btn.isSelected
        if (self.eventHander != nil) {
            self.eventHander!(self.isSelected!)
        }
        print("fmybuttonClick")
    }

    // MARK: 外部回调闭包  通过这个函数来关联
    func fmycheckItem(checkHander:@escaping FMYCheckItemHander) -> Void {
        self.eventHander = checkHander
    }
}
