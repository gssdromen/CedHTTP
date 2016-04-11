//
//  CedHttp.swift
//  CedHttpDemo
//
//  Created by Cedric Wu on 16/4/11.
//  Copyright © 2016年 Cedric Wu. All rights reserved.
//

import Foundation

class CedHTTP {
    class func makeAsync(url: String, method: CedHTTPMethod, response: CedHTTPResponse) {
    }

    class func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }

    class func buildRequestParams(parameters: [String: AnyObject]) -> String {
        var tempArray = [String]()
        for pair in parameters {
            tempArray.append(self.buildParamsHelper(pair))
        }
        return tempArray.joinWithSeparator("&")
    }

    class func buildParamsHelper(pair: (String, AnyObject)) -> String {
        switch pair.1 {
        case is String:
            return "\(pair.0)=\(pair.1)"
        case is Array<String>:
            var tempArray = [String]()
            for value in(pair.1 as! Array<String>) {
                tempArray.append("\(pair.0)=\(value)")
            }
            return tempArray.joinWithSeparator("&")
        case is Dictionary<String, AnyObject>:
            var tempDict = Dictionary<String, AnyObject>()
            for dict in pair.1 as! Dictionary<String, AnyObject> {
                tempDict[pair.0 + "[\(dict.0)]"] = dict.1
            }
            return self.buildRequestParams(tempDict)
        default:
            print("building params error")
            return ""
        }
    }

//    class func buildParams(parameters: [String: AnyObject]) -> String {
//        var components: [(String, String)] = []
//        for key in Array(parameters.keys).sort() {
//            let value: AnyObject! = parameters[key]
//            components += self.queryComponents(key, value)
//        }
//
//        return (components.map { "\($0)=\($1)" } as [String]).joinWithSeparator("&")
//    }
//
//    class func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
//        var components: [(String, String)] = []
//        if let dictionary = value as? [String: AnyObject] {
//            for (nestedKey, value) in dictionary {
//                components += queryComponents("(key)[(nestedKey)]", value)
//            }
//        } else if let array = value as? [AnyObject] {
//            for value in array {
//                components += queryComponents("(key)", value)
//            }
//        } else {
//            components.appendContentsOf([(escape(key), escape("(value)"))])
//        }
//
//        return components
//    }
}