//
//  FMYTableView.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/11.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = .clear
        self.separatorColor = colorMainBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
