//
//  FMYWAlmanacPartTimeTableCell.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/30.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class AlmanacPartTimeMode: NSObject {
    var yi          :Any? = nil
    var ji          :Any? = nil
    var des         :Any? = nil
    var hours       :Any? = nil
    var yangli      :Any? = nil
}


let title_w     = 64.0
let detail_w    = myScreenW - 2 * mySpanLeft - CGFloat(title_w) - 2 * mySpanLeft
class FMYWAlmanacPartTimeTableCell: UITableViewCell {
    
    private var tempV:AlmanacPartTimeMode? = nil
    var partMode:AlmanacPartTimeMode? {
        get {
            return tempV
        }
        set {
            tempV = newValue
            self.reloadUIItemsFrom(partTimeMode: tempV)
        }
    }
    
    var labelTime:UILabel = {
        let label:UILabel = UILabel(frame:CGRect(x: 0, y: 0, width: title_w, height: 20))
        label.textAlignment = .right
        return label
    }()
    var labelDes:UILabel = {
        let label:UILabel = UILabel(frame:CGRect(x: 0, y: 0, width: detail_w, height: 20))
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: myFont.font_min02.rawValue)
        return label
    }()
    var labelYi:UILabel = {
        let label:UILabel = UILabel(frame:CGRect(x: 0, y: 0, width: detail_w, height: 20))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: myFont.font_min02.rawValue)
        return label
    }()
    var labelJi:UILabel = {
        let label:UILabel = UILabel(frame:CGRect(x: 0, y: 0, width: detail_w, height: 20))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: myFont.font_min02.rawValue)
        return label
    }()
    var imgvLine:UIImageView = {
        let imgv    = UIImageView()
        imgv.width  = 1.5
        imgv.backgroundColor = .blue
        return imgv
    }()
    var imgvDot:UIImageView = {
        let imgv    = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        imgv.backgroundColor = .blue
        imgv.layer.cornerRadius = imgv.width * 0.5
        imgv.layer.backgroundColor = UIColor.blue.cgColor
        return imgv
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureUIItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUIItems() -> Void {
        self.contentView.addSubview(self.labelTime)
        self.contentView.addSubview(self.labelJi)
        self.contentView.addSubview(self.labelYi)
        self.contentView.addSubview(self.labelDes)
        self.contentView.addSubview(self.imgvLine)
        self.contentView.addSubview(self.imgvDot)
        self.labelTime.left     = mySpanLeft
        self.imgvLine.left      = self.labelTime.right + mySpanLeft
        self.imgvDot.centerX    = self.imgvLine.centerX
    }
    
    
    func reloadUIItemsFrom(partTimeMode:AlmanacPartTimeMode?) -> Void {
        self.labelTime.text = partTimeMode?.hours as? String
        self.labelDes.width = detail_w
        self.labelYi.width = detail_w
        self.labelJi.width = detail_w
        self.labelDes.text = partTimeMode?.des as? String
        self.labelYi.text = "宜 ：" + (partTimeMode?.yi as? String)!
        self.labelJi.text = "忌 ：" + (partTimeMode?.ji as? String)!
        self.labelDes.sizeToFit()
        self.labelYi.sizeToFit()
        self.labelJi.sizeToFit()
        
//        var tempH = 0.0
        self.labelDes.left  = self.imgvLine.right + mySpanLeft
        self.labelDes.top   = mySpanUp
        self.labelYi.left   = self.labelDes.left
        self.labelYi.top    = self.labelDes.bottom + mySpanUp
        self.labelJi.left   = self.labelDes.left
        self.labelJi.top    = self.labelYi.bottom + mySpanUp
        self.imgvDot.top    = self.labelTime.centerY
        self.imgvLine.height = 125
    }
}





