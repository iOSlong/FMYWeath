//
//  FMYWView.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/3.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit
import SnapKit

class FMYWView: UIView {
    let backGroundImageView:UIImageView = {
        let imgv = UIImageView(frame: .zero)
        return imgv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backGroundImageView)
        backGroundImageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

@IBDesignable class FMYXibView: UIView {
    /*** 下面的几个方法都是为了让这个自定义类能将xib里的view加载进来。这个是通用的，我们不需修改。 ****/
    var contentView:UIView!

    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView = loadViewFromNib()
//        addSubview(contentView)
//        addConstraints()
    }

    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
    }
    //加载xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    //设置好xib视图约束
    func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView!, attribute: .leading,
                                            relatedBy: .equal, toItem: self, attribute: .leading,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView!, attribute: .trailing,
                                        relatedBy: .equal, toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView!, attribute: .top, relatedBy: .equal,
                                        toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView!, attribute: .bottom,
                                        relatedBy: .equal, toItem: self, attribute: .bottom,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }

}
