//
//  UIViewShapeExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 08/12/2015.
//
//

import Foundation
import UIKit

public extension UIView {
    class func drawThinPlusInRect(rect:CGRect,color:UIColor){
        UIView.drawThinPlusOrMinusInRect(rect, color: color, boolPlus: true);
    }
    
    class func drawThinMinusInRect(rect:CGRect,color:UIColor){
        UIView.drawThinPlusOrMinusInRect(rect, color: color, boolPlus: false);
    }
    
    private class func drawThinPlusOrMinusInRect(rect:CGRect,color:UIColor,boolPlus:Bool){
        let circleDiameterToViewHeightRatio:CGFloat = 0.8;
        let circleCentre:CGPoint = CGPointMake(rect.size.width - (rect.size.height / 2.0),rect.size.height / 2.0);
        
        let circleRadius:CGFloat = (rect.size.height * circleDiameterToViewHeightRatio) / 2.0;
        let barHalfLengthToCircleRadius:CGFloat = 0.6;
        
        guard let cxt:CGContextRef = UIGraphicsGetCurrentContext() else { return; }
        
        //Plus
        CGContextSetRGBStrokeColor(cxt,
        CGColorGetComponents(color.CGColor)[0],
        CGColorGetComponents(color.CGColor)[1],
        CGColorGetComponents(color.CGColor)[2],
        1.0);
        
        CGContextSetLineWidth(cxt,1.0);
        CGContextSetLineCap(cxt, .Square);
        
        CGContextBeginPath         (cxt);
        CGContextMoveToPoint       (cxt, circleCentre.x + barHalfLengthToCircleRadius * circleRadius, circleCentre.y);
        CGContextAddLineToPoint    (cxt, circleCentre.x - barHalfLengthToCircleRadius * circleRadius, circleCentre.y);
        CGContextStrokePath        (cxt);

        if(boolPlus){
            CGContextBeginPath         (cxt);
            CGContextMoveToPoint       (cxt, circleCentre.x , circleCentre.y + barHalfLengthToCircleRadius * circleRadius);
            CGContextAddLineToPoint    (cxt, circleCentre.x , circleCentre.y - barHalfLengthToCircleRadius * circleRadius);
            CGContextStrokePath        (cxt);
        }

        CGContextAddArc(cxt, circleCentre.x, circleCentre.y, circleRadius, 0.0, CGFloat(M_PI) * 2.0, 0);
        CGContextStrokePath(cxt);
    }

}