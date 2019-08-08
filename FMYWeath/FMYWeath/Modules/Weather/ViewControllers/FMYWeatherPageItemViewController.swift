//
//  FMYWeatherPageItemViewController.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/6.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit

class FMYWeatherPageItemViewController: FMYWViewController {
    let business:FMYWeatherBusiness = FMYWeatherBusiness()
    var region:FMYRegion?


    let weatherShowView:FMYWeatherShowView = (Bundle.main.loadNibNamed("FMYWeatherShowView", owner: self, options: nil)?.first as! FMYWeatherShowView)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.configureWeatherShowView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getWeatherDetail()
    }

    func configureWeatherShowView() {
        self.view.addSubview(self.weatherShowView)
        self.weatherShowView.showBorderLineColor(color: .blue)
        self.weatherShowView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
        }
    }

    //MARK: DATA ABOUT
    func getWeatherDetail()  {
        self.business.fetchWeather(cityCode: region!.regionID) { (result) in
             let weatherDetail = result.value
             if weatherDetail != nil {
                self.weatherShowView.weatherDetail = weatherDetail!
            }
        }
    }
}
