//
//  constantUI.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/20.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import Foundation

// MARK: CONSTANT VALUE

let myStatusBarH    = UIApplication.shared.statusBarFrame.size.height
let myTabBarH       = CGFloat(49.0)
let myNavBarH       = myStatusBarH + 44.0
let myScreenH       = UIScreen.main.bounds.height
let myScreenW       = UIScreen.main.bounds.width
let mySpanLeft      = CGFloat(myScreenW * (20.0/621.10))
let mySpanUp        = mySpanLeft
let mySpanV         = mySpanLeft/2.0
let mySpanH         = mySpanLeft/2.0


public enum myFont:CGFloat {
    case font_min01     = 11
    case font_min02     = 14
    case font_normal    = 17
    case font_big01     = 20
    case font_big02     = 25
    case font_big03     = 30
    case font_bigest    = 40
}

// MARK: CONSTANT FUNCTION(PARAM)
/*
 因为Swift共用一个命名空间,只要不是private，其他地方就可以直接调起
 1. 带参数的使用func 实现
 2. 不带参数的使用let 变量
 */

func RGBCOLOR (_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->(UIColor) {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RGBACOLOR(_ r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

// MARK: DEVICE MODE
let screenModeSize:CGSize? = UIScreen.main.currentMode?.size

func iPhone4s() ->Bool {
    if  (screenModeSize != nil){
        return  __CGSizeEqualToSize(screenModeSize!, CGSize.init(width: 640, height: 960))
    }
    return false
}
func iPhone5s() ->Bool {
    if  (screenModeSize != nil){
        return  __CGSizeEqualToSize(screenModeSize!, CGSize.init(width: 640, height: 1136))
    }
    return false
}
func iPhone6() ->Bool {
    if  (screenModeSize != nil){
        return  __CGSizeEqualToSize(screenModeSize!, CGSize.init(width: 750, height: 1334))
    }
    return false
}
func iPhone6Plus() ->Bool {
    if  (screenModeSize != nil){
        return  __CGSizeEqualToSize(screenModeSize!, CGSize.init(width: 1242, height: 2208))
    }
    return false
}








