//
//  InsetLabel.swift
//  Pods
//
//  Created by Victor Lesk on 12/05/2017.
//
//

import UIKit

open class InsetLabel: UILabel {

    @objc var topInset:    CGFloat = 0.0;
    @objc var bottomInset: CGFloat = 0.0;
    @objc var leftInset:   CGFloat = 0.0;
    @objc var rightInset : CGFloat = 0.0;
    
    @objc public var touchDownColor: UIColor = UIColor.white;
    @objc public var savedBackgroundColor: UIColor = UIColor.white;

    @objc public func setInsets(_ _inset:CGFloat){
        topInset = _inset;
        bottomInset = _inset;
        leftInset = _inset;
        rightInset = _inset;
    }
    
    override open func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in:(rect.inset(by: insets)));
    }
    
    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset));
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -topInset,
                                          left: -leftInset,
                                          bottom: -bottomInset,
                                          right: -rightInset);
        return textRect.inset(by: invertedInsets);
    }
    
    override open var intrinsicContentSize:CGSize {
        get{
            var intrinsicSuperViewContentSize = super.intrinsicContentSize;

            let textWidth = frame.size.width - (self.leftInset + self.rightInset)
            //let newSize = self.text!.boundingRect(with:CGSize(width:textWidth, height:CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: self.font], context: nil);
            let newSize = self.text!.boundingRect(with:CGSize(width:textWidth, height:CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): self.font]), context: nil);
            intrinsicSuperViewContentSize.height = ceil(newSize.size.height) + self.topInset + self.bottomInset
            
            return intrinsicSuperViewContentSize;
        }
    }
    
    
    @objc public func setPadding(left:CGFloat, top:CGFloat, right:CGFloat, bottom :CGFloat){
        topInset = top;
        bottomInset = bottom;
        leftInset = left;
        rightInset = right;
        
        invalidateIntrinsicContentSize();
    }
    
    @objc public func setPadding(_ p:CGFloat){
        setPadding(left:p,top:p,right:p,bottom:p);
    }
    
    @objc public func setVerticalPadding(p:CGFloat){
        setPadding(left:leftInset,top:p,right:rightInset,bottom:p);
    }

    @objc public func setHorizontalPadding(p:CGFloat){
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
