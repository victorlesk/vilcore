//
//  UIScrollViewExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 08/06/2017.
//
//

import Foundation
import UIKit

public extension UIScrollView{
    @objc func scrollToBottom(){
        setContentOffset(CGPoint(x:contentOffset.x,y:contentSize.height - frame.height), animated: true);
    }

    @objc func scrollToTop(){
        setContentOffset(CGPoint(x:contentOffset.x,y:0), animated: true);
    }

    @objc func scrollTo(_ p:CGPoint){
        setContentOffset(p, animated:true);
    }
}
