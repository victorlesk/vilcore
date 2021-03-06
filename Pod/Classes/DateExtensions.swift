//
//  DateExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 06/11/2015.
//
//

import Foundation

public extension String{
    //Returns the date-time from a string of the form 31/12/77 1453
    func DDMMYYTTDate()->Date?{
        let format = DateFormatter(); format.dateFormat="dd/MM/yy HHmm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: self);
    }
    
    //Returns the date from a string of the form 31/12/77
    func DDMMYYDate()->Date?{
        let format = DateFormatter(); format.dateFormat="dd/MM/yy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: self);
    }

    //Returns the date from a string of the form 29 Oct 01
    func DDMMMYYDate()->Date?{
        let format = DateFormatter(); format.dateFormat="dd MMM yy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: self);
    }

    //Returns the date from a string of the form 27/03/2015
    func DDMMYYYYDate()->Date?{
        let format = DateFormatter(); format.dateFormat="dd/MM/yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: self);
    }
    
    //Returns the date from a string of the form 30 Sep 1977
    func DDMMMYYYYDate()->Date?{
        let format = DateFormatter(); format.dateFormat="dd MMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: self);
    }
    
    //Returns the date-time from a string of the form 201709301234
    func keyDate()->Date?{
        let format = DateFormatter(); format.dateFormat="yyyyMMdd"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: self);
        
    }

    //Returns the date from a string of the form 20170930
    func keyDateTime()->Date?{
        let format = DateFormatter(); format.dateFormat="yyyyMMddHHmm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: self);
    }
}

public extension Date {
    
    func isLaterThan(_ date:Date)->Bool{
        return timeIntervalSince1970 > date.timeIntervalSince1970;
    }
    
    func isEarlierThan(_ date:Date)->Bool{
        return timeIntervalSince1970 < date.timeIntervalSince1970;
    }

    func daysIntervalSinceDate(_ otherDate:Date)->Int{
        let startDay:Int = (gregorianCalendar as NSCalendar).ordinality(of: NSCalendar.Unit.day,in:NSCalendar.Unit.era,for:otherDate);
    
        let endDay:Int = (gregorianCalendar as NSCalendar).ordinality(of: NSCalendar.Unit.day,in:NSCalendar.Unit.era,for:self);
        
        return endDay - startDay;
    }
    
