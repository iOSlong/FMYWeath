//
//  FMYWImgShowView.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/27.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit
import SDWebImage

class FMYWImgShowView: UIView , UIScrollViewDelegate{

    let scrollView:UIScrollView = {
        let _scrollView = UIScrollView(frame: .zero)
        _scrollView.isPagingEnabled = true
        _scrollView.showsHorizontalScrollIndicator = false
        return _scrollView
    }()
    let labelTitle:UILabel = {
        let _label = UILabel(frame: .zero)
        _label.textColor = UIColor.cyan
        _label.font = UIFont.systemFont(ofSize: 13)
        _label.textAlignment = .center
        _label.numberOfLines = 0
        return _label
    }()

    var picURLArr:NSMutableArray = NSMutableArray()

    private var eventHander:((_ index:Int, _ object:Any) -> Void)? = nil



    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.scrollView)
        self.scrollView.frame = self.bounds
        self.scrollView.delegate = self;

        self.addSubview(self.labelTitle)
        self.labelTitle.origin = CGPoint(x: mySpanH, y: 0)
        self.labelTitle.size    = CGSize(width: self.scrollView.width, height: 30)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPicUrl(picUrl:NSArray) {

        if picUrl.count > 1 {
            self.picURLArr.addObjects(from: picUrl as! [Any])
            self.picURLArr.add(picUrl.firstObject ?? ["url":""])
            self.picURLArr.insert(picUrl.lastObject ?? ["url":""], at: 0)
        }else{
            self.picURLArr.addObjects(from: picUrl as! [Any])
        }

        if self.picURLArr.count > 0 {
            var offsetMax:CGFloat = 0.0

            for index in 0...(self.picURLArr.count - 1) {
                let imgv    = UIImageView(frame: self.scrollView.bounds)
                imgv.left   = CGFloat(index) * self.scrollView.width
                imgv.contentMode = .scaleAspectFit

//                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//                label.text = String(index)
//                imgv.addSubview(label)

                let imgUrl  = (self.picURLArr[index] as! NSDictionary).object(forKey: "url") as! String?

                imgv.sd_setImage(with:URL(string: imgUrl!))

                self.scrollView.addSubview(imgv)

                offsetMax = imgv.right
            }

            self.scrollView.contentSize = CGSize(width:offsetMax, height: self.scrollView.height)
            if offsetMax > self.scrollView.width {
                self.scrollView.contentOffset = CGPoint(x: self.scrollView.width, y: 0)
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex   = Int(scrollView.contentOffset.x)/Int(self.scrollView.width)
        let scrollW     = self.scrollView.width
        let pageCount   = self.picURLArr.count
        var shouldPage  = pageIndex
        if pageCount > 1 {
            if pageIndex == 0 {
                shouldPage = pageCount - 2
//                self.scrollView.setContentOffset(CGPoint(x: CGFloat(pageCount - 2) * scrollW, y: 0), animated: false)
            }else if pageIndex == pageCount - 1 {
                shouldPage = 1
            }

            self.scrollView.setContentOffset(CGPoint(x: scrollW * CGFloat(shouldPage), y: 0), animated: false)
        }

        let title = (self.picURLArr[shouldPage] as! NSDictionary).object(forKey: "pic_title")
        self.labelTitle.text = title as! String?

        if self.eventHander != nil {
            self.eventHander!(shouldPage, self.picURLArr[shouldPage])
        }
    }

    func imgShow(eventHander: @escaping ((_ index:Int, _ object:Any) -> Void)) {
        self.eventHander = eventHander
    }
}






