//
//  LineTextField.swift
//  Pods
//
//  Created by Victor Lesk on 30/05/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import UIKit

public class LineTextField: UITextField {

    @objc public var lineColor:UIColor = UIColor.black;
    @objc public var lineHeight:CGFloat = 2.0;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        super.draw(rect);

        guard let context = UIGraphicsGetCurrentContext() else { return; }

        context.setFillColor(lineColor.cgColor);
        context.beginPath();
        context.addLines(between:[CGPoint(x: 0, y: rect.height),CGPoint(x: rect.width, y: rect.height),CGPoint(x: rect.width, y: rect.height - lineHeight),CGPoint(x:0,y:rect.height - lineHeight)]);
        context.closePath();
        context.fillPath(using: CGPathFillRule.evenOdd);
    }

}
