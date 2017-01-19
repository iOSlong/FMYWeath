//
//  FMYWExamCollectionCell.swift
//  FMYWeath
//
//  Created by xw.long on 17/1/18.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit
import WebKit


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

    
    
    // MARK: help.self.Property
    
    var valiedUrl:String? {
        let muStr:NSMutableString? = NSMutableString(string: url!)
        if ((muStr != nil) && muStr!.length>0) {
            muStr?.replacingOccurrences(of: "\\", with: "")
        }
        return muStr as String?
    }
    
    
    // MARK:  绑定判断 数据类型  readonly
    var isImgModel:Bool {
        if self.url != nil && ((self.url?.lengthOfBytes(using: .utf8))! > 0){
            return true
        }
        return false
    }
    
    var isVideos:Bool{
        if self.url != nil && ((self.url?.lengthOfBytes(using: .utf8))! > 0){
            if (self.url!.hasSuffix("swf") || self.url!.hasSuffix("gif")) {
                return true
            }
        }
        return false
    }
    
    var isJudgeQ:Bool? {
        if ((self.item3?.lengthOfBytes(using: .utf8))! == 0) && ((self.item4?.lengthOfBytes(using: .utf8))! == 0) {
            return true
        }
        return false
    }
    
    var isOptionQ:Bool? {
        return self.isJudgeQ;
    }
}


let imgShowH = myScreenW * 0.38

class FMYWExamCollectionCell: FMYCollectionViewCell,WKNavigationDelegate {

    let markLabel:FMYLabel = FMYLabel.fmylabel(
        frame: CGRect(x: mySpanLeft, y: mySpanUp, width: 10, height: 10),
        font: UIFont.systemFont(ofSize: myFont.font_min02.rawValue),
        textColor: colorMainWhite,
        numberOfLines: 1,
        textAlignment: .center)!

    
    let imgvShow:UIImageView = UIImageView(frame: CGRect(x: mySpanLeft, y: mySpanUp, width: myScreenW - 2*mySpanLeft, height: imgShowH))
    
    var wkwebView:WKWebView? = nil
    
    
    var tempIndicator:UIActivityIndicatorView? = nil
    var activityIndicator:UIActivityIndicatorView? {
        get {
            if tempIndicator == nil {
                tempIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
                tempIndicator?.center = CGPoint(x: myScreenW * 0.5, y: imgShowH * 0.520)
                tempIndicator?.tintColor = .red
            }
            return tempIndicator
        }
    }
    
    let examTitle:FMYLabel = FMYLabel.fmylabel(frame: .zero, font: UIFont.systemFont(ofSize: myFont.font_normal.rawValue), textColor: colorMainLightWhite, numberOfLines: 0, textAlignment: .left)!

    
    let checkItem1:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem2:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem3:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem4:FMYWCheckItemView = FMYWCheckItemView()
    var arrCheckItem:NSArray? = nil
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
        
        self.arrCheckItem = [self.checkItem1,self.checkItem2,self.checkItem3,self.checkItem4]
        self.configureDisplayItems()
        self.backgroundColor = colorMainBlack

        
        self.wkwebView = WKWebView.init(frame: (self.imgvShow.frame))
        self.wkwebView?.backgroundColor = .clear
        self.wkwebView?.isOpaque = false
        self.wkwebView?.scrollView.bounces = false
        self.wkwebView?.scrollView.backgroundColor = .clear
        self.contentView.addSubview(self.wkwebView!)
        self.wkwebView?.navigationDelegate = self
        self.wkwebView?.isHidden = true

        self.contentView.addSubview(self.activityIndicator!)
        
        self.markLabel.layer.borderWidth = 1
        self.markLabel.layer.borderColor = colorMainLightWhite.cgColor
        
        self.contentView.addSubview(self.markLabel)
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
        

        self.examTitle.left     = mySpanLeft
        self.checkItem1.left    = mySpanLeft

