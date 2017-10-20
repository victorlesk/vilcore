//
//  DatePicker.swift
//  Pods-Chemo Diary II
//
//  Created by Victor Lesk on 20/10/2017.
//

import Foundation
import UIKit

public class DatePicker:UIView{
    public var datePickable = true;
    public var timePickable = false;
    
    public var minimumDate:Date?
    public var maximumDate:Date?

    var monthLabel:InsetLabel?;
    var monthLeftLabel:InsetLabel?;
    var monthRightLabel:InsetLabel?;
    var dateLabels = [String:InsetLabel]();
    
    var hourTextField:LineTextField?;
    var minuteTextField:LineTextField?;

    var doneLabel:InsetLabel?;
    
    public var font:UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize);
    public var darkBackgroundColor = UIColor.black;
    public var midBackgroundColor = UIColor.lightGray;
    public var lightBackgroundColor = UIColor.white;
    public var darkTextColor = UIColor.black;
    public var lightTextColor = UIColor.white;
    
    public weak var originalView:UIView?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    override init(frame: CGRect) {
        super.init(frame:frame);
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews();
        
        for l:InsetLabel! in dateLabels.values {
            l.removeFromSuperview();
        }
        dateLabels.removeAll();
    }
}
