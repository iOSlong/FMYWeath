//
//  FMYWWeatherShowView.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/3.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit

class FMYWWeatherShowView: FMYXibView {
    private var _wd:FMYWeatherDetail?
    var weatherDetail:FMYWeatherDetail {
        set {
            _wd = newValue
            self.refreshWeatherItems()
        }
        get{return _wd ?? FMYWeatherDetail(items:nil)}
    }

    let labelRegionInfo:FMYLabel = {
        let label = FMYLabel(frame: .zero); return label
    }()
    let labelDate:FMYLabel = {
        let label = FMYLabel(frame: .zero); return label
    }()
    let labelTempt:FMYLabel = {
        let label = FMYLabel(frame: .zero); return label
    }()
    let labelIcon:FMYLabel = {
        let label = FMYLabel(frame: .zero); return label
    }()
    let labelWind:FMYLabel = {
        let label = FMYLabel(frame: .zero); return label
    }()
    let labelAbstract:FMYLabel = {
        let label = FMYLabel(frame: .zero)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font          = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUIItems()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureUIItems() {
        self.labelDate.showBorderLine()
        self.labelIcon.showBorderLine()
        self.labelWind.showBorderLine()
        self.labelTempt.showBorderLine()
        self.labelAbstract.showBorderLine()

        self.addSubview(labelDate)
        self.addSubview(labelIcon)
        self.addSubview(labelWind)
        self.addSubview(labelAbstract)
        self.addSubview(labelTempt)

        labelIcon.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp_topMargin).offset(110)
            make.left.equalTo(self.snp.leftMargin).offset(0)
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
        labelTempt.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp_topMargin).offset(20)
            make.left.equalTo(self.snp.leftMargin).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }

        labelDate.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp_topMargin).offset(140)
            make.left.equalTo(self.snp.leftMargin).offset(105)
            make.width.equalTo(180)
            make.height.equalTo(40)
        }

        labelWind.snp.makeConstraints { (make) in
            make.top.equalTo(140)
            make.left.equalTo(105)
            make.width.equalTo(180)
            make.height.equalTo(40)
        }

        labelAbstract.snp.makeConstraints { (make) in
            make.top.equalTo(180)
            make.left.equalTo(10)
            make.width.equalTo(120)
            make.height.equalTo(190)
        }
    }


    func refreshWeatherItems() {
        self.labelDate.text = self.weatherDetail.timeDate
        self.labelTempt.text = self.weatherDetail.scene
        self.labelAbstract.text = self.weatherDetail.livingIndex
        self.labelIcon.text = self.weatherDetail.airIndex
    }

    func additionalViewsClear()  {
        print(additionalViewsClear)
    }

    func reloadViewModel(viewModel:Any)  {

    }
}
