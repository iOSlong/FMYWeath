//
//  FMYWeatherDetail.swift
//  FMYWeath
//
//  Created by xw.long on 2019/8/4.
//  Copyright © 2019 fmylove. All rights reserved.
//

import UIKit
import SWXMLHash

class FMYWeatherDetail: NSObject {
    var region_city: String {get{
        return detailRowItems[0].weatherRowItem
        }}//Array(0) = "省份 地区/洲 国家名（国外）"
    var city: String {get{
        return detailRowItems[1].weatherRowItem
        }}//Array(1) = "查询的天气预报地区名称"
    var cityCode: String {get{
        return detailRowItems[2].weatherRowItem
        }}//Array(2) = "查询的天气预报地区ID"
    var timeDate: String {get{
        return detailRowItems[3].weatherRowItem
        }}//Array(3) = "最后更新时间 格式：yyyy-MM-dd HH:mm:ss"
    var scene: String {get{
        return detailRowItems[4].weatherRowItem
        }}//Array(4) = "当前天气实况：气温、风向/风力、湿度"
    var airIndex: String {get{
        return detailRowItems[5].weatherRowItem
        }}//Array(5) = "第一天 空气质量、紫外线强度"
    var livingIndex: String {get{
        return detailRowItems[6].weatherRowItem
        }}//Array(6) = "第一天 天气和生活指数"


    var tempAndWindAndHumi:Array<String> {get{
        return self.scene.components(separatedBy: "；")
        }}

    var regionInfo: String {get{
        return self.region_city
        }}
    var tempt: String{get{
        let temp = tempAndWindAndHumi[0]
        let arr:Array<String> = temp.components(separatedBy: "：")
        return arr.last!
        }}
    var wind: String{get{
        let temp = tempAndWindAndHumi[1]
        let arr:Array<String> = temp.components(separatedBy: "：")
        return arr.last!
        }}
    var humidity: String{get{
        let temp = tempAndWindAndHumi[2]
        let arr:Array<String> = temp.components(separatedBy: "：")
        return arr.last!
        }}
    var ultraviolet: String{get{
        let airS = self.airIndex.components(separatedBy: "。")
        let temp = airS[0]
        let arr:Array<String> = temp.components(separatedBy: "：")
        return arr.last!
        }}
    var ariQuality: String{get{
        let airS = self.airIndex.components(separatedBy: "。")
        let temp = airS[1]
        let arr:Array<String> = temp.components(separatedBy: "：")
        return arr.last!
        }}
    var instruction: String{get{
        return self.livingIndex
        }}






    var dayNow:FMYWeatherDetailSection?
    var daySecond:FMYWeatherDetailSection?
    var dayThird:FMYWeatherDetailSection?
    var dayFourth:FMYWeatherDetailSection?
    var dayFifth:FMYWeatherDetailSection?



    var detailRowItems:Array<FMYWeatherDetailRowItem> = []
    init(items:Array<FMYWeatherDetailRowItem>?) {
        if items != nil {
            detailRowItems = items!
            dayNow = FMYWeatherDetailSection.init(items:detailRowItems, dayIndex: 1)
            daySecond = FMYWeatherDetailSection.init(items:detailRowItems, dayIndex: 2)
            dayThird = FMYWeatherDetailSection.init(items:detailRowItems, dayIndex: 3)
            dayFourth = FMYWeatherDetailSection.init(items:detailRowItems, dayIndex: 4)
            dayFifth = FMYWeatherDetailSection.init(items:detailRowItems, dayIndex: 5)
        }
    }
}

struct FMYWeatherDetailSection {
    var weather: String {get{
        return detailRowItems[0 + rowIndexStar].weatherRowItem
        }}//Array(7) = "第一天 概况 格式：M月d日 天气概况"
    var airTemp: String {get{
        return detailRowItems[1 + rowIndexStar].weatherRowItem
        }}//Array(8) = "第一天 气温"
    var wind: String {get{
        return detailRowItems[2 + rowIndexStar].weatherRowItem
        }}//Array(9) = "第一天 风力/风向"
    var weatherIcon1: String {get{
        return detailRowItems[3 + rowIndexStar].weatherRowItem
        }}//Array(10) = "第一天 天气图标 1"
    var weatherIcon2: String {get{
        return detailRowItems[4 + rowIndexStar].weatherRowItem
        }}//Array(11) = "第一天 天气图标 2"
    var detailRowItems:Array<FMYWeatherDetailRowItem>
    var rowIndexStar:Int
    var dayInex:Int
    init(items:Array<FMYWeatherDetailRowItem>, dayIndex:Int) {
        detailRowItems = items
        dayInex = dayIndex
        rowIndexStar = dayIndex * 5 + 2
    }
    func description() -> String {
        return "day:\(dayInex):" + weather
    }
}

struct FMYWeatherDetailRowItem: XMLIndexerDeserializable {
    let weatherRowItem:String
    static func deserialize(_ node: XMLIndexer) throws -> FMYWeatherDetailRowItem {
        let rowItem:String = node.element?.text ?? "xxx"
        return FMYWeatherDetailRowItem(
            weatherRowItem : rowItem
        )
    }
}

