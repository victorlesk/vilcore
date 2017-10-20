//
//  GridManager.swift
//  Pods
//
//  Created by Victor Lesk on 30/05/2017.
//
//

import Foundation
import UIKit

/**
 Class for managing adding widgets to a view so that they are arranged in a grid-based layout.
 
 Stores the grid's base view, the number of columns, the alignment, and the vertical and horizontal space in pixels.
 */
public class GridManager{
    
    ///The view whose subviews should be arranged in a grid
    weak var gridView:UIView!

    ///Maximum number of views per row
    var maxColumns:Int = 3;
    weak var lastView:UIView?
    
    ///How to layout the bottom row if it contains fewer than the maximum views
    var alignment:NSTextAlignment;
    var hSpace:CGFloat = 0.0;
    var vSpace:CGFloat = 0.0;

    ///Whether to calculate (true) or manually specify (if false) the horizontal separation between subviews
    var evenHSpread = false;

    var ix=0;
    var iy=0;

    /**
     Use when specifying horizontal separation manually
     - Parameters:
        - gridView: The view whose children will be arranged in a grid
        - columns: The maximum number of columns in a grid row
        - alignment: how to handle the bottom row if deficient, specified as NSTextAlignment
        - hSpace: space in pixels between views in the same row
        - vSpace: space in pixels between rows
     */
    public init(gridView _gridView:UIView,columns _columns:Int, alignment _alignment:NSTextAlignment,hSpace _hSpace:CGFloat, vSpace _vSpace:CGFloat){
        gridView = _gridView;
        maxColumns = _columns;
        alignment = _alignment;
        hSpace = _hSpace;
        vSpace = _vSpace;
    }
    
    /**
     Use when horizontal layout is automatic
     - Parameters:
         - gridView: The view whose children will be arranged in a grid
         - columns: The maximum number of columns in a grid row
         - alignment: how to handle the bottom row if deficient, specified as NSTextAlignment
         - vSpace: space in pixels between rows
     */
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
