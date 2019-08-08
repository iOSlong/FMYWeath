//
//  FMYWXibTestView.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/9.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit

class FMYWeatherShowView: UIView {

    @IBOutlet weak var labelRegionInfo: UILabel!
    @IBOutlet weak var labelTempt: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!      //湿度
    @IBOutlet weak var labelUltraviolet: UILabel!   //紫外线
    @IBOutlet weak var ariQuality: UILabel!
    @IBOutlet weak var labelDescription: UILabel!



    private var _wd:FMYWeatherDetail?
    var weatherDetail:FMYWeatherDetail {
        set {
            _wd = newValue
            self.refreshWeatherItems()
        }
        get{return _wd ?? FMYWeatherDetail(items:nil)}
    }

    func refreshWeatherItems() {
        self.labelRegionInfo.text = self.weatherDetail.regionInfo
        self.labelTempt.text = self.weatherDetail.tempt
        self.labelWind.text = self.weatherDetail.wind
        self.labelHumidity.text = self.weatherDetail.humidity
        self.labelUltraviolet.text = self.weatherDetail.ultraviolet
        self.ariQuality.text = self.weatherDetail.ariQuality
        self.labelDescription.text = self.weatherDetail.instruction
    }

}
