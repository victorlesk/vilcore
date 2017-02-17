//
//  NSStringExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 10/11/2015.
//
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


public extension String{
    func trim()->String{
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
    }
    
    func split(_ pattern:String,index:Int)->String?{
        var result:[String]?  = split(pattern);

        if(result?.count > index){ return result![index]; }
        else { return nil; }
    }
    
    func split(_ pattern:String?)->[String]?{
        if(pattern == nil){ return nil;}
        return components(separatedBy: pattern!);
    }
    
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: [.caseInsensitive]);
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.utf8.count)) != nil;
    }
}
