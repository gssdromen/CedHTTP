//
//  CedHttpStruct.swift
//  CedHttpDemo
//
//  Created by Cedric Wu on 16/4/11.
//  Copyright © 2016年 Cedric Wu. All rights reserved.
//

import Foundation

struct CedHTTPResponse {
    var statusCode: NSInteger
    var error: NSError
}

struct CedHTTPRequest {
}

enum CedHTTPMethod {
    case Get
    case Post
    case Put
    case Delete
}
