
//
//  UIColor+Helper.swift
//  SwiftTemplet
//
//  Created by hsf on 2018/8/24.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension UIColor{
    
    //MARK: - -属性
    static var random : UIColor {
        get{
            return UIColor.randomColor();
        }
    }
    
    static var theme : UIColor {
        get{
            var color = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIColor;
            color = color ?? UIColor.orange
            return color!;
        }
        set{
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        }
    }
    
    /// 新增A4x Hex字符串 -> UIColor
    static func a4xColorWithHex(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
                 
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
                 
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
                 
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
                 
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
                 
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
        
    //MARK: - -方法
    static func hex(_ rgbValue: Int , alpha : Float = 1.0) -> UIColor {
        
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                       alpha: CGFloat(alpha))
        
        
    }
    
    static func randomColor() -> UIColor {
        let r = arc4random_uniform(256);
        let g = arc4random_uniform(256);
        let b = arc4random_uniform(256);
        return UIColor(red:CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1.0));
    }
    
}

