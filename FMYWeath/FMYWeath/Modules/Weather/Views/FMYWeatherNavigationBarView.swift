//
//  FMYWeatherNavigationBarView.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/6.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit

enum NavigationEvent {
    case eventMoreLocation
}

class FMYWeatherNavigationBarView: FMYWView {

    let moreLocButton:UIButton = {
        let btn = UIButton.init(type: .roundedRect)
        btn.setTitle("More", for: .normal)
        return btn
    }()

    let locationLabel:UILabel = {
        let label = UILabel()
        label.text = "这里是北京"
        label.textColor = UIColor.white
        return label
    }()

    let pageController:UIPageControl = {
        let pageC = UIPageControl()
        pageC.numberOfPages = 3
        return pageC
    }()

    private var _region:FMYRegion?
    var region:FMYRegion? {
        set {
            if (newValue != nil) {
                _region = newValue
                self.locationLabel.text = "这里是\(_region?.regionName ?? "")"
            }
        }
        get {  return _region }
    }


    //定义事件回调
    var navigationHandle: ((_ event:NavigationEvent) ->(Void))?



    override init(frame:CGRect) {
        super.init(frame: frame)
        self.configureUIItems()
    }

    func configureUIItems()  {
        self.moreLocButton.showBorderLine()
        self.locationLabel.showBorderLineColor(color: UIColor.green)
        self.pageController.showBorderLine()



        self.addSubview(self.moreLocButton)
        self.addSubview(self.locationLabel)
        self.addSubview(self.pageController)
        self.moreLocButton.snp.makeConstraints { (make) in
            make.left.equalTo(myPageSpanSide)
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        self.moreLocButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        self.locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.moreLocButton.snp.top)
            make.left.equalTo(self.moreLocButton.snp.right).offset(10)
            make.height.equalTo(24);
        }
        self.pageController.snp.makeConstraints { (make) in
            make.left.equalTo(self.moreLocButton.snp.right).offset(10)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(20)
            make.width.equalTo(20 * self.pageController.numberOfPages)
        }
    }


    @objc func buttonClick(_:UIButton){
        self.navigationHandle?(.eventMoreLocation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
