//
//  FMYWImgShowView.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/27.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit
import SDWebImage

class FMYWImgShowView: UIView {
    
    let scrollView:UIScrollView = {
        let _scrollView = UIScrollView.init(frame: .zero)
        _scrollView.isPagingEnabled = true
        return _scrollView
    }()
    
    var picURLArr:NSMutableArray = NSMutableArray()
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.scrollView)
        self.scrollView.frame = self.bounds
        self.scrollView.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPicUrl(picUrl:NSArray) {
        if picUrl.count > 0 {
            for index in 0...(picUrl.count - 1) {
                let imgv    = UIImageView(frame: self.scrollView.bounds)
                imgv.left   = CGFloat(index) * self.scrollView.width
                
                let imgUrl  = (picUrl[index] as! NSDictionary).object(forKey: "url") as! String?
                
                imgv.sd_setImage(with:URL(string: imgUrl!))
                
                self.scrollView.addSubview(imgv)
                
                self.scrollView.contentSize = CGSize(width:imgv.right, height: imgv.height)
            }
        }
    }
}
