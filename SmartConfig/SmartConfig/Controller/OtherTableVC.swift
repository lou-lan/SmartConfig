//
//  OtherTableVC.swift
//  SmartConfig
//
//  Created by 翟怀楼 on 2017/6/13.
//  Copyright © 2017年 翟怀楼. All rights reserved.
//

import UIKit

class OtherTableVC: UITableViewController {
    
    let htmlFileStrings = ["HTML/SmartConfig", "HTML/OpenSource", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return 2
        }
        
        if section == 1
        {
            return 1
        }
        
        return 0

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == [0, 0]
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.htmlFileString = htmlFileStrings[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath == [0, 1]
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            vc.htmlFileString = htmlFileStrings[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}
