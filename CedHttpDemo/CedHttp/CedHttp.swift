//
//  CedHttp.swift
//  CedHttpDemo
//
//  Created by Cedric Wu on 16/4/11.
//  Copyright © 2016年 Cedric Wu. All rights reserved.
//

import Foundation

class CedHTTP {
    class func makeAsync(url: String, method: CedHTTPMethod, params: Dictionary<String, AnyObject>?, response: CedHTTPResponse?) {
        guard url != "" else {
            print("No Request Url")
            return
        }
        var request = NSMutableURLRequest(url: URL(string: url)!)

        switch method {
        case .Get:
            request.httpMethod = "GET"
            if params != nil {
                let getUrl = url + "?" + CedHTTPOperation.buildRequestParams(parameters: params!)
                request = NSMutableURLRequest(url: URL(string: getUrl)!)
            }
            break
        case .Post:
            request.httpMethod = "POST"
            if params != nil {
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpBody = CedHTTPOperation.buildRequestParams(parameters: params!).data(using: String.Encoding.utf8)
            }
            break
        case .Put:
            request.httpMethod = "PUT"
            break
        case .Delete:
            request.httpMethod = "DELETE"
            break
        }
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(response)
            } else {
                if (response as! HTTPURLResponse).statusCode == 200 {
                    print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
                } else {
                    print(response)
                }
            }
        }.resume()
    }

    class func makeSync(url: String, method: CedHTTPMethod, params: Dictionary<String, AnyObject>, response: CedHTTPResponse) {
    }
}
