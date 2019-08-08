//
//  FMYWeatherBusiness.swift
//  FMYWeath
//
//  Created by xw.long on 2019/7/31.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit
import SWXMLHash
import Alamofire

class FMYWeatherBusiness: NSObject {

    var request: Request? {
        didSet {
            oldValue?.cancel()
            headers.removeAll()
            body = nil
            elapsedTime = nil
        }
    }

    var cityCode:String = "1679" //default 毕节
    var headers: [String: String] = [:]
    var body: String?
    var elapsedTime: TimeInterval?
    var segueIdentifier: String?
    var weatherDetail:FMYWeatherDetail?

    func fetchWeather(cityCode:String, complete:@escaping (Result<FMYWeatherDetail>)->Void) -> Void {
        let url:URL = URL(string: "http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theUserID=&theCityCode=\(cityCode)")!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
            switch (response.result) {
            case .success(_):
                if let resonseValue = response.result.value {
                    let xml = SWXMLHash.parse(resonseValue)
                    do{
                        let rootOne = try xml.byKey("ArrayOfString")
                        let item = try rootOne.byKey("string")

                        let rowItems: [FMYWeatherDetailRowItem] = try item.value()
                        self.weatherDetail = FMYWeatherDetail.init(items: rowItems)
                        print(rowItems[0])
                        complete(Result.success(self.weatherDetail!))
//                        complete(Result.init(value: { () -> FMYWeatherDetail in
//                            return weatherDetil
//                        }))
                    } catch (let error) {
                        print(error)
                        complete(Result.failure(error))
                    }
                }
            case .failure(let error):
                complete(Result.failure(error))
                print("请求网络失败:\(error)")
                break
            }
        }



/*
        let httpSession = FMYHTTPSessionManager(url: URL(string: "http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theUserID=&theCityCode=\(cityCode)"), configuration: nil)
        _ = httpSession.net("Get", parameters: nil, success: { (dataTask, object) in
            let xml = SWXMLHash.parse(object as! Data)
            do{
                let rootOne = try xml.byKey("ArrayOfString")
                let item = try rootOne.byKey("string")

                let countries: [FMYCountry] = try item.value()

                print(countries[0])
                complete(countries)
            } catch (let error) {
                print(error)
            }
        }) { (dataTask, error) in
            print(error)
        }

*/

    }

//
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

    func getRegionDataset(complete:@escaping (Any)->Void) -> Void {
        let httpSession = FMYHTTPSessionManager(url: URL(string: "http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionDataset"), configuration: nil)
        _ = httpSession.net("Get", parameters: nil, success: { (dataTask, object) in
            let xml = SWXMLHash.parse(object as! Data)
            do{
                let regionNode = try xml["DataSet"]["diffgr:diffgram"]["getRegion"].byKey("Country")
                let regions: [FMYRegion] = try regionNode.value()
                complete(regions)
            } catch (let error) {
                print(error)
            }
        }) { (dataTask, error) in
            print(error)
        }
    }
}
