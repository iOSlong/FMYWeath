//
//  FMYLabel.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYLabel: UILabel {
    
}

extension FMYLabel {
    // TODO: 如何实现将函数声明和函数实现部分封开
    class func fmylabel(frame:CGRect, font:UIFont, textColor:UIColor, numberOfLines:Int, textAlignment:NSTextAlignment) -> FMYLabel?{
        let label = FMYLabel(frame: frame)
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines;
        label.textAlignment = textAlignment
        
        return label
    }
}
