//
//  FMYLabel.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYLabel: UILabel {
    
    // MARK: 定义单列实现部分
    static func shareExamTitle() -> FMYLabel {
        struct Singleton {
            
            static var single = FMYLabel.fmylabel(frame: .zero, font: UIFont.systemFont(ofSize: myFont.font_normal.rawValue), textColor: colorMainLightWhite, numberOfLines: 0, textAlignment: .left)!
        }
        
        DispatchQueue.once("shareExamTitle") {
            Singleton.single = shareExamTitle()
        }
        
        return Singleton.single
    }

    override init(frame:CGRect) {
        super.init(frame: frame)
        self.textColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: other needed single parts   ……
    
    
}

//final class shareExamTitleLable:FMYLabel {
//    static func shareExamTitle() -> FMYLabel {
//        
//        struct Singleton {
//            
//            static var single = FMYLabel.fmylabel(frame: .zero, font: UIFont.systemFont(ofSize: myFont.font_normal.rawValue), textColor: colorMainLightWhite, numberOfLines: 0, textAlignment: .left)!
//        }
//        
//        DispatchQueue.once("shareExamTitle") {
//            Singleton.single = shareExamTitle()
//        }
//        
//        return Singleton.single
//    }
//}

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
