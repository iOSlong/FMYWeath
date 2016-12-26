//
//  FMYUtils.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/26.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

public enum TimeFormat:String {
    case TFM_d          = "MM/dd";
    case TFd_M          = "dd/MM";
    case TFd_M_h_m      = "dd/MM hh:mm";
    case TFy_M_d        = "yy-MM-dd"
    case TFy_M_d_h_m_s  = "yy-MM-dd hh:mm:ss"
}


public func timeShow(time:TimeInterval,formateStr:TimeFormat) -> String {
    let dateTimeLong = time///1000.0
    let dateTime = NSDate(timeIntervalSince1970: dateTimeLong)
    let formater = DateFormatter()
    formater.locale = Locale(identifier: "zh_CN")
    formater.dateFormat = formateStr.rawValue
    let timeStr = formater.string(from: dateTime as Date)
    return timeStr
}

//  MARK: PATH ABOUT
public func diskCachePath(nameSpace: String) -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    return (paths.first?.appendingFormat("/\(nameSpace)"))!
    //    return (paths.first?.appending(nameSpace))!
}

class FMYUtils: NSObject {

}
