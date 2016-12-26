//
//  FMYURLSessionManager.swift
//  FMYCS
//
//  Created by xw.long on 16/12/21.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit
//typealias completionHander = (_ str1:String, _ str2:String) -> String


typealias FMYSessionTaskCompletionHander = (URLResponse?, Any , Error?) -> Void

class FMYURLSessionManager: NSObject,URLSessionDataDelegate {
    fileprivate (set)   var session:URLSession? = nil
    fileprivate (set)   var operationQueue:OperationQueue? = nil

    var dataTasks:Array<URLSessionDataTask> = []


    var sessionConfiguration:URLSessionConfiguration? = nil
    
    var completionHander:FMYSessionTaskCompletionHander? = nil
//    var paramsVC:completionHander? = nil


    var muData = Data()


    override convenience init(){
        self.init(configuration:nil)
    }

    init(configuration:URLSessionConfiguration?) {
        super.init()
        
        if configuration == nil {
            self.sessionConfiguration = URLSessionConfiguration.default
        }
        
        
        self.operationQueue = OperationQueue()
        self.operationQueue?.maxConcurrentOperationCount = 1
        
        
        self.session    = URLSession(configuration: self.sessionConfiguration!, delegate: self, delegateQueue: self.operationQueue)
        
//        self.session?.getTasksWithCompletionHandler({ (dataTasks, uploadTasks, downloadTasks) in
//            for task in dataTasks {
//                
//            }
//        })
    }

    //for test
//    public func funcParamsClosure(paramsClosure : @escaping completionHander) {
//        self.paramsVC = paramsClosure
//    }
    
    
    // MARK: instance Methods
    public func dataTask(request:URLRequest,completionHander:((_ response:URLResponse?, _ responseObject : Any , _ error:Error?) -> Void)?) -> URLSessionDataTask {
        
        let dataTask:URLSessionDataTask = (self.session?.dataTask(with: request))!
        
        self.completionHander = completionHander
        
        self.dataTasks.append(dataTask)
        
        return dataTask
    }
    
    
    
    
    
    // MARK: URLSessionDataDelegate   URLSessionTaskDelegate
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        muData.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print(error ?? "")
//        self.parseXMLData(muData)
        let dataStr =  String(data: muData, encoding: .utf8)
        if self.completionHander != nil{
            self.completionHander!(nil,muData,nil)
        }
        print(dataStr ?? "")
    }

    
    
}
