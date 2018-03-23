//
//  DatePickerDelegate.swift
//  Pods-Chemo Diary II
//
//  Created by Victor Lesk on 20/10/2017.
//

import Foundation

public protocol DatePickerDelegate{
    func datePicker(datePicker _datePicker:DatePicker, didReturnDate _date:Date);
    func datePickerCancelled(datePicker _datePicker:DatePicker);
    func defaultDateForDatePicker(datePicker _datePicker:DatePicker)->Date?;
    
    var datePickerContainerView:UIView {get}
}

