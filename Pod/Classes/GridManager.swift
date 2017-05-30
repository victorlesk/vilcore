//
//  GridManager.swift
//  Pods
//
//  Created by Victor Lesk on 30/05/2017.
//
//

import Foundation
import UIKit

public class GridManager{
    weak var gridView:UIView!
    var maxColumns:Int = 3;
    weak var lastView:UIView?
    var alignment:NSTextAlignment;
    var hSpace:CGFloat = 0.0;
    var vSpace:CGFloat = 0.0;
    var evenHSpread = false;

    var ix=0;
    var iy=0;
    
    public init(gridView _gridView:UIView,columns _columns:Int, alignment _alignment:NSTextAlignment,hSpace _hSpace:CGFloat, vSpace _vSpace:CGFloat){
        gridView = _gridView;
        maxColumns = _columns;
        alignment = _alignment;
        hSpace = _hSpace;
        vSpace = _vSpace;
    }
    
    public init(gridView _gridView:UIView,columns _columns:Int, alignment _alignment:NSTextAlignment, vSpace _vSpace:CGFloat){
        gridView = _gridView;
        maxColumns = _columns;
        alignment = _alignment;
        vSpace = _vSpace;
        
        evenHSpread = true;
    }
    
    public func addView(_ v:UIView){
        gridView.addSubview(v);
        
        v.centreHorizontallyInParent();

        hSpace = gridView.frame.width / CGFloat(maxColumns) - v.frame.size.width;
        
        v.moveLeft( ( CGFloat(maxColumns - 1) / 2.0 - CGFloat(ix) ) * (v.frame.width + hSpace) );
        
        if(lastView == nil){
            v.alignParentTopBy(.moving, margin:vSpace);
        }else if(ix == 0){
            v.moveToBelow(lastView!, margin:vSpace);
        }else{
            v.verticalAlign(lastView!);
        }
        
        ix += 1;

        if(ix == maxColumns){
            ix = 0;
            iy += 1;
        }

        lastView = v;
    }
}
