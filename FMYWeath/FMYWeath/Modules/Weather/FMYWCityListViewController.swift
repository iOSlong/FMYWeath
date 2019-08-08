//
//  FMYWCityListViewController.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/20.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

class FMYWCityListViewController: FMYWViewController {
    let business:FMYWeatherBusiness = FMYWeatherBusiness()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = colorMainBack

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.business.getRegionCountry()
//        self.business.getRegionDataset { (regions) in
//            print(regions)
//        }
//        self.business.getWeather(cityCode: "1679") { (response) in
//            print(response)
//        }
    }
}
