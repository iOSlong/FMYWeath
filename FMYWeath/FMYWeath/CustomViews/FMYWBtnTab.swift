//
//  FMYWBtnTab.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/20.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWBtnTab: UIButton {
    var imgvIcon:UIImageView?   = nil
    var labelTitle:UILabel?     = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named: "moon"), for: .normal)
        self.setImage(UIImage(named: "sun"), for: .selected)
        self.configureaccessorialItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureaccessorialItems() {
        self.imgvIcon           = UIImageView(frame:self.bounds)
        self.imgvIcon?.size     = CGSize(width: self.height, height: self.height)
        self.imgvIcon?.centerX  = self.width * 0.5
        self.imgvIcon?.backgroundColor = UIColor.red


        self.labelTitle         = UILabel(frame: CGRect(x: 0, y:self.height * 0.7, width: self.width, height: self.height * 0.3))
        self.labelTitle?.textColor      = UIColor.gray
        self.labelTitle?.font           = UIFont.systemFont(ofSize: 10)
        self.labelTitle?.textAlignment  = .center

//        self.addSubview(imgvIcon!)
        self.addSubview(labelTitle!)
    }

    // TODO   重写set方法
    private var _isSelected:Bool? = false
    override var isSelected: Bool {
        get {
            return _isSelected!
        }
        set (newValue){
            super.isSelected = newValue
            _isSelected = newValue
            if _isSelected! {
                self.labelTitle?.textColor = UIColor.white
            }else{
                self.labelTitle?.textColor = UIColor.gray
            }
        }
    }
}
