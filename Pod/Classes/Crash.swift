//
//  Crash.swift
//  Pods
//
//  Created by Victor Lesk on 26/01/2016.
//
//

import Foundation

/**
  Cause an app to crash
 */
public func Crash(){
    var crashWithMissingValueInDicitonary = Dictionary<Int,Int>()
    let crashInt = crashWithMissingValueInDicitonary[1]!
    print(crashInt);
}
