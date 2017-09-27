//
//  PageViewController.swift
//  SmartConfig
//
//  Created by 翟怀楼 on 2017/6/9.
//  Copyright © 2017年 翟怀楼. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles:NSArray!
    var pageImaages:NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let espTitle = "ESP-07 08 12E " + NSLocalizedString("MINIMAL_SYSTEMS", comment: "")
        
        self.pageTitles = NSArray(objects: "ESP8266 NodeMCU", "ESP32S NodeMCU", espTitle)
        self.pageImaages = NSArray(objects: "NodeMCU", "NodeMCU32S", "ESP8266")
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController")  as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 80)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController {
        
        if (self.pageTitles.count == 0 || index >= self.pageTitles.count)
        {
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        vc.imageFile = self.pageImaages[index] as! String
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
        return vc
        
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index = index - 1
        return self.viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index = index + 1
        
        if index == self.pageTitles.count
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
