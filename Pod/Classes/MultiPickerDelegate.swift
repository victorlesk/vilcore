//
//  MultiPickerDelegate.swift
//  Pods
//
//  Created by Victor Lesk on 26/10/2017.
//

import Foundation

public protocol MultiPickerDelegate{
    func multiPicker(multiPicker _multiPicker:MultiPicker, didReturnItem _itemIndex:Int, inColumn _columnIndex:Int);
    func multiPicker(multiPicker _multiPicker:MultiPicker, offsetForItem _itemIndex:Int, inColumn _columnIndex:Int)->CGFloat;
    func multiPicker(multiPicker _multiPicker:MultiPicker, heightFactorForItem _itemIndex:Int, inColumn _columnIndex:Int)->CGFloat;
    func multiPicker(multiPicker _multiPicker:MultiPicker, textForItem _itemIndex:Int, inColumn _columnIndex:Int)->String;
    func numberOfColumnsForMultiPicker(multiPicker _multiPicker:MultiPicker)->Int;
    func numberOfItemsInColumn(_ _column:Int, forMultiPicker _multiPicker:MultiPicker)->Int;

    func multiPickerCancelled(multiPicker _multiPicker:MultiPicker);

    var multiPickerContainerView:UIView {get}
}