    func daysIntervalStringSinceDate(_ otherDate:Date)->String{
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

    
    func components(_ components:NSCalendar.Unit)->DateComponents{
        return  (gregorianCalendar as NSCalendar).components(components, from: self);
    
    }

    func DDMMYYYYString()->String{
        let format = DateFormatter(); format.dateFormat="dd/MM/yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
 
    func MMYYYYString()->String{
        let format = DateFormatter(); format.dateFormat="MM/yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }

    func DDMMMYYYYString()->String{
        let format = DateFormatter(); format.dateFormat="dd MMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }

    func dateOfBirthAndAgeString()->String{
        let format = DateFormatter(); format.dateFormat="d MMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");

        let age = Int(floor(-timeIntervalSinceNow / 31536000));
        
        return format.string(from: self) + " (age \(age))";
    }

    func DDMMString()->String{
        let format = DateFormatter(); format.dateFormat="dd/MM"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    
    static func fromDDMMYYYYString(_ string:String?)->Date?{
        guard let string = string else {return nil;}
        
        let format = DateFormatter(); format.dateFormat="dd/MM/yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.date(from: string);
    }

    
    func DDMMYYString()->String{
        let format = DateFormatter(); format.dateFormat="dd/MM/yy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }

    /// Date and time formatter
    /// - Returns: Date string in format 31/12/99 1847
    func DDMMYYTTString()->String{
        let format = DateFormatter(); format.dateFormat="dd/MM/yy HHmm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func MMMMYYYYString()->String{
        let format = DateFormatter(); format.dateFormat="MMMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func MMMYYYYString()->String{
        let format = DateFormatter(); format.dateFormat="MMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func YYYYMMMDDString()->String{
        let format = DateFormatter(); format.dateFormat="yyyy MMM dd"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func MMMDDString()->String{
        let format = DateFormatter(); format.dateFormat="MMM dd"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func YYYYMMMDString()->String{
        let format = DateFormatter(); format.dateFormat="yyyy MMM d"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func MMMDString()->String{
        let format = DateFormatter(); format.dateFormat="MMM d"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func DDMMMString()->String{
        let format = DateFormatter(); format.dateFormat="d MMM"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func DDString()->String{
        let format = DateFormatter(); format.dateFormat="dd"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func DString()->String{
        let format = DateFormatter(); format.dateFormat="d"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }

    func DDMMMaYYString()->String{
        //No-break spaces
        let format = DateFormatter(); format.dateFormat="d'\u{00a0}'MMM'\u{00a0}‘'yy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func DD()->String{
        let format = DateFormatter(); format.dateFormat="d"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func longMonthString()->String{
        let format = DateFormatter(); format.dateFormat="dd MMMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func dateTimeString()->String{
        let format = DateFormatter(); format.dateFormat="dd MMM' at 'HH:mm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    
    func dayDateTimeString()->String{
        let format = DateFormatter(); format.dateFormat="EEE, dd MMM' at 'HH:mm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func timeDayDateString()->String{
        let format = DateFormatter(); format.dateFormat="HH:mm EEE dd MMMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }

    func keyDateTimeString()->String{
        let format = DateFormatter(); format.dateFormat="yyyyMMddHHmm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }

    func keyDateString()->String{
        let format = DateFormatter(); format.dateFormat="yyyyMMdd"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }

    func EEEEDsMMMMyyyyString()->String{
        let format = DateFormatter(); format.dateFormat="EEEE d'suffix' MMMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");

        return format.string(from: self).replacingOccurrences(of: "suffix", with: daySuffix());
    }
    func dateTimeString2()->String{
        let format = DateFormatter(); format.dateFormat="HHmm'h' dd MMM yyyy"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func dateTimeWithSecsString()->String{
        let format = DateFormatter(); format.dateFormat="dd MMM HH:mm ss's'"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func clock24hString()->String{
        let format = DateFormatter(); format.dateFormat="HH:mm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    func clock24hDotString()->String{
        let format = DateFormatter(); format.dateFormat="HH.mm"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    
    func clock24hHoursOnlyString()->String{
        let format = DateFormatter(); format.dateFormat="HH':00'"; format.locale = Locale(identifier: "en_US_POSIX");
        return format.string(from: self);
    }
    
    func clockAMPMString()->String{
        let format = DateFormatter() ; format.dateFormat="HH:mm a";format.locale = Locale(identifier: "en_US_POSIX");
        format.timeStyle = .short;
        format.amSymbol = NSLocalizedString("am",comment:"");
        format.pmSymbol = NSLocalizedString("pm",comment:"");
        
        return format.string(from: self);
    }
    
    func daySuffix() -> String {
        guard let dayOfMonth = self.components(.day).day else {return "";}

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
    
    func startOfNextMonth() -> Date{
        let components = gregorianCalendar.dateComponents([Calendar.Component.year,Calendar.Component.month],from:self);

        let newYear = (components.month == 12 ? components.year! + 1 : components.year!);
        let newMonth = String(format: "%02d", ((components.month == 12 ? 1 : components.month! + 1)));

        return ("01/\(newMonth)/\(newYear)").DDMMYYYYDate()!;
    }

    func startOfPreviousMonth() -> Date{
        let components = gregorianCalendar.dateComponents([Calendar.Component.year,Calendar.Component.month],from:self);
        
        let newYear = (components.month == 1 ? components.year! - 1 : components.year!);
        let newMonth = String(format: "%02d", ((components.month == 1 ? 12 : components.month! - 1)));
        
        return ("01/\(newMonth)/\(newYear)").DDMMYYYYDate()!;
    }

    func mostRecentSunday() -> Date{
        var returnDate = self.addingTimeInterval(0);
        
        while (true){
            let components = gregorianCalendar.dateComponents([Calendar.Component.weekday], from:returnDate);
            
            if(components.weekday == 7){ return returnDate ; }
            
            returnDate = returnDate.addingTimeInterval( -70000 );
        }
    }
    
    func nextDay() -> Date{
        var returnDate = self.addingTimeInterval(0);
        let startDay = gregorianCalendar.dateComponents([Calendar.Component.weekday], from:self).weekday;
        
        while (true){
            let components = gregorianCalendar.dateComponents([Calendar.Component.weekday,Calendar.Component.day,Calendar.Component.month,Calendar.Component.year], from:returnDate);
            if(components.weekday != startDay){
                let newDay   = String(format: "%02d", components.day!);
                let newMonth = String(format: "%02d", components.month!);
                let newYear  = String(format: "%02d", components.year!);
                
                return ("\(newDay)/\(newMonth)/\(newYear)").DDMMYYYYDate()!;
            }
            
            returnDate = returnDate.addingTimeInterval( 50000 );
        }
    }
    
    func isSameDayAs(_ _date:Date?) -> Bool{
        guard let _date = _date else {return false;}
        
        let selfComponents = gregorianCalendar.dateComponents([Calendar.Component.day,Calendar.Component.month,Calendar.Component.year], from:self);
        let otherComponents = gregorianCalendar.dateComponents([Calendar.Component.day,Calendar.Component.month,Calendar.Component.year], from:_date);
        
        return ((selfComponents.year == otherComponents.year) && (selfComponents.month == otherComponents.month) && (selfComponents.day == otherComponents.day));
    }

    func startOfCurrentMonth() -> Date{
        return ("01/\(self.MMYYYYString())").DDMMYYYYDate()!;
    }

}

var gregorianCalendar:Calendar = Calendar(identifier: Calendar.Identifier.gregorian);

public extension DateFormatter{
}




