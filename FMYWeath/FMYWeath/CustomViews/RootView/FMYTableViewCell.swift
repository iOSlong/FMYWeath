//
//  FMYTableViewCell.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/11.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        
        // MARK: 定制处理cell被选中时候的背景视图
        let backgView = UIImageView(frame: self.bounds)
        backgView.backgroundColor = colorMainBarBack;
        self.selectedBackgroundView = backgView
        
        self.textLabel?.textColor = colorMainWhite
        self.detailTextLabel?.textColor = colorMainWhite
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
