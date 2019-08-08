//
//  FMYRegion.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/1.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit
import SWXMLHash

struct FMYCountry: XMLIndexerDeserializable {
    let title:String
    let code:String
    static func deserialize(_ node: XMLIndexer) throws -> FMYCountry {
        let region:String = node.element?.text ?? "阿尔及利亚,3320"
        let regionComponents:[String] = region.components(separatedBy: ",")
        let ttitle = regionComponents[0]
        let tcode = regionComponents[1]
        return FMYCountry(
            title: ttitle,
            code:tcode
        )
    }
}

struct FMYRegion: XMLIndexerDeserializable {
    let regionID:String
    let regionName:String
    static func deserialize(_ node: XMLIndexer) throws -> FMYRegion {
        return try FMYRegion(
            regionID: node["RegionID"].value(),
            regionName: node["RegionName"].value()
        )
    }

    static func regionFrom(dict:NSDictionary) -> FMYRegion {
        let ID:String      = dict.object(forKey: "regionID") as! String
        let Name:String    = dict.object(forKey: "regionName") as! String
        return FMYRegion.init(regionID: ID, regionName: Name)
    }
}
