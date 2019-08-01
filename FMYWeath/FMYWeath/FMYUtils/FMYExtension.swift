//
//  FMYExtension.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/19.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    private static var onceToken  = [String]()
    public class func once(_ token: String, _ block:@escaping () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        if onceToken.contains(token) {
            return
        }
        onceToken.append(token)
        block()
    }
}



public extension UIView {
    func readyForLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: 同时使用layoutWidth layoutHeight 无效！
    func layoutWidth(_ width:CGFloat) {
        self.readyForLayout()
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width))
    }
    
    func layoutHeight(_ height:CGFloat) {
        self.readyForLayout()
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
    }
    
    func layoutSize(_ size : CGSize) -> Void {
        self.readyForLayout()
        let lcW =  NSLayoutConstraint(item: self, attribute: .width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: size.width)
        let lcH =  NSLayoutConstraint(item: self, attribute: .height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: size.height)
        self.addConstraints([lcW, lcH])
    }
    
    //==================================
    func layoutTop(_ top: CGFloat)  {
        self.readyForLayout()
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: top))
    }
    
    func layoutLeft(_ left:CGFloat) -> Void {
        self.readyForLayout()
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: self.superview, attribute: .left, multiplier: 1, constant: left))
    }
    
    func layoutRight(_ right:CGFloat) -> Void {
        self.readyForLayout()
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: self.superview, attribute: .right, multiplier: 1, constant: -right))
    }
    
    func layoutBottom(_ bottom:CGFloat) -> Void {
        self.readyForLayout()
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1, constant: -bottom))
    }
    
    func layoutCenter() {
        let cX =  NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: .centerX, multiplier: 1, constant: 0)
        let cY =  NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraints([cX, cY])
    }
    
    func layoutAuthor(_ point:CGPoint) -> Void {
        self.layoutLeft(point.x)
        self.layoutTop(point.y)
    }
    
    //////=========Relation
    func layoutRelation(_ relation:NSLayoutConstraint.Relation,
                        _ toView:UIView,
                        _ desAttribute:NSLayoutConstraint.Attribute,
                        _ toAttribute:NSLayoutConstraint.Attribute) {
        
    }
    
}







