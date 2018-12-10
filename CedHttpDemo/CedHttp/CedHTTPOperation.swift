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
        return (string as NSString).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        // let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        // return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }

    class func buildRequestParams(parameters: [String: Any]) -> String {
        var tempArray = [String]()
        for pair in parameters {
            tempArray.append(self.buildParamsHelper(pair: pair as! (String, AnyObject)))
        }
        
        return tempArray.joined(separator: ("&"))
    }

    private class func buildParamsHelper(pair: (String, AnyObject)) -> String {
        switch pair.1 {
        case is String:
            return "\(self.escape(string: pair.0))=\(self.escape(string: pair.1 as! String))"
        case is Array<String>:
            var tempArray = [String]()
            for value in(pair.1 as! Array<String>) {
                tempArray.append("\(self.escape(string: pair.0))[]=\(self.escape(string: value))")
            }
            return tempArray.joined(separator: ("&"))
        case is Dictionary<String, AnyObject>:
            var tempDict = Dictionary<String, AnyObject>()
            for dict in pair.1 as! Dictionary<String, AnyObject> {
                tempDict[pair.0 + "[\(dict.0)]"] = dict.1
            }
            return self.buildRequestParams(parameters: tempDict)
        default:
            print("building params error")
            return ""
        }
    }
}
