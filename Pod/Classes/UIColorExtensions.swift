//
//  UIColorExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 22/01/2016.
//
//

import UIKit

public extension UIColor{
    public class func colorWithRGB(hexrgb:Int)->UIColor{
        return colorWithRGB(hexrgb,alpha:1.0);

    }
    
    public class func colorWithRGB(hexrgb:Int,alpha:CGFloat)->UIColor{
        let b = CGFloat(hexrgb & 0xFF);
        let g = CGFloat((hexrgb >> 8) & 0xFF);
        let r = CGFloat((hexrgb >> 16) & 0xFF);
        
        return UIColor(red: CGFloat(r/255.0), green: (g/255.0), blue: (b/255.0), alpha: 1.0);
        
        
    }
}
