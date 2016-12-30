//
//  FMYWAlmanacModel.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/28.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWAlmanacModel: NSObject {
    var yangli      :Any? = nil
    var wuxing      :Any? = nil
    var jishen      :Any? = nil
    var id          :Any? = nil
    var ji          :Any? = nil
    var yinli       :Any? = nil
    var baiji       :Any? = nil
    var chongsha    :Any? = nil
    var yi          :Any? = nil
    var xiongshen   :Any? = nil
    
    // 设置只读属性
    private var _yiItems:NSArray?
    var yiItems:NSArray? {
        get {
            let yiStr = self.yi as! NSString
            _yiItems =  yiStr.components(separatedBy: CharacterSet(charactersIn: " ,;")) as NSArray
            return _yiItems
        }
    }
    
    var jiItems:NSArray? {
        get {
            let jiStr = self.ji as! NSString
            return jiStr.components(separatedBy: CharacterSet(charactersIn: " ,;")) as NSArray
        }
    }
    
    var xiongshenItems:NSArray? {
        get {
            let itemStr = self.xiongshen as! NSString
            return itemStr.components(separatedBy: CharacterSet(charactersIn: " ,;")) as NSArray
        }
    }
    
    var jishenItems:NSArray? {
        get {
            let itemStr = self.jishen as! NSString
            return itemStr.components(separatedBy: CharacterSet(charactersIn: " ,;")) as NSArray
        }
    }
    
    var timerInterval:TimeInterval? {
        get {
            let itemStr = self.yangli as! String
            let timerVal = timeInteger(timeStr: itemStr, formateStr: .TFy_M_d)
            return timerVal
        }
    }
    
    var showTime:String?{
        get {
            let retrunStr = timeShow(time: self.timerInterval!, formateStr: .TFy_M_d)
            return retrunStr
        }
    }
    
    override var description: String {
        return self.yinli as! String
    }
}



