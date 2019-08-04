//
//  FMYWeatherShowViewController.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/3.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit


class FMYWeatherShowViewController: FMYWViewController,UIScrollViewDelegate{

    var business:FMYWeatherBusiness? = nil
    var arrWeatherItems:NSMutableArray =  NSMutableArray()
    var arrWeatherExplandItems:NSMutableArray = NSMutableArray()
    var arrReuseWeatherViews:NSMutableArray =  NSMutableArray()

    var currentWeather:FMYWWeatherShowView?
    var showIndex:Int = 0
    var timer:Timer? = nil


    let containerView:UIScrollView = {
        let _scrollView = UIScrollView(frame: .zero)
        _scrollView.isPagingEnabled = true
        _scrollView.showsHorizontalScrollIndicator = false
        return _scrollView
    }()
    let pageControl:UIPageControl = {
        let pageC = UIPageControl.init(frame: .zero)
        return pageC
    }()





    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupContentFromItemArr(items:NSArray)  {
        if items.count>0 {
            self.configureBaseUIItems()
        }
        self.arrWeatherExplandItems.addObjects(from: items as! [Any])
        if items.count > 1 {
            self.arrWeatherExplandItems.add(items.firstObject!)
            self.arrWeatherExplandItems.insert(items.lastObject!, at: 0)
        }
        if self.arrWeatherExplandItems.count > 0 {
            let itemWidth   = self.containerView.width
            let itemHeight  = self.containerView.height
            var offsetMax:CGFloat   = 0

            for index in 0..<self.arrWeatherExplandItems.count {
                let itemFrame = CGRect(x: CGFloat(index) * itemWidth, y: 0, width: itemWidth, height: itemHeight)
                let itemView:FMYWWeatherShowView = self.weatherShowViewThroughIndex(index: index, frame: itemFrame)
                self.containerView.addSubview(itemView)
                offsetMax = itemView.right

                let viewModel = self.arrWeatherExplandItems[index]
                itemView.reloadViewModel(viewModel: viewModel)
            }
            self.containerView.contentSize = CGSize(width: offsetMax, height: itemHeight)
            if offsetMax > itemWidth {
                self.showIndex = 1
            }
            self.scrollviewDidScrollToIndex(index:self.showIndex, animation: false)
            self.timerWithItem(item: self.arrWeatherItems.firstObject);
        }
    }

    func timerWithItem(item:Any?) {
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (tim) in
            self.timerEvent(timer: tim)
        })
    }

    func timerEvent(timer:Timer)  {
        self.scrollviewDidScrollToIndex(index: self.showIndex + 1, animation: true)
        self.timerWithItem(item: self.arrWeatherItems[self.showIndex - 1])
    }

    func scrollviewDidScrollToIndex(index:Int, animation:Bool) {
        if self.arrReuseWeatherViews.count == 0 {
            return
        }
        let scrollW:CGFloat      = self.containerView.width
        let tempOffsetX:CGFloat  = self.containerView.contentOffset.x
        let destOffsetX:CGFloat  = scrollW * CGFloat(index)
        if destOffsetX != tempOffsetX {
            self.containerView .setContentOffset(CGPoint.init(x: destOffsetX, y: 0), animated: animation)
        }
        if self.arrReuseWeatherViews.count >= index {
            self.currentWeather = self.itemViewFrom(index: index)
        }

    }
    func itemViewFrom(index:Int) -> FMYWWeatherShowView? {
        var weatherShowView:FMYWWeatherShowView? = nil
        self.arrReuseWeatherViews .enumerateObjects { (showView, idx, unsafeMutablePointer) in
            if index == idx {
                weatherShowView = (showView as! FMYWWeatherShowView)
                return
            }
        }
        return weatherShowView
    }

    func weatherShowViewThroughIndex(index:Int, frame:CGRect) -> FMYWWeatherShowView {
        var wsw:FMYWWeatherShowView? = nil
        if self.arrReuseWeatherViews.count <= index {
            wsw = FMYWWeatherShowView(frame: frame)
            if index == 1 {
                self.currentWeather = wsw
            }
        } else {
            wsw = self.arrWeatherExplandItems[index] as? FMYWWeatherShowView
            wsw?.frame = frame
        }
        wsw?.tag = index
        return wsw!
    }

    func configureBaseUIItems() {
        if self.containerView.superview == nil {
            self.view.addSubview(self.containerView)
            self.containerView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            self.containerView.delegate = self;
            self.view.addSubview(self.pageControl)
            self.pageControl.snp.makeConstraints { (make) in
                make.width.equalTo(200)
                make.height.equalTo(50)
                make.centerX.equalTo(self.view.centerX)
                make.centerY.equalTo(self.view.bottom).offset(-200)
            }
        }
        self.arrReuseWeatherViews.enumerateObjects({(weatherShowView, index, UnsafeMutablePointer) in
            (weatherShowView as! FMYWWeatherShowView).additionalViewsClear()
        })
        for subV in self.containerView.subviews {
            subV.removeFromSuperview()
        }
        self.pageControl.numberOfPages  = self.arrWeatherItems.count
        self.pageControl.currentPage    = 0
    }



    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex   = Int(scrollView.contentOffset.x)/Int(self.containerView.width)
        let pageCount   = self.arrWeatherExplandItems.count
        self.showIndex  = pageIndex
        if (pageIndex == 0 || pageIndex == pageCount - 1){
            if pageIndex == 0  {
                self.showIndex = pageCount - 2
            } else if pageIndex == pageCount - 1 {
                self.showIndex = 1
            }
            self.scrollviewDidScrollToIndex(index: self.showIndex, animation: false)
        } else {
            self.scrollviewDidScrollToIndex(index: self.showIndex, animation: true)
        }
        self.pageControl.currentPage = self.showIndex - 1
        self.timerWithItem(item: self.arrWeatherItems[self.showIndex - 1])
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageIndex   = Int(scrollView.contentOffset.x)/Int(scrollView.width)
        let pageCount   = self.arrWeatherExplandItems.count
        self.showIndex  = pageIndex
        if (pageIndex == 0 || pageIndex == pageCount - 1){
            if pageIndex == 0  {
                self.showIndex = pageCount - 2
            } else if pageIndex == pageCount - 1 {
                self.showIndex = 1
            }
            self.scrollviewDidScrollToIndex(index: self.showIndex, animation: false)
        }
        self.pageControl.currentPage = self.showIndex - 1
    }
}
