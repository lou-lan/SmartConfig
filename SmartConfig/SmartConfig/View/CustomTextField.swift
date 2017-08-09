//
//  CustomTextField.swift
//  SmartConfig
//
//  Created by 翟怀楼 on 2017/6/19.
//  Copyright © 2017年 翟怀楼. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    // 设置左边距
    @IBInspectable var leftTextPedding: Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += CGFloat(leftTextPedding)
        return newBounds
    }
    
    override func draw(_ rect: CGRect) {
        let height = self.bounds.height
        
        // get the current drawing context
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineWidth(2.5)
        
        // start a new Path
        context?.beginPath()
        
        context!.move(to: CGPoint(x: self.bounds.origin.x, y: height - 0.5))
        context!.addLine(to: CGPoint(x: self.bounds.size.width, y: height - 0.5))
        // close and stroke (draw) it
        context?.closePath()
        context?.strokePath()
    }
    
    
 

}
