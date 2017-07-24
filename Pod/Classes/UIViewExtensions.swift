import Foundation
import UIKit

public enum MoveStretch{
    case moving,stretching;
};

public enum EvenProp{
    case evenly,proportionally;
};

public extension UIView{
    
    func zeroFrame(){
        frame = CGRect(x: 0,y: 0,width: 0,height: 0);
    }
    
    func alignRight(_ v:UIView, by:MoveStretch){
        alignRight(v, by:by, margin:0.0);
    }
    
    func alignRight(_ v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .moving){
            frame=CGRect(x: v.frame.origin.x + v.frame.size.width - self.frame.size.width - margin, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
            frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: v.frame.origin.x + v.frame.size.width - self.frame.origin.x - margin, height: self.frame.size.height);
        }
    }
    
    func alignBottom(_ v:UIView,by:MoveStretch){
        alignBottom(v,by:by,margin:0.0);
    }
    
    func alignBottom(_ v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .moving){
            frame=CGRect(x: self.frame.origin.x,y: v.frame.origin.y + v.frame.size.height - self.frame.size.height - margin, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
            frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: v.frame.origin.y + v.frame.size.height - self.frame.origin.y - margin);
        }
    }
    
    func alignLeft(_ v:UIView,by:MoveStretch){
        alignLeft(v,by:by,margin:0.0)
    }
    
    func alignLeft(_ v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .moving){
            frame=CGRect(x: v.frame.origin.x + margin, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
            frame=CGRect(x: v.frame.origin.x + margin, y: self.frame.origin.y, width: self.frame.origin.x + self.frame.size.width - (v.frame.origin.x + margin), height: self.frame.size.height);
        }
    }
    
    func alignTop(_ v:UIView,by:MoveStretch){
        alignTop(v,by:by,margin:0.0);
    }
    
    func alignTop(_ v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .moving){
                frame=CGRect(x: self.frame.origin.x,y: v.frame.origin.y + margin, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
                frame=CGRect(x: self.frame.origin.x,y: v.frame.origin.y + margin, width: self.frame.size.width, height: self.frame.origin.y + self.frame.size.height - (v.frame.origin.y + margin));
        }
    }
    
    func alignTopRight(_ v:UIView,by:MoveStretch){
        alignTop  (v, by:by, margin:0);
        alignRight(v, by:by, margin:0);
    }
    
    func alignTopRight(_ v:UIView,by:MoveStretch,margin:CGFloat){
        alignTop  (v, by:by, margin:margin);
        alignRight(v, by:by, margin:margin);
    }
    
    func alignTopLeft(_ v:UIView,by:MoveStretch){
        alignTop (v, by:by, margin:0);
        alignLeft(v, by:by, margin:0);
    }
    
    func alignTopLeft(_ v:UIView, by:MoveStretch, margin:CGFloat){
        alignTop (v, by:by, margin:margin);
        alignLeft(v, by:by, margin:margin);
    }
    
    func alignBottomLeft(_ v:UIView,by:MoveStretch){
        alignBottom(v, by:by, margin:0);
        alignLeft  (v, by:by, margin:0);
    }
    
    func alignBottomLeft(_ v:UIView,by:MoveStretch,margin:CGFloat){
        alignBottom(v, by:by, margin:margin);
        alignLeft  (v, by:by, margin:margin);
    }
    
    func alignBottomRight(_ v:UIView,by:MoveStretch){
        alignBottom(v, by:by, margin:0);
        alignRight(v, by:by, margin:0);
    }
    
    func alignBottomRight(_ v:UIView,by:MoveStretch,margin:CGFloat){
        alignBottom(v, by:by, margin:margin);
        alignRight(v, by:by, margin:margin);
    }
    
    func horizontalAlign(_ v:UIView){
        horizontalAlign(v, margin:0);
    }
    
    func horizontalAlign(_ v:UIView, margin:CGFloat){
    if(self.frame.minX > v.frame.maxX){
        alignLeft (v, by:.stretching, margin:margin);
        alignRight(v, by:.stretching, margin:margin);
    }else{
        alignRight(v, by:.stretching, margin:margin);
        alignLeft (v, by:.stretching, margin:margin);
    }
    }
    
    func verticalAlign(_ v:UIView){
        verticalAlign(v, margin:0);
    }
    
    func verticalAlign(_ v:UIView, margin:CGFloat){
        if(self.frame.minY > v.frame.maxY){
            alignTop   (v, by:.stretching, margin:margin);
            alignBottom(v, by:.stretching, margin:margin);
        }else{
            alignBottom(v, by:.stretching, margin:margin);
            alignTop   (v, by:.stretching, margin:margin);
        }
    }
    
    func stretchHorizontallyToFillParentWithMargin(_ margin:CGFloat){
        frame = CGRect(x: 0,y: frame.origin.y,width: 0,height: frame.size.height);
        centreHorizontallyInParent()
        alignParentRightBy(.stretching, margin:margin);
        alignParentLeftBy (.stretching, margin:margin);
    }
    
    func stretchHorizontallyToFillParent(){
        stretchHorizontallyToFillParentWithMargin(0);
    }
    
    func fill(_ v:UIView){
        fill(v, margin:0);
    }
    
    func fill(_ v:UIView, margin:CGFloat){
        let xMargin:CGFloat = (margin * 2 > v.frame.size.width  ? v.frame.size.width  / 2 : margin);
        let yMargin:CGFloat = (margin * 2 > v.frame.size.height ? v.frame.size.height / 2 : margin);
        
        self.frame = CGRect(x: v.frame.origin.x + xMargin, y: v.frame.origin.y + yMargin,
            width: v.frame.size.width - (xMargin * 2), height: v.frame.size.height - (yMargin * 2));
    }
    
    func stretchVerticallyToFillParentWithMargin(_ margin:CGFloat){
        frame = CGRect(x: frame.origin.x,y: 0,width: frame.size.width,height: 0);
        centreVerticallyInParent();
        alignParentTopBy   (.stretching, margin:margin);
        alignParentBottomBy(.stretching, margin:margin);
    }
    
    func stretchChildrenHorizontallyToFillWithMargin(_ margin:CGFloat){
        for v in subviews{
            v.stretchHorizontallyToFillParentWithMargin(margin);
        }
    }
    
    func stretchChildrenHorizontallyToFill(){
        stretchChildrenHorizontallyToFillWithMargin(0.0);
    }
    
    func stretchChildrenVerticallyToFillWithMargin(_ margin:CGFloat){
        for v in subviews{
            v.stretchVerticallyToFillParentWithMargin(margin);
        }
    }
    
    func stretchChildrenVerticallyToFill(){
        stretchChildrenVerticallyToFillWithMargin(0.0);
    }
    
    
    func fillParent(){
        stretchHorizontallyToFillParentWithMargin(0);
        stretchVerticallyToFillParentWithMargin  (0);
    }
    
    func fillParentWithMargin(_ margin:CGFloat){
        stretchHorizontallyToFillParentWithMargin(margin);
        stretchVerticallyToFillParentWithMargin  (margin);
    }
    
    func stretchVerticallyToFillParent(){
        stretchVerticallyToFillParentWithMargin(0);
    }
    
    func centreHorizontallyIn(_ v:UIView){
        frame=CGRect(x: v.frame.origin.x + 0.5 * (v.frame.size.width - self.frame.size.width),y: self.frame.origin.y,width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func centreVerticallyIn(_ v:UIView){
        frame=CGRect(x: self.frame.origin.x,y: v.frame.origin.y + 0.5 * (v.frame.size.height - self.frame.size.height),width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func centreIn(_ v:UIView){
        frame=CGRect(x: v.frame.origin.x + 0.5 * (v.frame.size.width - self.frame.size.width),y: v.frame.origin.y + 0.5 * (v.frame.size.height - self.frame.size.height),width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func centreHorizontallyInParent(){
        frame=CGRect(x: 0.5 * (superview!.frame.size.width - self.frame.size.width),y: self.frame.origin.y,width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func centreVerticallyInParent(){
        frame=CGRect(x: self.frame.origin.x, y: 0.5 * (superview!.frame.size.height - self.frame.size.height),width: self.frame.size.width,height: self.frame.size.height);
    }
    
    
    func centreInParent(){
        frame=CGRect(x: superview!.frame.origin.x + 0.5 * (superview!.frame.size.width - self.frame.size.width),y: superview!.frame.origin.y + 0.5 * (superview!.frame.size.height - self.frame.size.height),width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func alignParentTopBy(_ by:MoveStretch){
        alignParentTopBy(by,margin:0);
    }
    
    func alignParentTopBy(_ by:MoveStretch, margin:CGFloat){
        if(by == .moving){
            frame=CGRect(x: self.frame.origin.x,y: margin, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
            frame=CGRect(x: self.frame.origin.x,y: margin, width: self.frame.size.width,height: self.frame.origin.y + self.frame.size.height - margin);
        }
    }
    
    func alignParentBottomBy(_ by:MoveStretch){
        alignParentBottomBy(by, margin:0);
    }
    
    func alignParentBottomBy(_ by:MoveStretch, margin:CGFloat){
        if(by == .moving){
            frame=CGRect(x: self.frame.origin.x,y: superview!.frame.size.height - self.frame.size.height - margin, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
            frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: superview!.frame.size.height - self.frame.origin.y - margin);
        }
    }
    
    func alignParentLeftBy(_ by:MoveStretch){
        alignParentLeftBy(by, margin:0);
    }
    
    func alignParentLeftBy(_ by:MoveStretch, margin:CGFloat){
        if(by == .moving){
            frame=CGRect(x: margin, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
            frame=CGRect(x: margin, y: self.frame.origin.y,width: self.frame.origin.x + self.frame.size.width - margin, height: self.frame.size.height);
        }
    }
    
    
    func alignParentRightBy(_ by:MoveStretch){
        alignParentRightBy(by, margin:0);
    }
    
    func alignParentRightBy(_ by:MoveStretch, margin:CGFloat){
        if(by == .moving){
            frame=CGRect(x: superview!.frame.size.width - self.frame.size.width - margin, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
        }else if(by == .stretching){
            frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: superview!.frame.size.width - self.frame.origin.x - margin, height: self.frame.size.height);
        }
    }
    
    func alignParentTopRightBy(_ by:MoveStretch){
        alignParentTopRightBy(by, margin:0.0);
    }
    
    func alignParentTopRightBy(_ by:MoveStretch, margin:CGFloat){
        alignParentTopBy  (by, margin:margin);
        alignParentRightBy(by, margin:margin);
    }
    
    func alignParentBottomRightBy(_ by:MoveStretch){
        alignParentBottomRightBy(by,margin:0.0);
    }
    
    func alignParentBottomRightBy(_ by:MoveStretch, margin:CGFloat){
        alignParentBottomBy(by, margin:margin);
        alignParentRightBy (by, margin:margin);
    }
    
    func alignParentBottomLeftBy(_ by:MoveStretch){
        alignParentBottomLeftBy(by, margin:0.0);
    }
    
    func alignParentBottomLeftBy(_ by:MoveStretch, margin:CGFloat){
        alignParentBottomBy(by, margin:margin);
        alignParentLeftBy  (by, margin:margin);
    }
    
    func alignParentTopLeftBy(_ by:MoveStretch){
        alignParentTopLeftBy(by, margin:0.0);
    }
    
    func alignParentTopLeftBy(_ by:MoveStretch,margin:CGFloat){
        alignParentTopBy (by, margin:margin);
        alignParentLeftBy(by, margin:margin);
    }
    
    
    func moveToBelow(_ v:UIView){
        moveToBelow(v, margin:0);
    }
    
    func moveToBelow(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: self.frame.origin.x,y: v.frame.maxY + margin,width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func ensureBelow(view:UIView){
        ensureBelow(view, margin:0);
    }
    
    func ensureBelow(_ v:UIView, margin:CGFloat){
        ensureBelow(d:v.frame.maxY + margin);
    }
    
    func ensureBelow(d:CGFloat){
        if(frame.origin.y < d){
            frame=CGRect(x: self.frame.origin.x,y: d,width: self.frame.size.width,height: self.frame.size.height);
        }
    }
    
    func moveToAbove(_ v:UIView){
        moveToAbove(v, margin:0);
    }
    
    func moveToAbove(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: self.frame.origin.x,y: v.frame.origin.y - margin - self.frame.size.height,width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func moveToLeftOf(_ v:UIView){
        moveToLeftOf(v, margin:0);
    }
    
    func moveToLeftOf(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: v.frame.origin.x - margin - self.frame.size.width,y: self.frame.origin.y,width: self.frame.size.width,height: self.frame.size.height);
    }
    
    func moveToRightOf(_ v:UIView){
        moveToRightOf(v, margin:0);
    }
    
    func moveToRightOf(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: v.frame.maxX + margin,y: self.frame.origin.y,width: self.frame.size.width,height: self.frame.size.height);
    }
    
    
    func centreBetween(_ v1:UIView,_ v2:UIView){
        var topView:UIView?, bottomView:UIView?, leftView:UIView?, rightView:UIView?;
        
        if(v1.frame.maxY < v2.frame.minY){
            topView = v1;
            bottomView = v2;
        }else if(v2.frame.maxY < v1.frame.minY){
            topView = v2;
            bottomView = v1;
        }

        if(v1.frame.maxX < v2.frame.minX){
            leftView = v1;
            rightView = v2;
        }else if(v2.frame.maxX < v1.frame.minX){
            leftView = v2;
            rightView = v1;
        }
        
        if let topView  = topView {frame=CGRect(x: frame.origin.x,y: topView.frame.maxY + ((bottomView!.frame.minY - topView.frame.maxY) - frame.size.height)/2.0,width: frame.size.width,height: frame.size.height);}
        if let leftView = leftView{frame=CGRect(x: leftView.frame.maxX + ((rightView!.frame.minX - leftView.frame.maxX) - frame.size.width)/2.0,y: frame.origin.y,width: frame.size.width,height: frame.size.height);}
        
    }
    
    func stretchToBelow(_ v:UIView){
        stretchToBelow(v, margin:0);
    }
    
    func stretchToBelow(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: self.frame.origin.x,y: v.frame.maxY + margin,width: self.frame.size.width,height: self.frame.maxY - v.frame.maxY - margin);
    }
    
    func stretchToAbove(_ v:UIView){
        stretchToAbove(v, margin:0);
    }
    
    func stretchToAbove(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: self.frame.origin.x,y: self.frame.origin.y,width: self.frame.size.width,height: v.frame.origin.y - margin - self.frame.origin.y);
    }
    
    func stretchToLeftOf(_ v:UIView){
        stretchToLeftOf(v, margin:0);
    }
    
    func stretchToLeftOf(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: self.frame.origin.x,y: self.frame.origin.y,width: v.frame.origin.x - margin - self.frame.origin.x,height: self.frame.size.height);
    }
    
    func stretchToRightOf(_ v:UIView){
        stretchToRightOf(v, margin:0);
    }
    
    func stretchToRightOf(_ v:UIView, margin:CGFloat){
        frame=CGRect(x: v.frame.maxX + margin,y: self.frame.origin.y,width: self.frame.maxX - v.frame.maxX - margin, height: self.frame.size.height);
    }
    
    func moveLeft(_ d:CGFloat){
        frame=CGRect(x: self.frame.origin.x - d, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
    }
    
    func moveRight(_ d:CGFloat){
        moveLeft(-d);
    }
    
    func moveUp(_ d:CGFloat){
        frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y - d, width: self.frame.size.width, height: self.frame.size.height);
    }
    
    func moveDown(_ d:CGFloat){
        moveUp(-d);
    }
    
    func stretchLeft(_ d:CGFloat){
        frame=CGRect(x: self.frame.origin.x - d, y: self.frame.origin.y, width: self.frame.size.width + d, height: self.frame.size.height);
    }
   
    func stretchRight(_ d:CGFloat){
        frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width + d, height: self.frame.size.height);
    }
    
    func stretchUp(_ d:CGFloat){
        frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y - d, width: self.frame.size.width, height: self.frame.size.height + d);
    }
    
    func stretchDown(_ d:CGFloat){
        frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height + d);
    }
    
    func setWidth(_ d:CGFloat){
        stretchRight(d - self.frame.size.width);
    }
    
    func setHeight(_ d:CGFloat){
        stretchDown(d - self.frame.size.height);
    }

    func setHeightOf(_ v:UIView){
        setHeight(v.frame.size.height);
    }

    func setWidthOf(_ v:UIView){
        setWidth(v.frame.size.width);
    }

    func setSizeOf(_ v:UIView){
        setWidth(v.frame.size.width);
        setHeight(v.frame.size.height);
    }
    
    func setHeightOf(_ v:UIView,factor f:CGFloat){
        setHeight(v.frame.size.height * f);
    }
    
    func setWidthOf(_ v:UIView,factor f:CGFloat){
        setWidth(v.frame.size.width * f);
    }
    
    func setSizeOf(_ v:UIView, factor f:CGFloat){
        setWidth(v.frame.size.width * f);
        setHeight(v.frame.size.height * f);
    }
    
    
    func setWidthOfParent(_ d:CGFloat){
        setWidth(superview!.frame.size.width * d);
    }
    
    func setHeightOfParent(_ d:CGFloat){
        setHeight(superview!.frame.size.height * d);
    }
    
    func setWidthToHeight(_ r:CGFloat){
        setWidth(self.frame.size.height * r) ;
    }
    
    func setHeightToWidth(_ r:CGFloat){
        setHeight(self.frame.size.width * r) ;
    }
    
    func layoutSubviewsHorizontallyDistributingExtraSpace(_ epEnum:EvenProp){
        layoutSubviewsHorizontallyDistributingExtraSpace(epEnum,margin:0);
    }
    
    func layoutSubviewsHorizontallyDistributingExtraSpace(_ epEnum:EvenProp, margin:CGFloat){
        var totalWidth:CGFloat = 0.0;
    
        for v in subviews{
            totalWidth += v.frame.size.width;
        }
    
        let excessWidth:CGFloat = self.frame.size.width - (2.0 * margin) - totalWidth;
        let excessWidthPerSubview:CGFloat = excessWidth / ((CGFloat)(subviews.count));
        
        var lastView:UIView?;
        
        for v in subviews{
            v.stretchRight((epEnum == .evenly ? excessWidthPerSubview : excessWidth * ( v.frame.size.width / totalWidth )));
        
            if(nil == lastView){
                v.alignParentLeftBy(.moving,margin:margin);
            }else{
                v.moveToRightOf(lastView!);
            }

            lastView = v;
        }
    }
    
    func layoutSubviewsVerticallyDistributingExtraSpace(_ epEnum:EvenProp){
        layoutSubviewsVerticallyDistributingExtraSpace(epEnum, margin:0);
    }
    
    func layoutSubviewsVerticallyDistributingExtraSpace(_ epEnum:EvenProp, margin:CGFloat){
        var totalHeight:CGFloat = 0.0;
        
        for v in subviews{
            totalHeight += v.frame.size.height;
        }
        
        let excessHeight:CGFloat = self.frame.size.height - (2.0 * margin) - totalHeight;
        let excessHeightPerSubview:CGFloat = excessHeight / ((CGFloat)(subviews.count));
        
        var lastView:UIView?
        
        for v in subviews{
            v.stretchDown((epEnum == .evenly ? excessHeightPerSubview : excessHeight * ( v.frame.size.height / totalHeight )));
            
            if(lastView == nil){
                v.alignParentTopBy(.moving, margin:margin);
            }else{
                v.moveToBelow(lastView!);
            }
        lastView = v;
        }
    }
    
    func layoutSubviewsHorizontallyEvenly(){
        layoutSubviewsHorizontallyEvenlyWithMargin(0.0);
    }
    
    func layoutSubviewsHorizontallyEvenlyWithMargin(_ margin:CGFloat){
        let subviewWidth:CGFloat = (self.frame.size.width - 2.0 * margin)/((CGFloat)(subviews.count));
    
        var lastView:UIView?;
    
        for v in subviews{
            v.setWidth(subviewWidth);
        
            if(lastView == nil){
                v.alignParentLeftBy(.moving, margin:margin);
            }else{
                v.moveToRightOf(lastView!);
            }
        lastView = v;
        }
    }
    
    func layoutSubviewsVerticallyEvenly(){
        layoutSubviewsVerticallyEvenlyWithMargin(0.0);
    }
    
    func layoutSubviewsVerticallyEvenlyWithMargin(_ margin:CGFloat){
        let subviewHeight:CGFloat = (self.frame.size.height - 2.0 * margin)/((CGFloat)(subviews.count));
        
        var lastView:UIView?;
        
        for v in subviews {
            v.setHeight(subviewHeight);
        
            if(lastView == nil){
                v.alignParentTopBy(.moving, margin:margin);
            }else{
                v.moveToBelow(lastView!)
            }
        lastView = v;
        }
    }
    
    func hugChildrenHorizontally(){
        hugChildrenHorizontallyWithMargin(0.0);
    }
    
    func hugChildrenHorizontallyWithMargin(_ margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
    
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = unionRect.union(v.frame);
            }
        
        }
        
        self.frame = CGRect(x: self.frame.origin.x + unionRect.origin.x - margin,y: self.frame.origin.y,width: unionRect.size.width + 2.0*margin,height: self.frame.size.height);
        
        for v in subviews{
            v.moveLeft(unionRect.origin.x - margin);
        }
    }
    
    func hugChildrenVertically(){
        hugChildrenVerticallyWithMargin(0.0);
    }
    
    func hugChildrenVerticallyWithMargin(_ margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
    
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = unionRect.union(v.frame);
            }
        }
        
        self.frame = CGRect(x: self.frame.origin.x,y: self.frame.origin.y + unionRect.origin.y - margin,width: self.frame.size.width,height: unionRect.size.height + 2.0*margin);
        
        for v in subviews{
            v.moveUp(unionRect.origin.y - margin);
        }
    }
    
    func hugChildren(){
        hugChildrenWithMargin(0.0);
    }
    
    func hugChildrenWithMargin(_ margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
    
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = unionRect.union(v.frame);
            }
            
        }
        
        self.frame = CGRect(x: self.frame.origin.x + unionRect.origin.x - margin,y: self.frame.origin.y + unionRect.origin.y - margin,width: unionRect.size.width + 2.0*margin,height: unionRect.size.height + 2.0*margin);
        
        for v in subviews{
            v.moveLeft(unionRect.origin.x - margin);
            v.moveUp  (unionRect.origin.y - margin);
        }
    }
    
    
    func hugChildrenTop(){
        hugChildrenTopWithMargin(0);
    }
    
    func hugChildrenTopWithMargin(_ margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = unionRect.union(v.frame);
            }
        }
        
        stretchUp( -(unionRect.origin.y - margin));
        
        for v in subviews{
            v.moveUp(unionRect.origin.y - margin);
        }
    }
    
    func hugChildrenBottom(){
        hugChildrenBottomWithMargin(0);
    }
    
    func hugChildrenBottomWithMargin(_ margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = unionRect.union(v.frame);
            }
        }
        
        stretchDown((unionRect.maxY + margin) - self.frame.size.height);
    }
    
    func hugChildrenLeft(){
        hugChildrenLeftWithMargin(0);
    }
    
    func hugChildrenLeftWithMargin(_ margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews {
            if(v !== subviews[0]){
                unionRect = unionRect.union(v.frame);
            }
            
        }
        
        stretchLeft( -(unionRect.origin.x - margin));
        
        for v in subviews{
            v.moveLeft(unionRect.origin.x - margin);
        }
    
    }
    
    func hugChildrenRight(){
        hugChildrenRightWithMargin(0);
    }
    
    func hugChildrenRightWithMargin(_ margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = unionRect.union(v.frame);
            }
        }
        
        stretchRight((unionRect.maxX + margin) - self.frame.size.width);
        
    }
    
    func hugChildrenTopLeft(){
        hugChildrenTop();
        hugChildrenLeft();
    }
    
    func hugChildrenTopLeftWithMargin(_ margin:CGFloat){
        hugChildrenTopWithMargin(margin);
        hugChildrenLeftWithMargin(margin);
    }
    
    func hugChildrenBottomRight(){
        hugChildrenBottom();
        hugChildrenRight();
    }
    
    func hugChildrenBottomRightWithMargin(_ margin:CGFloat){
        hugChildrenBottomWithMargin(margin);
        hugChildrenRightWithMargin(margin);
    }
    
    func hugChildrenBottomLeft(){
        hugChildrenBottom();
        hugChildrenLeft();
    }
    
    func hugChildrenBottomLeftWithMargin(_ margin:CGFloat){
        hugChildrenBottomWithMargin(margin);
        hugChildrenLeftWithMargin(margin);
    }
    
    func hugChildrenTopRight(){
        hugChildrenTop();
        hugChildrenRight();
    }
    
    func hugChildrenTopRightWithMargin(_ margin:CGFloat){
        hugChildrenTopWithMargin(margin);
        hugChildrenLeftWithMargin(margin);
    }
    
    
    func widenSymmetricallyFactor(_ d:CGFloat){
        if(d<0){return;}
        
        frame=CGRect(x: self.frame.origin.x -  (self.frame.size.width  / 2.0) * (d - 1.0),y: self.frame.origin.y,width: self.frame.size.width  * d,height: self.frame.size.height);
    }
    
    func widenSymmetrically(_ d:CGFloat){
        frame=CGRect(x: self.frame.origin.x - d,y: self.frame.origin.y,width: self.frame.size.width + 2.0 * d,height: self.frame.size.height);
    }
    
    func expandSymmetrically(_ f:CGFloat){
        var  d:CGFloat = f;
        if(d < -(max(self.frame.size.width,self.frame.size.height))/2.0){
            d = -(max(self.frame.size.width,self.frame.size.height))/2.0;
        }
        
        if(d < -(min(self.frame.size.width,self.frame.size.height))/2.0){
            d = -(min(self.frame.size.width,self.frame.size.height))/2.0;
        }
        
        frame=CGRect(x: self.frame.origin.x - d,y: self.frame.origin.y-d,width: self.frame.size.width + 2.0 * d,height: self.frame.size.height + 2.0 * d);
    }
    
    func contractSymmetrically(_ d:CGFloat){
        expandSymmetrically(-d);
    }
    
    func expandSymmetricallyFactor(_ d:CGFloat){
        if(d<0){return;}
    
        frame=CGRect(x: self.frame.origin.x -  (self.frame.size.width  / 2.0) * (d - 1.0),y: self.frame.origin.y -  (self.frame.size.height / 2.0) * (d - 1.0),width: self.frame.size.width  * d,height: self.frame.size.height * d);
    }
    
    func contractSymmetricallyFactor(_ d:CGFloat){
        expandSymmetricallyFactor(1.0/d);
    }
    
    
    class func mutualAlignDown(_ views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){ return; }
        
        var maxBot:CGFloat = 0.0;
        
        for v in views!{
            if(v === views![0] || maxBot < v.frame.maxY){
                maxBot = v.frame.maxY;
            }
        }
        
        if(by == .stretching){
            for v in views!{
                v.stretchDown(maxBot - v.frame.maxY);
            }
        }else{
            for v in views!{
                v.moveDown(maxBot - v.frame.maxY);
            }
        }
    }
    
    class func mutualAlignUp(_ views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){
            return;
        }
    
        var minTop:CGFloat = 0.0;
    
        for v in views!{
            if(v === views![0] || minTop > v.frame.minY){
                minTop = v.frame.minY;
            }
        }
    
        if(by == .stretching){
            for v in views!{
                v.stretchUp(v.frame.minY - minTop);
            }
        }else{
            for v in views!{
                v.moveUp(v.frame.minY - minTop);
            }
        }
    }
    
    class func mutualAlignRight(_ views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){ return; }
    
        var maxRt:CGFloat = 0.0;
    
        for v in views!{
            if(v === views![0] || maxRt < v.frame.maxX){
                maxRt = v.frame.maxX;
            }
        }
    
        if(by == .stretching){
            for v in views!{
                v.stretchRight(maxRt - v.frame.maxX);
            }
        }else{
            for v in views!{
                v.moveRight(maxRt - v.frame.maxX);
            }
        }
    }
    
    class func mutualAlignLeft(_ views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){ return; }
    
        var minLft:CGFloat = 0.0;
    
        for v in views!{
            if(v === views![0] || minLft > v.frame.minX){
                minLft = v.frame.minX;
            }
        }
    
        if(by == .stretching){
            for v in views!{
                v.stretchLeft(v.frame.minX - minLft);
            }
        }else{
            for v in views!{
                v.moveLeft(v.frame.minX - minLft);
            }
        }
    }
    
    func setBottomLineForView(_ v:UIView, color:UIColor, height:CGFloat){
        frame=CGRect(x: v.frame.origin.x,y: v.frame.maxY,width: v.frame.size.width,height: height);
    
        backgroundColor = color;
    }
    
    func setBottomLineForView(_ v:UIView, color:UIColor){
        setBottomLineForView(v,color:color,height:2.0);
    }
    
    func clearBackground(){
        backgroundColor = UIColor.clear;
    }
    
    func extendsBeyondParent()->Bool{
        return !clearsParent();
    }
    
    func clearsParent()->Bool{
        return clearsParentWithMargin(0);
    }
    
    func clearsParentWithMargin(_ margin:CGFloat)->Bool{
        if(nil == superview){
            return false;
        }
        
        return self.frame.origin.x > margin && self.frame.origin.y > margin && self.superview!.frame.size.width - self.frame.maxX > margin && self.superview!.frame.size.height - self.frame.maxY > margin;
    }
    
    func clearsParentHorizontally()->Bool{
        return clearsParentHorizontallyWithMargin(0);
    }
    
    func clearsParentHorizontallyWithMargin(_ margin:CGFloat)->Bool{
        if(nil == superview){
            return false;
        }
        
        return self.frame.origin.x > margin && self.superview!.frame.size.width - self.frame.maxX > margin;
    }
   
    func clearsParentVertically()->Bool{
        return clearsParentVerticallyWithMargin(0);
    }
    
    func clearsParentVerticallyWithMargin(_ margin:CGFloat)->Bool{
        if(nil == superview){
            return false;
        }
        
        return self.frame.origin.y > margin && self.superview!.frame.size.height - self.frame.maxY > margin;
    }

    func overlapsHorizontally(_ v:UIView, margin:CGFloat)->Bool{
        return (self.frame.maxX - v.frame.minX > margin && v.frame.maxX - self.frame.minX > margin);
    }
    
    func overlapsHorizontally(_ v:UIView)->Bool{
        return overlapsHorizontally(v, margin:0);
    }
    
    func overlapsVertically(_ v:UIView, margin:CGFloat)->Bool{
        return (self.frame.maxY - v.frame.minY > margin && v.frame.maxY - self.frame.minY > margin);
    }
    
    func overlapsVertically(_ v:UIView)->Bool{
        return overlapsVertically(v, margin:0);
    }
    
    func overlaps(_ v:UIView, margin:CGFloat)->Bool{
        return overlapsHorizontally(v,margin:margin) && overlapsVertically(v, margin:margin);
    }
    
    func overlaps(_ v:UIView)->Bool{
        return overlapsHorizontally(v) && overlapsVertically(v);
    }
    
    func loadFromTemplate(_ v:UIView){
        for sv in v.subviews {
            sv.removeFromSuperview();
            addSubview(sv);
        }
        
        fill(v);
    }

    var bottomClearance:CGFloat{
        return (superview?.frame.height ?? 0) - frame.maxY;
    }

    var topClearance:CGFloat{
        return frame.minY;
    }

    var rightClearance:CGFloat{
        return (superview?.frame.width ?? 0) - frame.maxX;
    }
    
    var leftClearance:CGFloat{
    return frame.minX;
    }
}
