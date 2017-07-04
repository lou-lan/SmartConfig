//
//  SystemButton.swift
//  demo2
//
//  Created by 翟怀楼 on 2017/6/16.
//  Copyright © 2017年 翟怀楼. All rights reserved.
//

import UIKit

@IBDesignable
class SystemButton: UIButton {
    
    /* 当 storyboards 对象创建时回调 */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    /* 当程序初始化的时候回调 */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    /* 调整视图的 frame */
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    // 当 @IBDesignable 请求做出改变/* */
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupViews()
    }
    
    /* 自己的设置 */
    func setupViews() {
        layer.cornerRadius = 8
        tintColor = UIColor.white
//        backgroundColor = #colorLiteral(red: 0, green: 0.6274509804, blue: 0.9137254902, alpha: 1)
        bounds.size = CGSize(width: 290, height: 50)
    }
    
}

