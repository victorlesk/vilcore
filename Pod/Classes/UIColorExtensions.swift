//
//  UIColorExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 22/01/2016.
//
//

import UIKit
import Foundation

public extension UIColor{
    public class func colorWithRGB(hexrgb:Int)->UIColor{
        return colorWithRGB(hexrgb,alpha:1.0);

    }
    
    public class func colorWithRGB(hexrgb:Int,alpha:CGFloat)->UIColor{
        let b = CGFloat(hexrgb & 0xFF);
        let g = CGFloat((hexrgb >> 8) & 0xFF);
        let r = CGFloat((hexrgb >> 16) & 0xFF);
        
        return UIColor(red: CGFloat(r/256.0), green: (g/256.0), blue: (b/256.0), alpha: 1.0);
    }
    
    public func hexRGBString()->String{
        let r = Int(round(CGFloat(256.0) * CGColorGetComponents(self.CGColor)[0]));
        let g = Int(round(CGFloat(256.0) * CGColorGetComponents(self.CGColor)[1]));
        let b = Int(round(CGFloat(256.0) * CGColorGetComponents(self.CGColor)[2]));
        
        return String(format:"%02x%02x%02x",r,g,b);
    }
}