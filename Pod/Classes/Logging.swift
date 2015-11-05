//
//  Logging.swift
//  Pods
//
//  Created by Victor Lesk on 05/11/2015.
//
//

import Foundation

public class Logging{

    class func LogBool(b:Bool msg:String? = nil){
        if(msg){
            NSLog("%@ (%@)",(b?"true":"false"),msg!);
        }else{
            NSLog("%@",(b?"true":"false"));
        }
    }

    class func LogNil(b:AnyObject? msg:String? = nil){
        if(msg){
            NSLog("%@ (%@)",((nil == b)?"nil":"non-nil"),msg!);
        }else{
            NSLog("%@",((nil == b)?"nil":"non-nil"));
        }
    }

}