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

        self.business.getRegionCountry()
        // Do any additional setup after loading the view.
    }
}
