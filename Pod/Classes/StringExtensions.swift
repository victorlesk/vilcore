//
//  NSStringExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 10/11/2015.
//
//

import Foundation

public extension String{
    func trim(string:String)->String{
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
}