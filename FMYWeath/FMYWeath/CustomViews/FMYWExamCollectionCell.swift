//
//  FMYWExamCollectionCell.swift
//  FMYWeath
//
//  Created by xw.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit

class FMYWExamModel: NSObject {
    var id     :String? = nil
    var question    :String? = nil
    var answer      :String? = nil
    var item1       :String? = nil
    var item2       :String? = nil
    var item3       :String? = nil
    var item4       :String? = nil
    var explains    :String? = nil
    var url         :String? = nil

    var valiedUrl:String? {
        let muStr:NSMutableString? = NSMutableString(string: url!)
        if ((muStr != nil) && muStr!.length>0) {
            muStr?.replacingOccurrences(of: "\\", with: "")
        }
        return muStr as String?
    }
}



class FMYWExamCollectionCell: FMYCollectionViewCell {

    let examTitle:FMYLabel = FMYLabel.fmylabel(frame: .zero, font: UIFont.systemFont(ofSize: myFont.font_min02.rawValue), textColor: colorMainWhite, numberOfLines: 0, textAlignment: .left)!

    let imgvShow:UIImageView = UIImageView(frame: CGRect(x: mySpanLeft, y: mySpanUp, width: myScreenW - 2*mySpanLeft, height: myScreenW * 0.38))

    let checkItem1:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem2:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem3:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem4:FMYWCheckItemView = FMYWCheckItemView()

    // 更新数据之后进行刷新
    var examModel:FMYWExamModel?{
        didSet{
            if examModel != nil {
                self.refreshDisplay()
            }
        }
    }


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureDisplayItems()
        self.backgroundColor = .clear

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureDisplayItems() -> Void {
        self.contentView.addSubview(self.examTitle)

        self.contentView.addSubview(self.imgvShow)
        self.imgvShow.contentMode = .scaleAspectFit

        self.contentView.addSubview(self.checkItem1)
        self.contentView.addSubview(self.checkItem2)
        self.contentView.addSubview(self.checkItem3)
        self.contentView.addSubview(self.checkItem4)

        self.examTitle.left = mySpanLeft
        self.examTitle.top = self.imgvShow.bottom + mySpanH

        self.checkItem1.left = self.examTitle.left
        self.checkItem2.left = self.examTitle.left
        self.checkItem3.left = self.examTitle.left
        self.checkItem4.left = self.examTitle.left

        self.checkItem2.left = myScreenW * 0.5
        self.checkItem4.left = myScreenW * 0.5

        self.refreshDisplay()
    }

    func refreshDisplay() -> Void {
        if self.examModel != nil {
            self.imgvShow.sd_setImage(with: URL(string: (self.examModel?.url)!))
        }

        self.examTitle.width    = myScreenW
        self.examTitle.text     = self.examModel?.question
        self.examTitle.sizeToFit()

        self.checkItem1.itemTitle = self.examModel?.item1
        self.checkItem2.itemTitle = self.examModel?.item2
        self.checkItem3.itemTitle = self.examModel?.item3
        self.checkItem4.itemTitle = self.examModel?.item4

        self.checkItem1.top = self.examTitle.bottom + mySpanH
        self.checkItem2.top = self.examTitle.bottom + mySpanH


        self.checkItem3.top = self.checkItem1.bottom + mySpanH
        self.checkItem4.top = self.checkItem1.bottom + mySpanH
    }

}
