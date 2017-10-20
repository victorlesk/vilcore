//
//  DatePicker.swift
//  Pods-Chemo Diary II
//
//  Created by Victor Lesk on 20/10/2017.
//

import Foundation
import UIKit

class DatePicker:UIView{
    var datePickable = true;
    var timePickable = false;
    
    var minimumDate:NSDate?
    var maximumDate:NSDate?

    var monthLabel:InsetLabel?;
    var monthLeftLabel:InsetLabel?;
    var monthRightLabel:InsetLabel?;
    var dateLabels = [String:InsetLabel]();
    
    var hourTextField:LineTextField?;
    var minuteTextField:LineTextField?;

    var doneLabel:InsetLabel?;
    
    var font:UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize);
    var darkBackgroundColor = UIColor.black;
    var midBackgroundColor = UIColor.lightGray;
    var lightBackgroundColor = UIColor.white;
    var darkTextColor = UIColor.black;
    var lightTextColor = UIColor.white;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    override init(frame: CGRect) {
        super.init(frame:frame);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        for l:InsetLabel! in dateLabels.values {
            l.removeFromSuperview();
        }
        dateLabels.removeAll();
    }
}
