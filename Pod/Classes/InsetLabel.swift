//
//  InsetLabel.swift
//  Pods
//
//  Created by Victor Lesk on 12/05/2017.
//
//

import UIKit

open class InsetLabel: UILabel {

    var topInset:    CGFloat = 0.0;
    var bottomInset: CGFloat = 0.0;
    var leftInset:   CGFloat = 0.0;
    var rightInset : CGFloat = 0.0;
    
    public var touchDownColor: UIColor = UIColor.white;
    public var savedBackgroundColor: UIColor = UIColor.white;

    public func setInsets(_ _inset:CGFloat){
        topInset = _inset;
        bottomInset = _inset;
        leftInset = _inset;
        rightInset = _inset;
    }
    
    override open func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in:(UIEdgeInsetsInsetRect(rect, insets)));
    }
    
    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset));
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -topInset,
                                          left: -leftInset,
                                          bottom: -bottomInset,
                                          right: -rightInset);
        return UIEdgeInsetsInsetRect(textRect, invertedInsets);
    }
    
    override open var intrinsicContentSize:CGSize {
        get{
            var intrinsicSuperViewContentSize = super.intrinsicContentSize;

            let textWidth = frame.size.width - (self.leftInset + self.rightInset)
            let newSize = self.text!.boundingRect(with:CGSize(width:textWidth, height:CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: nil);
            intrinsicSuperViewContentSize.height = ceil(newSize.size.height) + self.topInset + self.bottomInset
            
            return intrinsicSuperViewContentSize;
        }
    }
    
    
    public func setPadding(left:CGFloat, top:CGFloat, right:CGFloat, bottom :CGFloat){
        topInset = top;
        bottomInset = bottom;
        leftInset = left;
        rightInset = right;
        
        invalidateIntrinsicContentSize();
    }
    
    public func setPadding(_ p:CGFloat){
        setPadding(left:p,top:p,right:p,bottom:p);
    }
    
    public func setVerticalPadding(p:CGFloat){
        setPadding(left:leftInset,top:p,right:rightInset,bottom:p);
    }

    public func setHorizontalPadding(p:CGFloat){
        setPadding(left:p,top:topInset,right:p,bottom:bottomInset);
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        savedBackgroundColor = backgroundColor ?? UIColor.white;
        backgroundColor = touchDownColor;
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = savedBackgroundColor;
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = savedBackgroundColor;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
