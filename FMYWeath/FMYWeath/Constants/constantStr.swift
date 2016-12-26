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


//1.按更新时间查询笑话  http://japi.juhe.cn/joke/content/list.from?sort=desc&page=&pagesize=2&time=1418816972&key=fd7e7824f6882e7b146a4c5b0eda5e5c
let url_jokeList        =   "http://japi.juhe.cn/joke/content/list.from"

//2. http://japi.juhe.cn/joke/img/list.from?sort=desc&page=&pagesize=2&time=1418745237&key=fd7e7824f6882e7b146a4c5b0eda5e5c
let url_jokeImgList     =   "http://japi.juhe.cn/joke/img/text.from?"

// 3. 随机获取笑话/趣图 //http://v.juhe.cn/joke/randJoke.php?key=fd7e7824f6882e7b146a4c5b0eda5e5c&type=true
let url_randjoke        = "http://v.juhe.cn/joke/randJoke.php"



// 历史上的今天
//http://v.juhe.cn/todayOnhistory/queryEvent.php?key=72dc0d05547cc2c8380162ecaf186bf0&date=1/1
let url_todayOnHistory  = "http://v.juhe.cn/todayOnhistory/queryEvent.php"


let pageSize    = "15"

public func api_jokeList() ->String {
    let url = url_jokeList + "?" + "key" + apiKey_joke
    return url
}
