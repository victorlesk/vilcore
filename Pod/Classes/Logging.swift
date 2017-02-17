//
//  Logging.swift
//  Pods
//
//  Created by Victor Lesk on 05/11/2015.
//
//

import Foundation

public func LogBool(_ b:Bool,_ msg:String? = nil){
    if(nil != msg){
        NSLog("%@ (%@)",(b ? "true":"false"),msg!);
    }else{
        NSLog("%@",(b ? "true":"false"));
    }
}

public func LogNil(_ b:AnyObject?,_ msg:String? = nil){
    if(nil != msg){
        NSLog("%@ (%@)",((nil == b) ? "nil":"non-nil"),msg!);
    }else{
        NSLog("%@",((nil == b) ? "nil":"non-nil"));
    }
}

public func LogFrame(_ b:CGRect,_ msg:String? = nil){
    if(nil != msg){
        NSLog("%fx + %fy / %fw x %fh (%@)",b.origin.x,b.origin.y,b.size.width,b.size.height,msg!);
    }else{
        NSLog("%fx + %fy / %fw x %fh ",b.origin.x,b.origin.y,b.size.width,b.size.height);
    }
}

public func LogPoint(_ b:CGPoint,_ msg:String? = nil){
    if(nil != msg){
        NSLog("%fx + %fy (%@)",b.x,b.y,msg!);
    }else{
        NSLog("%fx + %fy ",b.x,b.y);
    }
}

public func LogSize(_ b:CGSize,_ msg:String? = nil){
    if(nil != msg){
        NSLog("%fw x %fh (%@)",b.width,b.height,msg!);
    }else{
        NSLog("%fw x %fh ",b.width, b.height);
    }
}

