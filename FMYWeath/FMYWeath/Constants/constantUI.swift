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
let mySpanLeft      = CGFloat(12.5)
let mySpanUp        = mySpanLeft
let mySpanV         = mySpanLeft/2.0
let mySpanH         = mySpanLeft/2.0



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
