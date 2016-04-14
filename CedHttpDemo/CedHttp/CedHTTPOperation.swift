//
//  CedHTTPOperation.swift
//  CedHttpDemo
//
//  Created by Cedric Wu on 4/11/16.
//  Copyright © 2016 Cedric Wu. All rights reserved.
//

import Foundation

class CedHTTPOperation {
    class func escape(string: String) -> String {
        return (string as NSString).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        // let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        // return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
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
            return "\(self.escape(pair.0))=\(self.escape(pair.1 as! String))"
        case is Array<String>:
            var tempArray = [String]()
            for value in(pair.1 as! Array<String>) {
                tempArray.append("\(self.escape(pair.0))=\(self.escape(value))")
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
}