//
//  FMYHTTPSessionManager.swift
//  FMYCS
//
//  Created by xw.long on 16/12/22.
//  Copyright © 2016年 fmylove. All rights reserved.
//

import UIKit

enum netMethod {
    case netPost
}

class FMYHTTPSessionManager: FMYURLSessionManager {
    var baseUrl:URL? = nil
    private var requestUrl:URL? = nil

    init(url:URL?, configuration:URLSessionConfiguration?) {
        
        super.init(configuration: configuration)

        if ((url?.path.lengthOfBytes(using: .utf8)) != nil ) {
            self.baseUrl = url

        }else{
            assert(url != nil, "url can't be empty!")
        }
    }


    func net(_ method:String?,parameters:NSDictionary?,
             success:((URLSessionDataTask?,Any) ->Void)?,
             failure:((URLSessionDataTask?,Error) ->Void)?) -> URLSessionDataTask {
        
        let request:URLRequest = self.request(method, urlString: self.baseUrl?.absoluteString, parameters: parameters, error: nil)


        let dataTask = self.dataTask(request: request, completionHander: { (response, object, error) in
            print("request.URL:",self.requestUrl?.absoluteString ?? "")
            print("response\(response), object\(object), error\(error)")
            
            if error == nil {
                if success != nil{
                    success!(nil,object)
                }
            }else{
                if failure != nil{
                    failure!(nil, error!)
                }
            }
        })
        dataTask.resume()
        
        return dataTask
    }

    
    func request(_ method:String?,urlString:String?,parameters:NSDictionary?,error:Error?) ->URLRequest {
        assert(urlString?.isEmpty == false, "Invalid parameter not satisfying:"+urlString!)
        
        let paramSuffix:String = (parameters != nil) ? self.urlSuffixParams(parameters!) : ""
        
        let url = URL(string: urlString!+"?"+paramSuffix)
        var request = URLRequest(url: url!)
        self.requestUrl = url!

        request.httpMethod  = method

//        let soap12   = self.postBody()

//        let soapData = soap12.data(using: .utf8)

//        request.httpBody    = soapData
//        request.setValue(String(format: "%d", (soap12 as NSString).length), forHTTPHeaderField:"Content-Length")
////        request.setValue("text/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")

        // TODO: 处理参数
        return request
    }

    func urlSuffixParams(_ paramDict:NSDictionary) -> String {
        var paramSuffix = ""
        if  (paramDict.allKeys.count > 0){
            let allKeys:Array      = paramDict.allKeys
            let valueArr:NSMutableArray = []
            
            for key in allKeys {
                let value = paramDict.object(forKey: key)
                if value != nil {
                    valueArr.add((key as! String)+"="+(value as! String))
                }
            }
            paramSuffix =  valueArr.componentsJoined(by: "&")
        }
        return paramSuffix
    }
    
    func postBody() -> String {
        var  soap12 = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><getSupportCity xmlns=\"http://WebXml.com.cn/\"><byProvinceName>贵州</byProvinceName></getSupportCity></soap:Body></soap:Envelope>"

        soap12 = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><getWeatherbyCityName xmlns=\"http://WebXml.com.cn/\"><theCityName>石家庄</theCityName></getWeatherbyCityName></soap:Body></soap:Envelope>"

        return soap12
    }
    


}
