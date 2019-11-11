//
//  UIViewControllerExtensions.swift
//  Pods
//
//  Created by Victor Lesk on 06/06/2017.
//
//

import Foundation

public extension UIViewController{
    @objc func fadeIn(){
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            for v in self.view.subviews {
                v.alpha = 1.0;
            }
        });
    }
    
    @objc func prepareForFadeIn(){
        for v in self.view.subviews {
                v.alpha = 0.0;
        }
    }
}
