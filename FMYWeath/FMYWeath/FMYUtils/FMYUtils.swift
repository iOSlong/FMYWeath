//
//  FMYUtils.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/26.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

/*
 DateFormat -- 英文代号
 */
public enum TimeFormat:String {
//    纪元的显示：
    case TFG            = "G"       //显示AD，也就是公元

//    年的显示：
    case TFy2           = "yy"      //年的后面2位数字
    case TFy4           = "yyyy"    //显示完整的年

//    月的显示：
    case TFM4           = "MMMM"    //英文月份完整显示，例如：January | 一月    December | 十二月
    case TFM3           = "MMM"     //英文月份的缩写，例如：Jan | 一月       December | 12月
    case TFM2           = "MM"      //显示成01~12，不足2位数会补0
    case TFM1           = "M"       //显示成1~12，1位数或2位数

//    日的显示：
    case TFd2           = "dd"      //显示成1~31，1位数或2位数
    case TFd1           = "d"       //显示成01~31，不足2位数会补0

    case TFE4           = "EEEE"    //星期的缩写，如   Sun | 周五
    case TFE3           = "EEE"     //星期的完整显示，如，Sunday | 星期五

//    上/下午的显示：
    case TFaa           = "aa"      //显示AM或PM


    #if false
    /*
     小時的显示：
     H：显示成0~23，1位数或2位数(24小时制
     HH：显示成00~23，不足2位数会补0(24小时制)
     K：显示成0~12，1位数或2位数(12小時制)
     KK：显示成0~12，不足2位数会补0(12小时制)

     分的显示：
     m：显示0~59，1位数或2位数
     mm：显示00~59，不足2位数会补0

     秒的显示：
     s：显示0~59，1位数或2位数
     ss：显示00~59，不足2位数会补0
     S： 毫秒的显示

     时区的显示：
     z / zz /zzz ：PDT
     zzzz：Pacific Daylight Time
     Z / ZZ / ZZZ ：-0800
     ZZZZ：GMT -08:00
     v：PT
     vvvv：Pacific Time
     */
    #endif

    case TFm_d          = "M/d"
    case TFM_d          = "MM/dd"
    case TFd_M          = "dd/MM"
    case TFd_M_h_m      = "dd/MM hh:mm"
    case TFy_M_d        = "yyyy-MM-dd"
    case TFy_M_d_h_m_s  = "yyyy-MM-dd hh:mm:ss"
    case TFy_M_d_cn     = "yyyy年MM月dd日"
    case TFy_Md_cn      = "yyyy年MMMd日"   //MMMM 为xx月，一个d可以省去01日前的0
    case TFy_M_d_W_cn   = "yyyy年MM月dd日#EEEE"    //EEEE为星期几，EEE为周几



}

public enum TimeLocalIdentifer:String {
    case en_US_POSIX    = "en_US_POSIX"
    case zh_CN          = "zh_CN"
}

public func localDateFormatter(formateStr:TimeFormat?, localID:TimeLocalIdentifer?) -> DateFormatter {
    let formater = DateFormatter()
    formater.timeStyle  = .none
    formater.dateStyle  = .medium
    formater.dateFormat = formateStr?.rawValue

    formater.locale = Locale.current
    if localID != nil {
        formater.locale = Locale(identifier: (localID?.rawValue)!)
    }
    return formater
}


// MARK: TIME  ABOUT
public func timeShow(time:TimeInterval,
                     formaterStr:TimeFormat,
                     localId:TimeLocalIdentifer?,
                     timeSpan:TimeInterval?) ->String {
    
    let dateTimeLong = time///1000.0
    let dateTime = NSDate(timeIntervalSince1970: dateTimeLong)
    let dateDes  = dateTime.addingTimeInterval(timeSpan!)
    
    // 解决GMT时间差（8 小时）
//    let zone     = NSTimeZone.system
//    let interval = zone.secondsFromGMT(for: dateDes as Date)
//    let nowDate  = dateDes.addingTimeInterval(TimeInterval(interval))
    
    let formater = localDateFormatter(formateStr:formaterStr, localID: localId)
    let timeStr = formater.string(from: dateDes as Date)
    return timeStr
}

public func timeShow(time:TimeInterval,formateStr:TimeFormat, localId:TimeLocalIdentifer?) -> String {
    return timeShow(time: time, formaterStr: formateStr, localId: localId, timeSpan:0)
}
public func timeShow(time:TimeInterval,formateStr:TimeFormat) -> String {
    return timeShow(time: time, formateStr: formateStr, localId: .zh_CN)
}

public func timeInteger(timeStr:String,formateStr:TimeFormat, localId:TimeLocalIdentifer?) -> TimeInterval{
    let formater = localDateFormatter(formateStr:formateStr, localID:localId)
    let dateTimeLong    = formater.date(from: timeStr)
    return (dateTimeLong?.timeIntervalSince1970)!
}

public func timeInteger(timeStr:String,formateStr:TimeFormat) -> TimeInterval{
    return timeInteger(timeStr: timeStr, formateStr: formateStr, localId: .en_US_POSIX)
}

public func dateComponents() ->NSDateComponents {
    let cal = Calendar.current
    var componentsOne = cal.dateComponents([Calendar.Component.calendar, .year, .month, .day, .weekday, .hour, .minute, .second, .era, .timeZone], from: Date())
    componentsOne = cal.dateComponents(in: TimeZone.current, from: Date())
    return componentsOne as NSDateComponents
}


//  MARK: PATH FILE ABOUT
public func pathDiskCachePath(nameSpace: String) -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    return (paths.first?.appendingFormat("/\(nameSpace)"))!
    //    return (paths.first?.appending(nameSpace))!
}

public func fileGetNewsItems() -> NSArray {
    let plistObj    = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "fmywplist", ofType: "plist")!)
    let newsItems   = plistObj?.object(forKey: "newsItem")
    return newsItems as! NSArray
}

/**
 * 在swift中使用NSClassFromString className要加工程名前缀
 */
public func swiftClassFromString(className:String) ->AnyClass? {
    // get the project name
    if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
        // YourProject.className
        let classStringName = appName + "." + className
        return NSClassFromString(classStringName) ?? nil
    }
    return nil
}

class FMYUtils: NSObject {

}
