//
//  FMYWJokeTableCell.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/25.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWJokeTableCell: UITableViewCell {

    var labelContent:UILabel?   = nil
    var imgvJoke:UIImageView?   = nil
    var jokeModel:FMYWJokeModel? = nil

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.configureUIItems()
    }

    func configureUIItems() {
        self.labelContent = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.labelContent?.left = mySpanLeft
//        self.labelContent?.backgroundColor = UIColor.red
        self.labelContent?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.labelContent?.top  = mySpanUp
        self.labelContent?.textAlignment    = .left
        self.labelContent?.numberOfLines    = 3
        self.contentView.addSubview(self.labelContent!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setJokeModel(jokeModel:FMYWJokeModel) {
        self.jokeModel  = jokeModel

        let content = jokeModel.content as! String
        self.labelContent?.width    = myScreenW - 6.0 * mySpanLeft
        self.labelContent?.text     = content
        self.labelContent?.sizeToFit()

    }
}
