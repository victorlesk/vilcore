//
//  UIViewControllerExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 06/06/2017.
//
//

import Foundation

public extension UIViewController{
    func fadeIn(){
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            for v in self.view.subviews {
                v.alpha = 1.0;
            }
        });
    }
}