        self.refreshDisplay()
    }

    func refreshDisplay() -> Void {
        
        self.markLabel.width = 100
        self.markLabel.text = self.examModel?.id
        self.markLabel.sizeToFit()
        self.markLabel.width    += 2 * mySpanH
        self.markLabel.height   += mySpanV - 5
        self.markLabel.layer.cornerRadius = self.markLabel.height * 0.5

        
        if self.examModel != nil && self.examModel?.isImgModel == true {
            self.activityIndicator?.startAnimating()
            self.markLabel.top  = mySpanUp
            if self.examModel?.isVideos == true
            {
                let imgUrl = self.examModel?.url
                _ = self.wkwebView?.load(URLRequest.init(url: URL(string: imgUrl!)!));
                self.imgvShow.isHidden = true
                self.wkwebView?.isHidden = false
            }else{
                self.imgvShow.sd_setImage(with: URL(string: (self.examModel?.url)!), completed: { (image, error, cacheType, url) in
                    self.activityIndicator?.stopAnimating()
                })
                self.imgvShow.isHidden = false
                self.wkwebView?.isHidden = true
            }
            self.examTitle.top = mySpanUp + self.imgvShow.bottom
        }else{
            self.markLabel.top   = 0

            self.imgvShow.isHidden = true
            self.examTitle.top = mySpanUp + mySpanH
        }

        self.examTitle.width    = myScreenW - 2 * mySpanLeft
        self.examTitle.text     = self.examModel?.question
        self.examTitle.sizeToFit()

        self.checkItem1.itemTitle = self.examModel?.item1
        self.checkItem2.itemTitle = self.examModel?.item2
        self.checkItem3.itemTitle = self.examModel?.item3
        self.checkItem4.itemTitle = self.examModel?.item4
        
        if self.examModel?.isOptionQ != nil {
            
            self.checkItem3.isHidden = (self.examModel?.isJudgeQ)!
            self.checkItem4.isHidden = (self.examModel?.isJudgeQ)!
            
            
            self.checkItem1.top = self.examTitle.bottom + 2 * mySpanH
            
            if (self.examModel?.isOptionQ)!
            {
                self.checkItem2.left = myScreenW * 0.5
                self.checkItem2.top = self.examTitle.bottom + 2 * mySpanH
            }
            else
            {
                var van_x = mySpanLeft
                var van_y = self.examTitle.bottom + mySpanH
                let content_w = myScreenW - 2 * mySpanLeft
                for index in 0...(self.arrCheckItem?.count)! - 1
                {
                    let item:FMYWCheckItemView = self.arrCheckItem![index] as! FMYWCheckItemView
                    
                    if (item.width + van_x >= content_w) {
                        van_y += mySpanUp + item.height
                        van_x = mySpanLeft
                        item.frame = CGRect(x: van_x, y: van_y, width: item.width, height: item.height)
                        
                        van_x += item.width + 2 * mySpanLeft
                    }
                    else
                    {
                        item.frame = CGRect(x: van_x, y: van_y, width: item.width, height: item.height)
                        van_x += item.width + 2 * mySpanLeft
                    }
                }
                
            }
        }
    }
    
    // MARK:WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator?.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator?.stopAnimating()
    }

    
    
    
    // MARK:利用模型映射计算cell控件的高度。
    class func cellHeightFrom(examModel:FMYWExamModel?) -> CGFloat {
        var cellH:CGFloat = mySpanLeft
        if examModel != nil {
            if examModel?.isImgModel == true {
                cellH += imgShowH
            }else{

            }
            
            let cellHelp = CalculateExcamCellHelp.shareExamCalculate()
            cellHelp.examModel = examModel
            
            cellH += cellHelp.bottom + mySpanLeft
        }
        return cellH + 21
    }
    
    
}


//http://blog.csdn.net/youshaoduo/article/details/53185282  单例 写法  参考
// MARK: 定义一个单列来辅助计算 （节省内存消耗）   final关键字的作用是这个类或方法不希望被继承和重写
final class CalculateExcamCellHelp:NSObject {
    
    let examTitle:FMYLabel = FMYLabel.fmylabel(frame: .zero, font: UIFont.systemFont(ofSize: myFont.font_normal.rawValue), textColor: colorMainLightWhite, numberOfLines: 0, textAlignment: .left)!
    
    
    let checkItem1:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem2:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem3:FMYWCheckItemView = FMYWCheckItemView()
    let checkItem4:FMYWCheckItemView = FMYWCheckItemView()
    var arrCheckItem:NSArray? = nil

    var titleH:CGFloat = 20.0
    var bottom:CGFloat = 44.0
    
    var examModel:FMYWExamModel?{
        didSet{
            if examModel != nil {
                self.refreshCaculateData()
            }
        }
    }
    
    func refreshCaculateData() -> Void {
        self.examTitle.width    = myScreenW - 2 * mySpanLeft
        self.examTitle.text     = self.examModel?.question
        self.examTitle.sizeToFit()
        
        self.titleH = self.examTitle.height
        
        
        self.checkItem1.itemTitle = self.examModel?.item1
        self.checkItem2.itemTitle = self.examModel?.item2
        self.checkItem3.itemTitle = self.examModel?.item3
        self.checkItem4.itemTitle = self.examModel?.item4
        
        
        
        if self.examModel?.isOptionQ != nil {
            
            self.checkItem3.isHidden = (self.examModel?.isJudgeQ)!
            self.checkItem4.isHidden = (self.examModel?.isJudgeQ)!
            
            
            self.checkItem1.top = self.examTitle.bottom + 2 * mySpanH
            
            if (self.examModel?.isOptionQ)!
            {
                self.checkItem2.left = myScreenW * 0.5
                self.checkItem2.top = self.examTitle.bottom + 2 * mySpanH
                
                self.bottom = self.titleH + self.checkItem1.height + 3 * mySpanH
            }
            else
            {
                var van_x = mySpanLeft
                var van_y = mySpanH
                let content_w = myScreenW - 2 * mySpanLeft
                for index in 0...(self.arrCheckItem?.count)! - 1
                {
                    let item:FMYWCheckItemView = self.arrCheckItem![index] as! FMYWCheckItemView
                    
                    if (item.width + van_x >= content_w) {
                        van_y += mySpanUp + item.height
                        van_x = mySpanLeft
                        item.frame = CGRect(x: van_x, y: van_y, width: item.width, height: item.height)
                        
                        van_x += item.width + 2 * mySpanLeft
                    }
                    else
                    {
                        item.frame = CGRect(x: van_x, y: van_y, width: item.width, height: item.height)
                        van_x += item.width + 2 * mySpanLeft
                    }
                }
                self.bottom = self.titleH + van_y + self.checkItem1.height + 2 * mySpanH
            }
        }
    }

    
    
    
    override init() {
        super.init()
        self.arrCheckItem = [self.checkItem1,self.checkItem2,self.checkItem3,self.checkItem4]
    }
    
    //MARK: 单列初始化方法
    static func shareExamCalculate() -> CalculateExcamCellHelp {
        
        struct Singleton {
            static var single = CalculateExcamCellHelp()
        }
        
        DispatchQueue.once("shareExamTitle") {
            Singleton.single = shareExamCalculate()
        }
        
        return Singleton.single
    }
    
    
}


