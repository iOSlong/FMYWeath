//
//  FMYWBarButtomItem.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/30.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit


public func sizeFrom(btn:UIButton) -> CGSize {
    let sizeBtn     = btn.titleLabel?.sizeThatFits(CGSize(width: 100, height: 40))
    let sizeReal    = CGSize(width: (sizeBtn?.width)! + 10, height: 40)
    let sizeMin     = CGSize(width:40, height:40)
    let sizeLast    = (sizeBtn?.width)! + 10  > 40 ? sizeReal : sizeMin;
    return sizeLast
}


class FMYWBarButtomItem: UIBarButtonItem {

    let eventBlock: ((_ event:String) ->Void)? = nil
    var btnCustomer:UIButton? = nil

    //  类方法的实现，
    class func barButtomItem(title:String,target:Any?,action:Selector,forEvent:UIControlEvents) -> FMYWBarButtomItem {
        let itemBtn = UIButton(frame: .zero)
        itemBtn.setTitle(title, for: .normal)
        itemBtn.setTitleColor(.blue, for: .normal)
        itemBtn.size = sizeFrom(btn: itemBtn)
        itemBtn.addTarget(target, action: action, for:forEvent)
        return FMYWBarButtomItem(customView: itemBtn)
    }
}
