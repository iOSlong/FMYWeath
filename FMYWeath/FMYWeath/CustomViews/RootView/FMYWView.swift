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
        fatalError("init(coder:) has not been implemented")
    }
    
}
