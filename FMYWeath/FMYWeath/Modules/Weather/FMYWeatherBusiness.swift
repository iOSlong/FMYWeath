//
//  FMYWeatherBusiness.swift
//  FMYWeath
//
//  Created by xw.long on 2019/7/31.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit
import SWXMLHash

class FMYWeatherBusiness: NSObject , XMLParserDelegate{


    func getRegionCountry() -> Void {
        let httpSession = FMYHTTPSessionManager(url: URL(string: "http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionCountry"), configuration: nil)
        _ = httpSession.net("Get", parameters: nil, success: { (dataTask, object) in
//            let dataStr =  String(data: object as! Data, encoding: .utf8)
//            print(dataStr ?? "")

//            let parser:XMLParser =  XMLParser.init(data: object as! Data)
//            parser.delegate = self
//            parser.parse()

        }) { (dataTask, error) in
            print(error)
        }
    }

    //    MARK: - XMLParserDelegate
    func parserDidStartDocument(_ parser: XMLParser) {
        print("parse star!")
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        print("parse end!")
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("\(elementName)-->\(String(describing: qName)) --> \(attributeDict)")
    }

}
