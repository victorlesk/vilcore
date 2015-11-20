//
//  NSStringExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 10/11/2015.
//
//

import Foundation

public extension String{
    func trim()->String{
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
    }
    
    func split(pattern:String,index:Int = 0)->String?{
        var result:[String]?  = split(pattern);

        if(result?.count > index){ return result![index]; }
        else { return nil; }
    }
    
    func split(pattern:String?)->[String]?{
        if(pattern == nil){ return nil;}
        return componentsSeparatedByString(pattern!);
    }
    
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: [.CaseInsensitive]);
        return regex.firstMatchInString(self, options: [], range: NSMakeRange(0, self.utf8.count)) != nil;
    }
}