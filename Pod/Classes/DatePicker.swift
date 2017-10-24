//
//  DatePicker.swift
//  Pods-Chemo Diary II
//
//  Created by Victor Lesk on 20/10/2017.
//

import Foundation
import UIKit

public class DatePicker:UIView{
    var boolPickDate = true;
    var boolPickTime = false;
    
    public var delegate:DatePickerDelegate?;
    
    public var originalView:UIView?
    
    public var datePickable = true;
    public var timePickable = false;

    public var currentShownDate:Date = Date();
    public var currentPickedDate:Date = Date();
    public var minimumDate:Date?
    public var maximumDate:Date?

    var mainView:UIView;
    var calendarView:UIView?
    var timeView:UIView?
    
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

    required public init?(coder aDecoder: NSCoder) {
        mainView = UIView(frame:CGRect(x: 0, y: 0, width: 0, height: 0));

        super.init(coder: aDecoder);
        
    }

    override public init(frame: CGRect) {
        mainView = UIView(frame:frame);
        mainView.clipsToBounds = true;

        super.init(frame:frame);
        
        addSubview(mainView);
        
        backgroundColor = UIColor.white.withAlphaComponent(0.7);
        alpha=0.0;
    }

    override public func layoutSubviews() {
        super.layoutSubviews();
        
        mainView.layer.borderColor = darkBackgroundColor.cgColor;
        mainView.layer.borderWidth = 2.0;
        mainView.backgroundColor = lightBackgroundColor;

        for l:InsetLabel! in dateLabels.values {
            l.removeFromSuperview();
        }
        dateLabels.removeAll();

        if(boolPickDate){
            var lastView:UIView?
            
            let newCalendarView = calendarView ?? UIView(frame:mainView.frame);
            monthLabel = monthLabel ?? InsetLabel(frame:mainView.frame)
            monthLeftLabel = monthLeftLabel ?? InsetLabel(frame:mainView.frame)
            monthRightLabel = monthLeftLabel ?? InsetLabel(frame:mainView.frame)
            
            monthLabel?.text = currentShownDate.MMMYYYYString();
            monthLeftLabel?.text = "\u{25C0}";
            monthRightLabel?.text = "\u{25B6}";

            for l in [ monthLabel, monthLeftLabel, monthRightLabel ]{
                l?.font = font;
                l?.textColor = darkTextColor;
                l?.backgroundColor = lightBackgroundColor;
                if(nil != l){newCalendarView.addSubview(l!);}
                
                l?.fillParent();
                l?.sizeToFit();
            }

            monthLabel?.centreHorizontallyAtTopOfParent();
            monthLeftLabel?.alignParentLeftBy(.moving);
            monthRightLabel?.alignParentRightBy(.moving);
            
            for l in [monthLeftLabel, monthRightLabel]{
                l?.isUserInteractionEnabled = true;
                l?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(monthStepperTapHandler(g:))));
            }
            
            mainView.addSubview(newCalendarView);
            calendarView = newCalendarView;
        }else{
            calendarView?.removeFromSuperview();
            calendarView = nil;
        }

        if(boolPickTime){
            var lastView:UIView?
            let newTimeView = timeView ?? UIView(frame:mainView.frame);
            
            mainView.addSubview(newTimeView);
            timeView = newTimeView
        }else{
            timeView?.removeFromSuperview();
            timeView = nil;
        }

        
    }

    public func pickDateTime(){
        boolPickDate = true;
        boolPickTime = true;
        show();
    }

    public func pickDate(){
        boolPickDate = true;
        boolPickTime = false;
        show();
    }

    public func pickTime(){
        boolPickDate = false;
        boolPickTime = true;
        show();
    }
        
    func show(){
        guard let delegate=delegate else {return;}
        self.removeFromSuperview();
        
        let inView = delegate.datePickerContainerView;

        inView.addSubview(self);
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelHandler(g:))));
        mainView.isUserInteractionEnabled = true;
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelHandler(g:))));

        if let originalView = originalView {
            frame = originalView.frame ;
            self.stretchUp(-self.frame.size.height);
            mainView.fillParent();
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.fillParent();
            self.mainView.alignParentTopBy(.moving, margin: 100);
            self.mainView.stretchHorizontallyToFillParentWithMargin(inView.frame.width * 0.08);
            self.mainView.setHeight(200);
            self.alpha = 1.0;
        })
    }
    
    @objc func cancelHandler(g:UIGestureRecognizer){
        NSLog("A");
        if(g.view == self){
            NSLog("B");
            delegate?.datePickerCancelled(datePicker: self);
        }
    }
    
    public func setStyle(font _font:UIFont, darkBackgroundColor _darkBackgroundColor:UIColor, midBackgroundColor _midBackgroundColor:UIColor, lightBackgroundColor _lightBackgroundColor:UIColor, darkTextColor _darkTextColor:UIColor, lightTextColor _lightTextColor:UIColor){
        font = _font;
        darkBackgroundColor = _darkBackgroundColor;
        midBackgroundColor = _midBackgroundColor;
        lightBackgroundColor = _lightBackgroundColor;
        darkTextColor = _darkTextColor;
        lightTextColor = _lightTextColor;
    }
    
    private func monthStepperTapHandler(g:UITapGestureRecognizer){
        if(g.view == self.monthRightLabel){
            currentShownDate = currentShownDate.startOfNextMonth();
        }else if(g.view == self.monthRightLabel){
            currentShownDate = currentShownDate.startOfPreviousMonth();
        }
    }
}
