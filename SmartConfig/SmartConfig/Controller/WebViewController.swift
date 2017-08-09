//
//  ViewController.swift
//  SmartConfig
//
//  Created by 翟怀楼 on 2017/5/14.
//  Copyright © 2017年 翟怀楼. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var htmlFileString:String!

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 进制页面拖动
        webView.scrollView.bounces = false
        
        // 加载HTML
        let path = Bundle.main.path(forResource: htmlFileString, ofType: "html")
        let url = URL(string: path!)
        
        webView.loadRequest(NSURLRequest(url: url!) as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
