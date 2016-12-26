//
//  constantStr.swift
//  FMYWeath
//
//  Created by xw.long on 16/12/25.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import Foundation

//1.按更新时间查询笑话  http://japi.juhe.cn/joke/content/list.from?sort=desc&page=&pagesize=2&time=1418816972&key=fd7e7824f6882e7b146a4c5b0eda5e5c
let url_jokeList = "http://japi.juhe.cn/joke/content/list.from"
let apiKey_joke = "fd7e7824f6882e7b146a4c5b0eda5e5c"



public func api_jokeList() ->String {
    let url = url_jokeList + "?" + "key" + apiKey_joke
    return url
}
