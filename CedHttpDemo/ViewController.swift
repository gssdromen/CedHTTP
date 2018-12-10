//
//  ViewController.swift
//  CedHttpDemo
//
//  Created by Cedric Wu on 16/4/11.
//  Copyright © 2016年 Cedric Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var di: Dictionary = Dictionary<String, Any>()
        di["1"] = "2"
        di["3"] = "4"

        var did: Dictionary = Dictionary<String, Any>()
        did["a"] = "b"
        did["c"] = "d"
        did["di"] = di

        let aa: Array = ["1", "2", "3"]

        var did2: Dictionary = Dictionary<String, Any>()
        did2["e"] = "f"
        did2["g"] = "h"
        did2["aa"] = aa

        print(CedHTTPOperation.buildRequestParams(parameters: did2))

        print(CedHTTP.makeAsync(url: "http://www.baidu.com", method: CedHTTPMethod.Get, params: nil, response: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
