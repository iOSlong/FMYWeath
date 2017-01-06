//
//  FMYWNewsTableViewCell.swift
//  FMYWeath
//
//  Created by xw.long on 17/1/1.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYWNewsTableViewCell: UITableViewCell {


    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubInfo: UILabel!



    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.numberOfLines = 2
        self.textLabel?.font = UIFont.systemFont(ofSize: myFont.font_min02.rawValue)
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: myFont.font_min01.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var _tempItem:FMYWNewsItemModel?
    var newsItem:FMYWNewsItemModel?{
        set {
            if (newValue != nil) {
                _tempItem = newValue
                self.refreshUIItems()
            }
        }
        get {
            return _tempItem
        }
    }


    func refreshUIItems()  {
        let title = self.newsItem?.title as? String;
        self.textLabel?.text = title
        self.detailTextLabel?.text = (self.newsItem?.date as! String) + " | " + (self.newsItem?.author_name as! String)
        let imgUrl = self.newsItem?.thumbnail_pic_s as? String
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.sd_setImage(with: URL(string: imgUrl!))
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
