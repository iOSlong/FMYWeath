//
//  FMYExtension.swift
//  FMYWeath
//
//  Created by xuewu.long on 17/1/19.
//  Copyright © 2017年 fmylove. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    private static var onceToken  = [String]()
    public class func once(_ token: String, _ block:@escaping () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        if onceToken.contains(token) {
            return
        }
        onceToken.append(token)
        block()
    }
}
