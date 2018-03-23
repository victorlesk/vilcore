//
//  DatePicker.swift
//  Pods-Chemo Diary II
//
//  Created by Victor Lesk on 20/10/2017.
//

import Foundation
import UIKit

public class DatePicker:UIView{
    var boolPickYear = true;
    var boolPickDate = true;
    var boolPickTime = false;
    
    var boolHasDoneButton = true;
    
    public var delegate:DatePickerDelegate?;
    
    public var originalView:UIView?{
        didSet{
            if let date = (originalView as? UITextField)?.text?.DDMMYYYYDate(){
                currentPickedDate = date;
                currentShownDate = date.startOfCurrentMonth();
                setNeedsLayout();
            }else if let date = (originalView as? UITextField)?.text?.DDMMMYYYYDate(){
                currentPickedDate = date;
                currentShownDate = date.startOfCurrentMonth();
                setNeedsLayout();
            }else if let dateString = (originalView as? UITextField)?.text, let date = "\(dateString) \(Date().components(.year).year!)".DDMMMYYYYDate(){
                currentPickedDate = date;
                currentShownDate = date.startOfCurrentMonth();
                setNeedsLayout();
            }else if let date = delegate?.defaultDateForDatePicker(datePicker:self){
                currentPickedDate = date;
                currentShownDate = date.startOfCurrentMonth();
                setNeedsLayout();
            }
        }
    }
    
    public var datePickable = true;
    public var timePickable = false;

    public var currentShownDate:Date = Date().startOfCurrentMonth();
    public var currentPickedDate:Date?;
    public var minimumDate:Date?
    public var maximumDate:Date?

    public var mainView:UIView;
    var calendarView:UIView?
    var timeView:UIView?

    public var minYear = 1910;
    public var maxYear:Int = Date().components(.year).year!;
    var yearScrollView:UIScrollView?
    var yearLabels = [Int:InsetLabel]();
    
    var monthLabel:InsetLabel?;
    var monthLeftLabel:InsetLabel?;
    var monthRightLabel:InsetLabel?;
    var dateLabels = [String:InsetLabel]();
    
    var hourTextField:LineTextField?;
    var minuteTextField:LineTextField?;

    var doneButton:UIButton?;
    
