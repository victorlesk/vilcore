import Foundation
import UIKit

public enum MoveStretch{
    case MOVING,STRETCHING;
};

public enum EvenProp{
    case EVENLY,PROPORTIONALLY;
};

public extension UIView{
    
    func zeroFrame(){
        frame = CGRectMake(0,0,0,0);
    }
    
    func alignRight(v:UIView, by:MoveStretch){
        alignRight(v, by:by, margin:0.0);
    }
    
    func alignRight(v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .MOVING){
            frame=CGRectMake(v.frame.origin.x + v.frame.size.width - self.frame.size.width - margin, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
            frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, v.frame.origin.x + v.frame.size.width - self.frame.origin.x - margin, self.frame.size.height);
        }
    }
    
    func alignBottom(v:UIView,by:MoveStretch){
        alignBottom(v,by:by,margin:0.0);
    }
    
    func alignBottom(v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .MOVING){
            frame=CGRectMake(self.frame.origin.x,v.frame.origin.y + v.frame.size.height - self.frame.size.height - margin, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
            frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, v.frame.origin.y + v.frame.size.height - self.frame.origin.y - margin);
        }
    }
    
    func alignLeft(v:UIView,by:MoveStretch){
        alignLeft(v,by:by,margin:0.0)
    }
    
    func alignLeft(v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .MOVING){
            frame=CGRectMake(v.frame.origin.x + margin, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
            frame=CGRectMake(v.frame.origin.x + margin, self.frame.origin.y, self.frame.origin.x + self.frame.size.width - (v.frame.origin.x + margin), self.frame.size.height);
        }
    }
    
    func alignTop(v:UIView,by:MoveStretch){
        alignTop(v,by:by,margin:0.0);
    }
    
    func alignTop(v:UIView,by:MoveStretch,margin:CGFloat){
        if(by == .MOVING){
                frame=CGRectMake(self.frame.origin.x,v.frame.origin.y + margin, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
                frame=CGRectMake(self.frame.origin.x,v.frame.origin.y + margin, self.frame.size.width, self.frame.origin.y + self.frame.size.height - (v.frame.origin.y + margin));
        }
    }
    
    func alignTopRight(v:UIView,by:MoveStretch){
        alignTop  (v, by:by, margin:0);
        alignRight(v, by:by, margin:0);
    }
    
    func alignTopRight(v:UIView,by:MoveStretch,margin:CGFloat){
        alignTop  (v, by:by, margin:margin);
        alignRight(v, by:by, margin:margin);
    }
    
    func alignTopLeft(v:UIView,by:MoveStretch){
        alignTop (v, by:by, margin:0);
        alignLeft(v, by:by, margin:0);
    }
    
    func alignTopLeft(v:UIView, by:MoveStretch, margin:CGFloat){
        alignTop (v, by:by, margin:margin);
        alignLeft(v, by:by, margin:margin);
    }
    
    func alignBottomLeft(v:UIView,by:MoveStretch){
        alignBottom(v, by:by, margin:0);
        alignLeft  (v, by:by, margin:0);
    }
    
    func alignBottomLeft(v:UIView,by:MoveStretch,margin:CGFloat){
        alignBottom(v, by:by, margin:margin);
        alignLeft  (v, by:by, margin:margin);
    }
    
    func alignBottomRight(v:UIView,by:MoveStretch){
        alignBottom(v, by:by, margin:0);
        alignRight(v, by:by, margin:0);
    }
    
    func alignBottomRight(v:UIView,by:MoveStretch,margin:CGFloat){
        alignBottom(v, by:by, margin:margin);
        alignRight(v, by:by, margin:margin);
    }
    
    func horizontalAlign(v:UIView){
        horizontalAlign(v, margin:0);
    }
    
    func horizontalAlign(v:UIView, margin:CGFloat){
    if(CGRectGetMinX(self.frame) > CGRectGetMaxX(v.frame)){
        alignLeft (v, by:.STRETCHING, margin:margin);
        alignRight(v, by:.STRETCHING, margin:margin);
    }else{
        alignRight(v, by:.STRETCHING, margin:margin);
        alignLeft (v, by:.STRETCHING, margin:margin);
    }
    }
    
    func verticalAlign(v:UIView){
    verticalAlign(v, margin:0);
    }
    
    func verticalAlign(v:UIView, margin:CGFloat){
        if(CGRectGetMinY(self.frame) > CGRectGetMaxY(v.frame)){
            alignTop   (v, by:.STRETCHING, margin:margin);
            alignBottom(v, by:.STRETCHING, margin:margin);
        }else{
            alignBottom(v, by:.STRETCHING, margin:margin);
            alignTop   (v, by:.STRETCHING, margin:margin);
        }
    }
    
    func stretchHorizontallyToFillParentWithMargin(margin:CGFloat){
        alignParentRightBy(.STRETCHING, margin:margin);
        alignParentLeftBy (.STRETCHING, margin:margin);
    }
    
    func stretchHorizontallyToFillParent(){
        stretchHorizontallyToFillParentWithMargin(0);
    }
    
    func fill(v:UIView){
        fill(v, passedMargin:0);
    }
    
    func fill(v:UIView, passedMargin:CGFloat){
        let xMargin:CGFloat = (passedMargin * 2 > v.frame.size.width  ? v.frame.size.width  / 2 : passedMargin);
        let yMargin:CGFloat = (passedMargin * 2 > v.frame.size.height ? v.frame.size.height / 2 : passedMargin);
        
        self.frame = CGRectMake(v.frame.origin.x + xMargin, v.frame.origin.y + yMargin,
            v.frame.size.width - (xMargin * 2), v.frame.size.height - (yMargin * 2));
    }
    
    func stretchVerticallyToFillParentWithMargin(margin:CGFloat){
        alignParentTopBy   (.STRETCHING, margin:margin);
        alignParentBottomBy(.STRETCHING, margin:margin);
    }
    
    func stretchChildrenHorizontallyToFillWithMargin(margin:CGFloat){
        for v in subviews{
            v.stretchHorizontallyToFillParentWithMargin(margin);
        }
    }
    
    func stretchChildrenHorizontallyToFill(){
        stretchChildrenHorizontallyToFillWithMargin(0.0);
    }
    
    func stretchChildrenVerticallyToFillWithMargin(margin:CGFloat){
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
    
    func fillParentWithMargin(margin:CGFloat){
        stretchHorizontallyToFillParentWithMargin(margin);
        stretchVerticallyToFillParentWithMargin  (margin);
    }
    
    func stretchVerticallyToFillParent(){
        stretchVerticallyToFillParentWithMargin(0);
    }
    
    func centreHorizontallyIn(v:UIView){
        frame=CGRectMake(v.frame.origin.x + 0.5 * (v.frame.size.width - self.frame.size.width),self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    }
    
    func centreVerticallyIn(v:UIView){
        frame=CGRectMake(self.frame.origin.x,v.frame.origin.y + 0.5 * (v.frame.size.height - self.frame.size.height),self.frame.size.width,self.frame.size.height);
    }
    
    func centreIn(v:UIView){
        frame=CGRectMake(v.frame.origin.x + 0.5 * (v.frame.size.width - self.frame.size.width),v.frame.origin.y + 0.5 * (v.frame.size.height - self.frame.size.height),self.frame.size.width,self.frame.size.height);
    }
    
    func centreHorizontallyInParent(){
        frame=CGRectMake(0.5 * (superview!.frame.size.width - self.frame.size.width),self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    }
    
    func centreVerticallyInParent(){
        frame=CGRectMake(self.frame.origin.x, 0.5 * (superview!.frame.size.height - self.frame.size.height),self.frame.size.width,self.frame.size.height);
    }
    
    
    func centreInParent(){
        frame=CGRectMake(superview!.frame.origin.x + 0.5 * (superview!.frame.size.width - self.frame.size.width),superview!.frame.origin.y + 0.5 * (superview!.frame.size.height - self.frame.size.height),self.frame.size.width,self.frame.size.height);
    }
    
    func alignParentTopBy(by:MoveStretch){
        alignParentTopBy(by,margin:0);
    }
    
    func alignParentTopBy(by:MoveStretch, margin:CGFloat){
        if(by == .MOVING){
            frame=CGRectMake(self.frame.origin.x,margin, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
            frame=CGRectMake(self.frame.origin.x,margin, self.frame.size.width, self.frame.origin.y + self.frame.size.height - margin);
        }
    }
    
    func alignParentBottomBy(by:MoveStretch){
        alignParentBottomBy(by, margin:0);
    }
    
    func alignParentBottomBy(by:MoveStretch, margin:CGFloat){
        if(by == .MOVING){
            frame=CGRectMake(self.frame.origin.x,superview!.frame.size.height - self.frame.size.height - margin, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
            frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, superview!.frame.size.height - self.frame.origin.y - margin);
        }
    }
    
    func alignParentLeftBy(by:MoveStretch){
        alignParentLeftBy(by, margin:0);
    }
    
    func alignParentLeftBy(by:MoveStretch, margin:CGFloat){
        if(by == .MOVING){
            frame=CGRectMake(margin, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
            frame=CGRectMake(margin, self.frame.origin.y, self.frame.origin.x + self.frame.size.width - margin, self.frame.size.height);
        }
    }
    
    
    func alignParentRightBy(by:MoveStretch){
        alignParentRightBy(by, margin:0);
    }
    
    func alignParentRightBy(by:MoveStretch, margin:CGFloat){
        if(by == .MOVING){
            frame=CGRectMake(superview!.frame.size.width - self.frame.size.width - margin, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        }else if(by == .STRETCHING){
            frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, superview!.frame.size.width - self.frame.origin.x - margin, self.frame.size.height);
        }
    }
    
    func alignParentTopRightBy(by:MoveStretch){
        alignParentTopRightBy(by, margin:0.0);
    }
    
    func alignParentTopRightBy(by:MoveStretch, margin:CGFloat){
        alignParentTopBy  (by, margin:margin);
        alignParentRightBy(by, margin:margin);
    }
    
    func alignParentBottomRightBy(by:MoveStretch){
        alignParentBottomRightBy(by,margin:0.0);
    }
    
    func alignParentBottomRightBy(by:MoveStretch, margin:CGFloat){
        alignParentBottomBy(by, margin:margin);
        alignParentRightBy (by, margin:margin);
    }
    
    func alignParentBottomLeftBy(by:MoveStretch){
        alignParentBottomLeftBy(by, margin:0.0);
    }
    
    func alignParentBottomLeftBy(by:MoveStretch, margin:CGFloat){
        alignParentBottomBy(by, margin:margin);
        alignParentLeftBy  (by, margin:margin);
    }
    
    func alignParentTopLeftBy(by:MoveStretch){
        alignParentTopLeftBy(by, margin:0.0);
    }
    
    func alignParentTopLeftBy(by:MoveStretch,margin:CGFloat){
        alignParentTopBy (by, margin:margin);
        alignParentLeftBy(by, margin:margin);
    }
    
    
    func moveToBelow(v:UIView){
        moveToBelow(v, margin:0);
    }
    
    func moveToBelow(v:UIView, margin:CGFloat){
        frame=CGRectMake(self.frame.origin.x,CGRectGetMaxY(v.frame) + margin,self.frame.size.width,self.frame.size.height);
    }
    
    func moveToAbove(v:UIView){
        moveToAbove(v, margin:0);
    }
    
    func moveToAbove(v:UIView, margin:CGFloat){
        frame=CGRectMake(self.frame.origin.x,v.frame.origin.y - margin - self.frame.size.height,self.frame.size.width,self.frame.size.height);
    }
    
    func moveToLeftOf(v:UIView){
        moveToLeftOf(v, margin:0);
    }
    
    func moveToLeftOf(v:UIView, margin:CGFloat){
        frame=CGRectMake(v.frame.origin.x - margin - self.frame.size.width,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    }
    
    func moveToRightOf(v:UIView){
        moveToRightOf(v, margin:0);
    }
    
    func moveToRightOf(v:UIView, margin:CGFloat){
        frame=CGRectMake(CGRectGetMaxX(v.frame) + margin,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    }
    
    
    func stretchToBelow(v:UIView){
        stretchToBelow(v, margin:0);
    }
    
    func stretchToBelow(v:UIView, margin:CGFloat){
        frame=CGRectMake(self.frame.origin.x,CGRectGetMaxY(v.frame) + margin,self.frame.size.width,CGRectGetMaxY(self.frame) - CGRectGetMaxY(v.frame) - margin);
    }
    
    func stretchToAbove(v:UIView){
        stretchToAbove(v, margin:0);
    }
    
    func stretchToAbove(v:UIView, margin:CGFloat){
    frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,v.frame.origin.y - margin - self.frame.origin.y);
    }
    
    func stretchToLeftOf(v:UIView){
    stretchToLeftOf(v, margin:0);
    }
    
    func stretchToLeftOf(v:UIView, margin:CGFloat){
    frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,v.frame.origin.x - margin - self.frame.origin.x,self.frame.size.height);
    }
    
    func stretchToRightOf(v:UIView){
    stretchToRightOf(v, margin:0);
    }
    
    func stretchToRightOf(v:UIView, margin:CGFloat){
    frame=CGRectMake(CGRectGetMaxX(v.frame) + margin,self.frame.origin.y,CGRectGetMaxX(self.frame) - CGRectGetMaxX(v.frame) - margin, self.frame.size.height);
    }
    
    func moveLeft(d:CGFloat){
        frame=CGRectMake(self.frame.origin.x - d, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    
    func moveRight(d:CGFloat){
        moveLeft(-d);
    }
    
    func moveUp(d:CGFloat){
        frame=CGRectMake(self.frame.origin.x, self.frame.origin.y - d, self.frame.size.width, self.frame.size.height);
    }
    
    func moveDown(d:CGFloat){
        moveUp(-d);
    }
    
    func stretchLeft(d:CGFloat){
        frame=CGRectMake(self.frame.origin.x - d, self.frame.origin.y, self.frame.size.width + d, self.frame.size.height);
    }
   
    func stretchRight(d:CGFloat){
        frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + d, self.frame.size.height);
    }
    
    func stretchUp(d:CGFloat){
        frame=CGRectMake(self.frame.origin.x, self.frame.origin.y - d, self.frame.size.width, self.frame.size.height + d);
    }
    
    func stretchDown(d:CGFloat){
        frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + d);
    }
    
    func setWidth(d:CGFloat){
        stretchRight(d - self.frame.size.width);
    }
    
    func setHeight(d:CGFloat){
        stretchDown(d - self.frame.size.height);
    }
    
    func setWidthOfParent(d:CGFloat){
        setWidth(superview!.frame.size.width * d);
    }
    
    func setHeightOfParent(d:CGFloat){
        setHeight(superview!.frame.size.height * d);
    }
    
    func setWidthToHeight(r:CGFloat){
        setWidth(self.frame.size.height * r) ;
    }
    
    func setHeightToWidth(r:CGFloat){
        setHeight(self.frame.size.width * r) ;
    }
    
    func layoutSubviewsHorizontallyDistributingExtraSpace(epEnum:EvenProp){
        layoutSubviewsHorizontallyDistributingExtraSpace(epEnum,margin:0);
    }
    
    func layoutSubviewsHorizontallyDistributingExtraSpace(epEnum:EvenProp, margin:CGFloat){
        var totalWidth:CGFloat = 0.0;
    
        for v in subviews{
            totalWidth += v.frame.size.width;
        }
    
        let excessWidth:CGFloat = self.frame.size.width - (2.0 * margin) - totalWidth;
        let excessWidthPerSubview:CGFloat = excessWidth / ((CGFloat)(subviews.count));
        
        var lastView:UIView?;
        
        for v in subviews{
            v.stretchRight((epEnum == .EVENLY ? excessWidthPerSubview : excessWidth * ( v.frame.size.width / totalWidth )));
        
            if(nil == lastView){
                v.alignParentLeftBy(.MOVING,margin:margin);
            }else{
                v.moveToRightOf(lastView!);
            }

            lastView = v;
        }
    }
    
    func layoutSubviewsVerticallyDistributingExtraSpace(epEnum:EvenProp){
        layoutSubviewsVerticallyDistributingExtraSpace(epEnum, margin:0);
    }
    
    func layoutSubviewsVerticallyDistributingExtraSpace(epEnum:EvenProp, margin:CGFloat){
        var totalHeight:CGFloat = 0.0;
        
        for v in subviews{
            totalHeight += v.frame.size.height;
        }
        
        let excessHeight:CGFloat = self.frame.size.height - (2.0 * margin) - totalHeight;
        let excessHeightPerSubview:CGFloat = excessHeight / ((CGFloat)(subviews.count));
        
        var lastView:UIView?
        
        for v in subviews{
            v.stretchDown((epEnum == .EVENLY ? excessHeightPerSubview : excessHeight * ( v.frame.size.height / totalHeight )));
            
            if(lastView == nil){
                v.alignParentTopBy(.MOVING, margin:margin);
            }else{
                v.moveToBelow(lastView!);
            }
        lastView = v;
        }
    }
    
    func layoutSubviewsHorizontallyEvenly(){
        layoutSubviewsHorizontallyEvenlyWithMargin(0.0);
    }
    
    func layoutSubviewsHorizontallyEvenlyWithMargin(margin:CGFloat){
        let subviewWidth:CGFloat = (self.frame.size.width - 2.0 * margin)/((CGFloat)(subviews.count));
    
        var lastView:UIView?;
    
        for v in subviews{
            v.setWidth(subviewWidth);
        
            if(lastView == nil){
                v.alignParentLeftBy(.MOVING, margin:margin);
            }else{
                v.moveToRightOf(lastView!);
            }
        lastView = v;
        }
    }
    
    func layoutSubviewsVerticallyEvenly(){
        layoutSubviewsVerticallyEvenlyWithMargin(0.0);
    }
    
    func layoutSubviewsVerticallyEvenlyWithMargin(margin:CGFloat){
        let subviewHeight:CGFloat = (self.frame.size.height - 2.0 * margin)/((CGFloat)(subviews.count));
        
        var lastView:UIView?;
        
        for v in subviews {
            v.setHeight(subviewHeight);
        
            if(lastView == nil){
                v.alignParentTopBy(.MOVING, margin:margin);
            }else{
                v.moveToBelow(lastView!)
            }
        lastView = v;
        }
    }
    
    func hugChildrenHorizontally(){
        hugChildrenHorizontallyWithMargin(0.0);
    }
    
    func hugChildrenHorizontallyWithMargin(margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
    
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = CGRectUnion(unionRect, v.frame);
            }
        
        }
        
        self.frame = CGRectMake(self.frame.origin.x + unionRect.origin.x - margin,self.frame.origin.y,unionRect.size.width + 2.0*margin,self.frame.size.height);
        
        for v in subviews{
            v.moveLeft(unionRect.origin.x - margin);
        }
    }
    
    func hugChildrenVertically(){
        hugChildrenVerticallyWithMargin(0.0);
    }
    
    func hugChildrenVerticallyWithMargin(margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
    
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = CGRectUnion(unionRect, v.frame);
            }
        }
        
        self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y + unionRect.origin.y - margin,self.frame.size.width,unionRect.size.height + 2.0*margin);
        
        for v in subviews{
            v.moveUp(unionRect.origin.y - margin);
        }
    }
    
    func hugChildren(){
        hugChildrenWithMargin(0.0);
    }
    
    func hugChildrenWithMargin(margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
    
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = CGRectUnion(unionRect, v.frame);
            }
            
        }
        
        self.frame = CGRectMake(self.frame.origin.x + unionRect.origin.x - margin,self.frame.origin.y + unionRect.origin.y - margin,unionRect.size.width + 2.0*margin,unionRect.size.height + 2.0*margin);
        
        for v in subviews{
            v.moveLeft(unionRect.origin.x - margin);
            v.moveUp  (unionRect.origin.y - margin);
        }
    }
    
    
    func hugChildrenTop(){
        hugChildrenTopWithMargin(0);
    }
    
    func hugChildrenTopWithMargin(margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = CGRectUnion(unionRect, v.frame);
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
    
    func hugChildrenBottomWithMargin(margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = CGRectUnion(unionRect, v.frame);
            }
        }
        
        stretchDown((CGRectGetMaxY(unionRect) + margin) - self.frame.size.height);
    }
    
    func hugChildrenLeft(){
        hugChildrenLeftWithMargin(0);
    }
    
    func hugChildrenLeftWithMargin(margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews {
            if(v !== subviews[0]){
                unionRect = CGRectUnion(unionRect, v.frame);
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
    
    func hugChildrenRightWithMargin(margin:CGFloat){
        if(subviews.count == 0){
            return;
        }
        
        var unionRect:CGRect = subviews[0].frame;
        
        for v in subviews{
            if(v !== subviews[0]){
                unionRect = CGRectUnion(unionRect, v.frame);
            }
        }
        
        stretchRight((CGRectGetMaxX(unionRect) + margin) - self.frame.size.width);
        
    }
    
    func hugChildrenTopLeft(){
        hugChildrenTop();
        hugChildrenLeft();
    }
    
    func hugChildrenTopLeftWithMargin(margin:CGFloat){
        hugChildrenTopWithMargin(margin);
        hugChildrenLeftWithMargin(margin);
    }
    
    func hugChildrenBottomRight(){
        hugChildrenBottom();
        hugChildrenRight();
    }
    
    func hugChildrenBottomRightWithMargin(margin:CGFloat){
        hugChildrenBottomWithMargin(margin);
        hugChildrenRightWithMargin(margin);
    }
    
    func hugChildrenBottomLeft(){
        hugChildrenBottom();
        hugChildrenLeft();
    }
    
    func hugChildrenBottomLeftWithMargin(margin:CGFloat){
        hugChildrenBottomWithMargin(margin);
        hugChildrenLeftWithMargin(margin);
    }
    
    func hugChildrenTopRight(){
        hugChildrenTop();
        hugChildrenRight();
    }
    
    func hugChildrenTopRightWithMargin(margin:CGFloat){
        hugChildrenTopWithMargin(margin);
        hugChildrenLeftWithMargin(margin);
    }
    
    func widenSymmetrically(d:CGFloat){
        frame=CGRectMake(self.frame.origin.x - d,self.frame.origin.y,self.frame.size.width + 2.0 * d,self.frame.size.height);
    }
    
    func expandSymmetrically(f:CGFloat){
        var  d:CGFloat = f;
        if(d < -(max(self.frame.size.width,self.frame.size.height))/2.0){
            d = -(max(self.frame.size.width,self.frame.size.height))/2.0;
        }
        
        if(d < -(min(self.frame.size.width,self.frame.size.height))/2.0){
            d = -(min(self.frame.size.width,self.frame.size.height))/2.0;
        }
        
        frame=CGRectMake(self.frame.origin.x - d,self.frame.origin.y-d,self.frame.size.width + 2.0 * d,self.frame.size.height + 2.0 * d);
    }
    
    func contractSymmetrically(d:CGFloat){
        expandSymmetrically(-d);
    }
    
    func expandSymmetricallyFactor(d:CGFloat){
        if(d<0){return;}
    
        frame=CGRectMake(self.frame.origin.x -  (self.frame.size.width  / 2.0) * (d - 1.0),self.frame.origin.y -  (self.frame.size.height / 2.0) * (d - 1.0),self.frame.size.width  * d,self.frame.size.height * d);
    }
    
    func contractSymmetricallyFactor(d:CGFloat){
        expandSymmetricallyFactor(1.0/d);
    }
    
    
    class func mutualAlignDown(views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){ return; }
        
        var maxBot:CGFloat = 0.0;
        
        for v in views!{
            if(v === views![0] || maxBot < CGRectGetMaxY(v.frame)){
                maxBot = CGRectGetMaxY(v.frame);
            }
        }
        
        if(by == .STRETCHING){
            for v in views!{
                v.stretchDown(maxBot - CGRectGetMaxY(v.frame));
            }
        }else{
            for v in views!{
                v.moveDown(maxBot - CGRectGetMaxY(v.frame));
            }
        }
    }
    
    class func mutualAlignUp(views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){
            return;
        }
    
        var minTop:CGFloat = 0.0;
    
        for v in views!{
            if(v === views![0] || minTop > CGRectGetMinY(v.frame)){
                minTop = CGRectGetMinY(v.frame);
            }
        }
    
        if(by == .STRETCHING){
            for v in views!{
                v.stretchUp(CGRectGetMinY(v.frame) - minTop);
            }
        }else{
            for v in views!{
                v.moveUp(CGRectGetMinY(v.frame) - minTop);
            }
        }
    }
    
    class func mutualAlignRight(views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){ return; }
    
        var maxRt:CGFloat = 0.0;
    
        for v in views!{
            if(v === views![0] || maxRt < CGRectGetMaxX(v.frame)){
                maxRt = CGRectGetMaxX(v.frame);
            }
        }
    
        if(by == .STRETCHING){
            for v in views!{
                v.stretchRight(maxRt - CGRectGetMaxX(v.frame));
            }
        }else{
            for v in views!{
                v.moveRight(maxRt - CGRectGetMaxX(v.frame));
            }
        }
    }
    
    class func mutualAlignLeft(views:[UIView]?, by:MoveStretch){
        if(nil == views || views!.count<2){ return; }
    
        var minLft:CGFloat = 0.0;
    
        for v in views!{
            if(v === views![0] || minLft > CGRectGetMinX(v.frame)){
                minLft = CGRectGetMinX(v.frame);
            }
        }
    
        if(by == .STRETCHING){
            for v in views!{
                v.stretchLeft(CGRectGetMinX(v.frame) - minLft);
            }
        }else{
            for v in views!{
                v.moveLeft(CGRectGetMinX(v.frame) - minLft);
            }
        }
    }
    
    func setBottomLineForView(v:UIView, color:UIColor, height:CGFloat){
        frame=CGRectMake(v.frame.origin.x,CGRectGetMaxY(v.frame),v.frame.size.width,height);
    
        backgroundColor = color;
    }
    
    func setBottomLineForView(v:UIView, color:UIColor){
        setBottomLineForView(v,color:color,height:2.0);
    }
    
    func clearBackground(){
        backgroundColor = UIColor.clearColor();
    }
    
    func extendsBeyondParent()->Bool{
        return !clearsParent();
    }
    
    func clearsParent()->Bool{
        return clearsParentWithMargin(0);
    }
    
    func clearsParentWithMargin(margin:CGFloat)->Bool{
        if(nil == superview){
            return false;
        }
        
        return self.frame.origin.x > margin && self.frame.origin.y > margin && CGRectGetMaxX(self.superview!.frame) - CGRectGetMaxX(self.frame) > margin && CGRectGetMaxY(superview!.frame) - CGRectGetMaxY(self.frame) > margin;
    }
    
    func overlapsHorizontally(v:UIView, margin:CGFloat)->Bool{
    return (CGRectGetMaxX(self.frame) - CGRectGetMinX(v.frame) > margin && CGRectGetMaxX(v.frame) - CGRectGetMinX(self.frame) > margin);
    }
    
    func overlapsHorizontally(v:UIView)->Bool{
        return overlapsHorizontally(v, margin:0);
    }
    
    func overlapsVertically(v:UIView, margin:CGFloat)->Bool{
        return (CGRectGetMaxY(self.frame) - CGRectGetMinY(v.frame) > margin && CGRectGetMaxY(v.frame   ) - CGRectGetMinY(self.frame) > margin);
    }
    
    func overlapsVertically(v:UIView)->Bool{
        return overlapsVertically(v, margin:0);
    }
    
    func overlaps(v:UIView, margin:CGFloat)->Bool{
        return overlapsHorizontally(v,margin:margin) && overlapsVertically(v, margin:margin);
    }
    
    func overlaps(v:UIView)->Bool{
        return overlapsHorizontally(v) && overlapsVertically(v);
    }
}
