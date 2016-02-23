//
//  NSDateExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 06/11/2015.
//
//

import Foundation

public extension String{
    func DDMMYYTTDate()->NSDate?{
        let format = NSDateFormatter(); format.dateFormat="dd/MM/yy HHmm"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.dateFromString(self);
    }
}

public extension NSDate {
    
    func isLaterThan(date:NSDate)->Bool{
        return timeIntervalSince1970 > date.timeIntervalSince1970;
    }
    
    func isEarlierThan(date:NSDate)->Bool{
        return timeIntervalSince1970 < date.timeIntervalSince1970;
    }

    func daysIntervalSinceDate(otherDate:NSDate)->Int{
        let startDay:Int = gregorianCalendar.ordinalityOfUnit(NSCalendarUnit.Day,inUnit:NSCalendarUnit.Era,forDate:otherDate);
    
        let endDay:Int = gregorianCalendar.ordinalityOfUnit(NSCalendarUnit.Day,inUnit:NSCalendarUnit.Era,forDate:self);
        
        return endDay - startDay;
    }
    
    func daysIntervalStringSinceDate(otherDate:NSDate)->String{
        let interval:Int = daysIntervalSinceDate(otherDate);

        if(interval == 0){return NSLocalizedString("Today",comment:""); }
        else if(interval == 1){return NSLocalizedString("Tomorrow",comment:""); }
        else if(interval == 2){return NSLocalizedString("Day after tomorrow",comment:""); }
        else if(interval == -1){return NSLocalizedString("Yesterday",comment:""); }
        else /*if(interval == -2)*/{return NSLocalizedString("Day before yesterday",comment:""); }
//        else if(interval >=3 && interval <10){return String(format:NSLocalizedString("In %@ days",comment:""),[Core getZeroToNineOrNumeralsString:(long long)interval]]; }
//        else if(interval <=-3 && interval > -10){return [NSString stringWithFormat:NSLocalizedString("%@ days ago",comment:""),[Core getZeroToNineOrNumeralsString:-((long long)interval)]]; }
//        else if(interval >=10){return [NSString stringWithFormat:NSLocalizedString("In %@ days",comment:""),[Core getLocaleInteger:interval]]; }
//        else{ return [NSString stringWithFormat:NSLocalizedString("%@ days ago",comment:""),[Core getLocaleInteger:-interval]]; }
    }

    
    func components(components:NSCalendarUnit)->NSDateComponents{
        return  gregorianCalendar.components(components, fromDate: self);
    
    }

    func DDMMYYYYString()->String{
        let format = NSDateFormatter(); format.dateFormat="dd/MM/yyyy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    
    class func fromDDMMYYYYString(string:String?)->NSDate?{
        guard let string = string else {return nil;}
        
        let format = NSDateFormatter(); format.dateFormat="dd/MM/yyyy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.dateFromString(string);
    }

    
    func DDMMYYString()->String{
        let format = NSDateFormatter(); format.dateFormat="dd/MM/yy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func DDMMYYTTString()->String{
        let format = NSDateFormatter(); format.dateFormat="dd/MM/yy HHmm"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func MMMYYYYString()->String{
        let format = NSDateFormatter(); format.dateFormat="MMMM yyyy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func DDMMMString()->String{
        let format = NSDateFormatter(); format.dateFormat="d MMM"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func DDMMMaYYString()->String{
        //No-break spaces
        let format = NSDateFormatter(); format.dateFormat="d'\u{00a0}'MMM'\u{00a0}‘'yy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func DD()->String{
        let format = NSDateFormatter(); format.dateFormat="d"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func longMonthString()->String{
        let format = NSDateFormatter(); format.dateFormat="dd MMMM yyyy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func dateTimeString()->String{
        let format = NSDateFormatter(); format.dateFormat="dd MMM' at 'HH:mm"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func dayDateTimeString()->String{
        let format = NSDateFormatter(); format.dateFormat="EEE, dd MMM' at 'HH:mm"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }

    func EEEEDsMMMMyyyyString()->String{
        let format = NSDateFormatter(); format.dateFormat="EEEE d'suffix' MMMM yyyy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");

        return format.stringFromDate(self).stringByReplacingOccurrencesOfString("suffix", withString: daySuffix());
    }
    func dateTimeString2()->String{
        let format = NSDateFormatter(); format.dateFormat="HHmm'h' dd MMM yyyy"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func dateTimeWithSecsString()->String{
        let format = NSDateFormatter(); format.dateFormat="dd MMM HH:mm ss's'"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func clock24hString()->String{
        let format = NSDateFormatter(); format.dateFormat="HH:mm"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    func clock24hHoursOnlyString()->String{
        let format = NSDateFormatter(); format.dateFormat="HH':00'"; format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        return format.stringFromDate(self);
    }
    
    func clockAMPMString()->String{
        let format = NSDateFormatter() ; format.dateFormat="HH:mm a";format.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        format.timeStyle = .ShortStyle;
        format.AMSymbol = NSLocalizedString("am",comment:"");
        format.PMSymbol = NSLocalizedString("pm",comment:"");
        
        return format.stringFromDate(self);
    }
    
    func daySuffix() -> String {
        let dayOfMonth = self.components(.Day).day;
        switch dayOfMonth {
        case 1: fallthrough
        case 21: fallthrough
        case 31: return "st"
        case 2: fallthrough
        case 22: return "nd"
        case 3: fallthrough
        case 23: return "rd"
        default: return "th"
        }
    }
}

var gregorianCalendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!;

public extension NSDateFormatter{
}