    public var font:UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize);
    public var boldFont:UIFont = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize);
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

        var lastSectionView:UIView?
        
        if(boolPickDate){
            var lastView:UIView?

            if(boolPickYear){
                let newYearScrollView = yearScrollView ?? UIScrollView(frame:mainView.frame);
                newYearScrollView.backgroundColor = UIColor.white.withAlphaComponent(1.0);
                newYearScrollView.showsVerticalScrollIndicator = false;
                
                for (_,yearLabel) in yearLabels{
                    yearLabel.removeFromSuperview();
                }
                yearLabels.removeAll();

                maxYear   = Date().components(.year).year! + 2;
                let shownYear = currentShownDate.components(.year).year!;
                var shownYearLabel:InsetLabel?;
                
                var lastYearLabel:InsetLabel?
                
                for year in minYear...maxYear{
                    let yearLabel = InsetLabel(frame:newYearScrollView.frame);
                    yearLabel.text = "\(year)";
                    if(shownYear == year){
                        yearLabel.backgroundColor = midBackgroundColor.withAlphaComponent(1.0);
                        shownYearLabel = yearLabel;
                        yearLabel.font = boldFont;
                    }else{
                        yearLabel.font = font;
                        yearLabel.backgroundColor = lightBackgroundColor.withAlphaComponent(1.0);
                    }
                    yearLabel.topInset    = 4;
                    yearLabel.bottomInset = 4;
                    yearLabel.leftInset   = 4;
                    yearLabel.rightInset  = 4;
                    yearLabel.textAlignment = .center;
                    yearLabel.textColor = darkTextColor;
                    yearLabel.sizeToFit();
                    yearLabel.widenSymmetricallyFactor(1.1);
                    yearLabel.expandSymmetricallyFactor(1.3);
                    
                    yearLabel.isUserInteractionEnabled = true;
                    yearLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(yearLabelTapHandler(g:))));
                    
                    newYearScrollView.addSubview(yearLabel);

                    yearLabel.alignParentTopBy(.moving);
                    
                    if let lastYearLabel = lastYearLabel {
                        yearLabel.moveToRightOf(lastYearLabel,margin:-2);
                    }else{
                        yearLabel.alignParentLeftBy(.moving);
                    }
                    
                    yearLabels[year] = yearLabel;
                    
                    lastYearLabel = yearLabel;
                }

                newYearScrollView.contentSize = CGSize(width:lastYearLabel!.frame.maxX,height:lastYearLabel!.frame.height);

                if let shownYearLabel = shownYearLabel{
                    newYearScrollView.setContentOffset(CGPoint(x:shownYearLabel.frame.midX - (newYearScrollView.frame.width / 2.0),y:0), animated:true);
                }
                
                newYearScrollView.setHeightOf(lastYearLabel!);
                
                lastSectionView = newYearScrollView;
                yearScrollView = newYearScrollView;
                mainView.addSubview(newYearScrollView);
                newYearScrollView.centreHorizontallyAtTopOfParent();
            }
            
            let newCalendarView = calendarView ?? UIView(frame:mainView.frame);
            monthLabel = monthLabel ?? InsetLabel(frame:mainView.frame)
            monthLeftLabel = monthLeftLabel ?? InsetLabel(frame:mainView.frame)
            monthRightLabel = monthRightLabel ?? InsetLabel(frame:mainView.frame)
            
            monthLabel?.text = currentShownDate.MMMMYYYYString();
            monthLabel?.topInset = 4;
            monthLabel?.bottomInset = 4;
            monthLabel?.leftInset = 4;
            monthLabel?.rightInset = 4;
            monthLeftLabel?.text = "\u{25C0}";
            monthRightLabel?.text = "\u{25B6}";
            monthLabel?.font = font;

            for l in [monthLeftLabel, monthRightLabel]{
                l?.topInset = 8;
                l?.bottomInset = 8;
                l?.leftInset = 8;
                l?.rightInset = 8;
                l?.font = UIFont.boldSystemFont(ofSize: 24);
            }
            
            for l in [ monthLabel, monthLeftLabel, monthRightLabel ]{
                l?.textColor = darkTextColor;
                l?.backgroundColor = lightBackgroundColor;
                if(nil != l){newCalendarView.addSubview(l!);}
                
                l?.fillParent();
                l?.sizeToFit();
            }

            monthLeftLabel?.alignParentTopLeftBy(.moving);
            monthRightLabel?.alignParentTopRightBy(.moving);
            monthLabel?.centreHorizontallyAtTopOfParent();
            monthLabel?.centreVerticallyIn(monthLeftLabel!);

            for l in [monthLeftLabel, monthRightLabel]{
                l?.isUserInteractionEnabled = true;
                l?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(monthStepperHandler(g:))));
            }
            
            for d in [UISwipeGestureRecognizerDirection.left,UISwipeGestureRecognizerDirection.right]{
                let g = UISwipeGestureRecognizer(target: self, action: #selector(monthStepperHandler(g:)));
                g.direction = d;
                newCalendarView.addGestureRecognizer(g);
            }


            lastView = monthRightLabel;

            var loopDate = currentShownDate.mostRecentSunday();

            let viewWidth = newCalendarView.frame.width/7.0;

            var boolInMonth = false;
            let startOfNextMonth = currentShownDate.startOfNextMonth();
            
            for dayIndex in 0...34{
                if(loopDate.isSameDayAs(currentShownDate)){boolInMonth = true;}
                else if(loopDate.isSameDayAs(startOfNextMonth)){boolInMonth = false;}
                
                let dayOfWeek = dayIndex % 7;
                //let weekOfCalendar = dayIndex / 7;
                
                let newLabel = InsetLabel(frame:newCalendarView.frame);
                newLabel.font = (boolInMonth ? boldFont :font) ;
                newLabel.alpha = (boolInMonth ? 1.0 : 0.6);
                newLabel.topInset = 4;
                newLabel.bottomInset = 4;
                newLabel.leftInset = 4;
                newLabel.rightInset = 4;

                if(loopDate.isSameDayAs(currentPickedDate)){
                    newLabel.textColor = lightTextColor;
                    newLabel.backgroundColor = darkBackgroundColor;
                }else{
                    newLabel.textColor = darkTextColor;
                    newLabel.backgroundColor = (dayOfWeek == 0 || dayOfWeek == 6 ? midBackgroundColor : lightBackgroundColor);
                }
                
                newLabel.text = "\(gregorianCalendar.component(Calendar.Component.day, from: loopDate))";
                newLabel.textAlignment = .center;
                newLabel.sizeToFit();
                newLabel.setWidth(viewWidth);
                newLabel.isUserInteractionEnabled = true;
                dateLabels[loopDate.DDMMYYYYString()] = newLabel;
                newCalendarView.addSubview(newLabel);
                newLabel.addGestureRecognizer(UITapGestureRecognizer(target:self,action:#selector(dateTapHandler(g:))));

                newLabel.moveToBelow(lastView!);
                
                newLabel.alignParentLeftBy(.moving, margin:viewWidth * CGFloat(dayOfWeek));
                
                if(dayOfWeek == 6) { lastView = newLabel; }
                
                loopDate = loopDate.nextDay();
            }

            newCalendarView.hugChildrenVertically();
            
            mainView.addSubview(newCalendarView);
            calendarView = newCalendarView;
            calendarView?.centreHorizontallyAtTopOfParent();
            if (nil != lastSectionView) { calendarView?.moveToBelow(lastSectionView!);}
            lastSectionView = calendarView;
        }else{
            yearScrollView?.removeFromSuperview();
            yearScrollView = nil;
            calendarView?.removeFromSuperview();
            calendarView = nil;
        }

        if(boolPickTime){
            var lastView:UIView?
            let newTimeView = timeView ?? UIView(frame:mainView.frame);
            
            mainView.addSubview(newTimeView);
            timeView = newTimeView;

            lastSectionView = timeView;
        }else{
            timeView?.removeFromSuperview();
            timeView = nil;
        }

        if(boolPickTime || boolHasDoneButton){
            if(nil == doneButton){
                doneButton = UIButton(frame: mainView.frame);
                mainView.addSubview(doneButton!);
                doneButton?.setTitle(NSLocalizedString("Done",comment:""), for: .normal);
                doneButton?.titleLabel?.font = boldFont;
                doneButton?.setTitleColor(darkTextColor, for: .normal);
                doneButton?.setTitleColor(midBackgroundColor, for: .disabled);
                doneButton?.setTitleColor(midBackgroundColor, for: .highlighted);
                doneButton?.setTitleColor(midBackgroundColor, for: .selected);
                doneButton?.sizeToFit();
                doneButton?.setWidthOf(monthLabel!);
                doneButton?.setHeightOf(monthLeftLabel!);
                doneButton?.centreHorizontallyInParent();
                doneButton?.addTarget(self, action: #selector(doneTapHandler(sender:)), for: .touchUpInside);
            }
            
            doneButton?.moveToBelow(lastSectionView!);
            doneButton?.isEnabled = (nil != currentPickedDate);
        }else{
            doneButton?.removeFromSuperview();
            doneButton = nil;
        }

        mainView.hugChildrenVertically();
        
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
        if(g.view == self){
            delegate?.datePickerCancelled(datePicker: self);
        }
    }
    
    public func setStyle(font _font:UIFont,boldFont _boldFont:UIFont, darkBackgroundColor _darkBackgroundColor:UIColor, midBackgroundColor _midBackgroundColor:UIColor, lightBackgroundColor _lightBackgroundColor:UIColor, darkTextColor _darkTextColor:UIColor, lightTextColor _lightTextColor:UIColor,hasDoneButton _boolHasDoneButton:Bool){
        font = _font;
        boldFont = _boldFont;
        darkBackgroundColor = _darkBackgroundColor;
        midBackgroundColor = _midBackgroundColor;
        lightBackgroundColor = _lightBackgroundColor;
        darkTextColor = _darkTextColor;
        lightTextColor = _lightTextColor;
        boolHasDoneButton = _boolHasDoneButton;
    }
    
    @objc private func monthStepperHandler(g:UITapGestureRecognizer){
        if(g.view == self.monthRightLabel){
            currentShownDate = currentShownDate.startOfNextMonth();
            self.setNeedsLayout();
        }else if(g.view == self.monthLeftLabel){
            currentShownDate = currentShownDate.startOfPreviousMonth();
            self.setNeedsLayout();
        }
    }

    @objc private func yearLabelTapHandler(g:UITapGestureRecognizer){
        guard let v = g.view else {return;}
        for (year,yearView) in yearLabels{
            if(yearView == v){
                currentShownDate = String("\(currentShownDate.DDMMString())/\(year)").DDMMYYYYDate()!;
                self.setNeedsLayout();
                return;
            }
        }
    }
    
    @objc private func dateTapHandler(g:UITapGestureRecognizer){
        guard let v = g.view else {return;}
        for (dateString,dateView) in dateLabels{
            if(dateView == v){
                currentPickedDate = dateString.DDMMYYYYDate()!;
                currentShownDate = currentPickedDate!.startOfCurrentMonth();

                self.setNeedsLayout();
                
                if(nil == doneButton){
                    delegate?.datePicker(datePicker: self, didReturnDate: currentPickedDate!);
                }
                return;
            }
        }
    }
    
    @objc private func doneTapHandler(sender:UIView){
        delegate?.datePicker(datePicker: self, didReturnDate: currentPickedDate!);
    }
}
