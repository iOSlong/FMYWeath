//
//  FMYWTodayHistoryModel.swift
//  FMYWeath
//
//  Created by xuewu.long on 16/12/26.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit
import HandyJSON

class FMYWTodayHistoryModel: HandyJSON {
    var date     :Any? = nil
    var day      :Any? = nil
    var e_id     :Any? = nil
    var title    :Any? = nil

    var content     :Any? = nil
    var picNo       :Any? = nil
    var picUrl      :Any? = nil  //[["pic_title":"儒略历","id":1,"url":"http://images.juheapi.com/history/1_2.jpg"],……]

    var _id     :Any? = nil
    var year     :Any? = nil
    var pic     :Any? = nil
    var month     :Any? = nil
    var des     :Any? = nil
    var lunar     :Any? = nil

    var ID:String? {
        get {
            if self.e_id != nil {
                return self.e_id as! String?
            }else if  self._id != nil {
                return self._id as! String?
            }
            return nil
        }
    }
    required init() {
    }
}
