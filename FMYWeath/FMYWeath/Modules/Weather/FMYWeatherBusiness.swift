//
//  FMYWeatherBusiness.swift
//  FMYWeath
//
//  Created by xw.long on 2019/7/31.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit
import SWXMLHash

class FMYWeatherBusiness: NSObject {


    func getRegionCountry() -> Void {
        let httpSession = FMYHTTPSessionManager(url: URL(string: "http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionCountry"), configuration: nil)
        _ = httpSession.net("Get", parameters: nil, success: { (dataTask, object) in

            let xml = SWXMLHash.parse(object as! Data)

            do{
                let rootOne = try xml.byKey("ArrayOfString")
                let item = try rootOne.byKey("string")

                let countries: [FMYCountry] = try item.value()

                print(countries[0])

            } catch (let error) {
                print(error)
            }

        }) { (dataTask, error) in
            print(error)
        }
    }

    func getRegionDataset() -> Void {
        let httpSession = FMYHTTPSessionManager(url: URL(string: "http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionDataset"), configuration: nil)
        _ = httpSession.net("Get", parameters: nil, success: { (dataTask, object) in

            let xml = SWXMLHash.parse(object as! Data)

            do{
                let regionNode = try xml["DataSet"]["diffgr:diffgram"]["getRegion"].byKey("Country")
                let regions: [FMYRegion] = try regionNode.value()
                print(regions[0])

            } catch (let error) {
                print(error)
            }

        }) { (dataTask, error) in
            print(error)
        }
    }
}
