//
//  DatePickerDelegate.swift
//  Pods-Chemo Diary II
//
//  Created by Victor Lesk on 20/10/2017.
//

import Foundation

protocol DatePickerDelegate{
    func datePicker(datePicker _datePicker:DatePicker, didReturnDate _date:NSDate);
}
