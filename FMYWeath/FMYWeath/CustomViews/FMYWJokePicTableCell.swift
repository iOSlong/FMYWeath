//
//  FMYWJokePicTableCell.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/11.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import UIKit
import WebKit
import HandyJSON

public enum JokePicType:String {
    case JImgNone = "imageNone"
    case JImgHave = "imageHave"
}

class FMYWJokePicModel: HandyJSON {
    var content     :Any? = nil
    var hashId      :Any? = nil
    var unixtime    :Any? = nil
    var updatetime  :Any? = nil
    var url         :Any? = nil
    
    
    var picType:JokePicType? {
        if url != nil {
            let urlStr:String = self.url as! String
            if urlStr.lengthOfBytes(using: .utf8) > 5 {
                return .JImgHave
            }
        }
        return .JImgNone
    }
    required init() {
    }
}





class FMYWJokePicTableCell: FMYTableViewCell,WKNavigationDelegate {
    var labelContent:UILabel? = nil
    var labelTime:UILabel? = nil
    var imgvContent:UIImageView? = nil
    var wkwebView:WKWebView? = nil
    
    private var temjokePicModel:FMYWJokePicModel? = nil
    var jokePicModel:FMYWJokePicModel? {
        get {
            return temjokePicModel
        }
        set {
            if (newValue != nil) {
                temjokePicModel = newValue
                self.refreshUIItems()
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor  = .clear
        
        self.configureUIItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configureUIItems() -> Void {
        
        self.labelContent = UILabel(frame: CGRect(x:mySpanLeft, y:mySpanUp, width: myScreenW - 2 * mySpanLeft, height: 20));
        self.labelContent?.textColor = .white;
        self.labelContent?.numberOfLines = 0;
        self.labelContent?.font = UIFont.systemFont(ofSize: 15)
        
        self.imgvContent = UIImageView(frame: CGRect(x:mySpanLeft, y:mySpanUp, width: myScreenW - 2 * mySpanLeft, height:200))
        self.imgvContent?.contentMode = .scaleAspectFit
        self.imgvContent?.top = (self.labelContent?.bottom)! + mySpanUp
        
        
        self.wkwebView = WKWebView.init(frame: (self.imgvContent?.frame)!)
        self.wkwebView?.backgroundColor = .clear
        self.wkwebView?.isOpaque = false
        self.wkwebView?.scrollView.bounces = false
        self.wkwebView?.scrollView.backgroundColor = .clear
        
        self.contentView.addSubview(self.labelContent!)
        self.contentView.addSubview(self.imgvContent!)
        self.contentView.addSubview(self.wkwebView!)
    }
    
    
    func refreshUIItems() -> Void {
        
        if (self.jokePicModel != nil) {
            
            let content = self.jokePicModel?.content as! String
            self.labelContent?.width = myScreenW - 2 * mySpanLeft;
            self.labelContent?.text = content
            self.labelContent?.sizeToFit()
            
            self.imgvContent?.top = (self.labelContent?.bottom)! + mySpanH
            self.wkwebView?.top = (self.labelContent?.bottom)! + mySpanH

            if self.jokePicModel?.picType == .JImgHave {
                let imgUrl = self.jokePicModel?.url as! String
                
                // TODO: 处理批量下载存储映射问题（线程管理，下载队列处理）
//                self.imgvContent?.sd_setImage(with: URL(string: imgUrl), completed: { [unowned self] (image, error, cacheType, url) in
//                    print("over show!");
//                    
//                   self.imgvContent?.image =  UIImage.sd_animatedGIF(with: UIImagePNGRepresentation(image!))
//                    
//                })
//                
//                self.imgvContent?.isHidden = false
                
                _ = self.wkwebView?.load(URLRequest.init(url: URL(string: imgUrl)!));
                self.wkwebView?.navigationDelegate = self
                
                
            }else{
                self.imgvContent?.isHidden = true
            }
        }
        return;
    }
}
