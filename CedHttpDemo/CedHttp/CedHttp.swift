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
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)

        switch method {
        case .Get:
            request.HTTPMethod = "GET"
            if params != nil {
                let getUrl = url + "?" + CedHTTPOperation.buildRequestParams(params!)
                request = NSMutableURLRequest(URL: NSURL(string: getUrl)!)
            }
            break
        case .Post:
            request.HTTPMethod = "POST"
            if params != nil {
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.HTTPBody = CedHTTPOperation.buildRequestParams(params!).dataUsingEncoding(NSUTF8StringEncoding)
            }
            break
        case .Put:
            request.HTTPMethod = "PUT"
            break
        case .Delete:
            request.HTTPMethod = "DELETE"
            break
        }

        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if error != nil {
                print(response)
            } else {
                if (response as! NSHTTPURLResponse).statusCode == 200 {
                    print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                } else {
                    print(response)
                }
            }
        }.resume()
    }

    class func makeSync(url: String, method: CedHTTPMethod, params: Dictionary<String, AnyObject>, response: CedHTTPResponse) {
    }
}