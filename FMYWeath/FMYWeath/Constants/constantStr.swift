//
//  constantStr.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/25.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import Foundation

let apiKey_joke         =   "fd7e7824f6882e7b146a4c5b0eda5e5c"
let apiKey_today        =   "72dc0d05547cc2c8380162ecaf186bf0"
let apiKey_almanac      =   "0cf2f45852cc03991786d1f1e029df75"
let apiKey_toutiao      =   "975b3aed023d5967743f0b7a2298e829"


/* 
 老黄历
 param: date	string	是	日期，格式2014-09-09
 |      key : apiKey_almanac
 */
let url_almanac         = "http://v.juhe.cn/laohuangli/d"
let url_almanac_h       = "http://v.juhe.cn/laohuangli/h"

//1.按更新时间查询笑话
let url_jokeList        =   "http://japi.juhe.cn/joke/content/list.from"

//2.
let url_jokeImgList     =   "http://japi.juhe.cn/joke/img/text.from?"

// 3. 随机获取笑话/趣图
let url_randjoke        = "http://v.juhe.cn/joke/randJoke.php"



// 历史上的今天
let url_todayOnHistory  = "http://api.juheapi.com/japi/toh"
// 历史今天详情
let url_todayOnHistoryDetail = "http://api.juheapi.com/japi/toh"


//今日头条
let url_newsToutiao     = "http://v.juhe.cn/toutiao/index"


let pageSize    = "15"

public func api_jokeList() ->String {
    let url = url_jokeList + "?" + "key" + apiKey_joke
    return url
}

// MARK: USER_DEFAULT_KEY
let default_key_newsItems   = "default_key_newsItems"








