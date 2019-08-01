//
//  FMYButton.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYButton: UIButton {
    var colorSelected:UIColor?   = nil
    var colorNormal:UIColor?     = nil

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    
    
    fileprivate var _isSelected:Bool? = false
    override var isSelected: Bool {
        get {
            return _isSelected!
        }
        set(newValue) {
            super.isEnabled = newValue
            _isSelected     = newValue
            if _isSelected! {
                self.setTitleColor(colorSelected, for: .selected)
                self.setTitleColor(colorSelected, for: .normal)
            }else{
                self.setTitleColor(colorNormal, for: .selected)
                self.setTitleColor(colorNormal, for: .normal)
            }
        }
    }
    
}

// MARK: 利用拓展， 定制一些方便使用的构造方法， 实现方便调用的控件样式
extension FMYButton {
    
    class func fmyButtonWith(frame:CGRect, imgNormal:String, imgSelected:String, target:AnyObject, action:Selector, circleLayer:Bool) -> FMYButton{
        
        let btn  = FMYButton(type: .custom)
        
        let img     = UIImage(named: imgNormal)
        let imgs    = UIImage(named: imgSelected)
        
        let imgw:CGFloat    = CGFloat((img?.cgImage?.width)!)
        let imgh:CGFloat    = CGFloat((img?.cgImage?.height)!)
        
        let fit_w:CGFloat   = 4.0
        let fit_h = fit_w * (imgh / imgw)
        
        btn.setImage(img, for: .normal)
        btn.setImage(imgs, for: .selected)
        
        btn.frame = frame
        
        btn.contentEdgeInsets = UIEdgeInsets(top: fit_h, left: fit_w, bottom: fit_h, right: fit_w)
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if circleLayer {
            let circleLayer = CALayer()
            circleLayer.frame = CGRect.init(x: 2 * fit_w, y: 2 * fit_h, width: frame.size.width - 4 * fit_w, height: frame.size.height - 4 * fit_h)
            circleLayer.borderColor = colorMainPurple.cgColor
            circleLayer.borderWidth = 1
            circleLayer.cornerRadius = (frame.size.height - 4 * fit_h) * 0.5
            btn.layer.addSublayer(circleLayer)
        }
        
        return btn
    }
    
    
    class func fmyButton(frame:CGRect, imgNormal:String, imgSelected:String, target:AnyObject, action:Selector, mode:UIView.ContentMode, contentEdgeInsets:UIEdgeInsets) -> FMYButton? {
        
        let btn  = FMYButton(type: .custom)
        btn.frame = frame
        btn.contentEdgeInsets = contentEdgeInsets
        btn.imageView?.contentMode = mode

        
        btn.setImage(UIImage(named: imgNormal), for: .normal)
        btn.setImage(UIImage(named: imgSelected), for: .selected)

        btn.addTarget(target, action: action, for: .touchUpInside)
        
        return btn
    }
    
    
    class func fmyButtom(frame:CGRect, txtColor:UIColor, colorSelected:UIColor, target:AnyObject, action:Selector, mode:UIView.ContentMode, contentEdgeInsets:UIEdgeInsets) -> FMYButton? {
        
        let btn  = FMYButton(type: .custom)
        btn.frame = frame
        btn.contentEdgeInsets = contentEdgeInsets
        btn.imageView?.contentMode = mode

        btn.setTitleColor(txtColor, for: .normal)
        btn.setTitleColor(colorSelected, for: .selected)
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        return btn
    }
}
















