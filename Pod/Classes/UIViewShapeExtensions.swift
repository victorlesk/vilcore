//
//  UIViewShapeExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 08/12/2015.
//
//

import Foundation
import UIKit


public enum Shape{
    case square;
    case circle;
    case rectangle;
    case octagon;
    case hexagon;
    case diamond;
}

public extension UIView {
    @objc class func drawThinPlusInRect(_ rect:CGRect,color:UIColor){
        UIView.drawThinPlusOrMinusInRect(rect, color: color, boolPlus: true);
    }
    
    @objc class func drawThinMinusInRect(_ rect:CGRect,color:UIColor){
        UIView.drawThinPlusOrMinusInRect(rect, color: color, boolPlus: false);
    }
    
    fileprivate class func drawThinPlusOrMinusInRect(_ rect:CGRect,color:UIColor,boolPlus:Bool){
        let circleDiameterToViewHeightRatio:CGFloat = 0.8;
        let circleCentre:CGPoint = CGPoint(x: rect.size.width - (rect.size.height / 2.0),y: rect.size.height / 2.0);
        
        let circleRadius:CGFloat = (rect.size.height * circleDiameterToViewHeightRatio) / 2.0;
        let barHalfLengthToCircleRadius:CGFloat = 0.6;
        
        guard let cxt:CGContext = UIGraphicsGetCurrentContext() else { return; }
        
        //Plus
        cxt.setStrokeColor(red: (color.cgColor.components?[0])!,
        green: (color.cgColor.components?[1])!,
        blue: (color.cgColor.components?[2])!,
        alpha: 1.0);
        
        cxt.setLineWidth(1.0);
        cxt.setLineCap(.square);
        
        cxt.beginPath         ();
        cxt.move       (to: CGPoint(x: circleCentre.x + barHalfLengthToCircleRadius * circleRadius, y: circleCentre.y));
        cxt.addLine    (to: CGPoint(x: circleCentre.x - barHalfLengthToCircleRadius * circleRadius, y: circleCentre.y));
        cxt.strokePath        ();

        if(boolPlus){
            cxt.beginPath         ();
            cxt.move       (to: CGPoint(x: circleCentre.x, y: circleCentre.y + barHalfLengthToCircleRadius * circleRadius));
            cxt.addLine    (to: CGPoint(x: circleCentre.x, y: circleCentre.y - barHalfLengthToCircleRadius * circleRadius));
            cxt.strokePath        ();
        }

        cxt.addArc(center: circleCentre, radius: circleRadius, startAngle: 0.0, endAngle: CGFloat(Double.pi), clockwise: true);
        cxt.strokePath();
    }

}
