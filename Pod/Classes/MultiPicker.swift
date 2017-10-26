//
//  MultiPicker.swift
//  Pods
//
//  Created by Victor Lesk on 26/10/2017.
//

import UIKit

public class MultiPicker: UIView, UIScrollViewDelegate{
    public var delegate:MultiPickerDelegate?;
    
    public var originalView:UIView?
    
    var boolHasDoneButton = false;
    var doneButton:UIButton?;
    
    public var font:UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize);
    public var boldFont:UIFont = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize);
    public var darkBackgroundColor = UIColor.black;
    public var midBackgroundColor = UIColor.lightGray;
    public var lightBackgroundColor = UIColor.white;
    public var darkTextColor = UIColor.black;
    public var lightTextColor = UIColor.white;
    var column1ElementHeight:CGFloat = 50;
    
    var itemLabels = [String:InsetLabel]();
    
    var scrollViews = [UIScrollView]();

    var currentPickedItem:String?
    
    public var mainView:UIView;
    
    required public init?(coder aDecoder: NSCoder) {
        mainView = UIView(frame:CGRect(x: 0, y: 0, width: 0, height: 0));
        
        super.init(coder: aDecoder);
        
    }
    
    override public init(frame: CGRect) {
        mainView = UIView(frame:frame);
        mainView.clipsToBounds = true;
        
        super.init(frame:frame);
        
        addSubview(mainView);
        
        backgroundColor = UIColor.white.withAlphaComponent(0.7);
        alpha=0.0;
    }
    
    @objc private func itemTapHandler(g:UITapGestureRecognizer){
        guard let v = g.view else {return;}
        
        for (text,label) in itemLabels{
            if(label == v){
                self.setNeedsLayout();
                
                if(nil == doneButton){
                    delegate?.multiPicker(multiPicker: self, didReturnItem: 0, inColumn: 0);
                }
                return;
            }
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews();
        guard let delegate = delegate else { return; }
        
        let numberOfColumns = delegate.numberOfColumnsForMultiPicker(multiPicker: self);

        if(scrollViews.count != numberOfColumns){
            let columnWidth = CGFloat(1.0/CGFloat(numberOfColumns));
            
            for columnIndex in 0...numberOfColumns{
                let newScrollView = UIScrollView(frame:mainView.frame);
                mainView.addSubview(newScrollView);
                newScrollView.setWidth(columnWidth);
                newScrollView.alignParentLeftBy(.moving, margin:columnWidth * CGFloat(columnIndex));

                newScrollView.delegate = self;
                
                scrollViews.append(newScrollView);
            }
        }
        
        for (_,itemLabel) in itemLabels{
            itemLabel.removeFromSuperview();
        }
        
        itemLabels.removeAll();

        var lastView:UIView?

        let baseHeight:CGFloat = 30;
        
        for column in 0...numberOfColumns{
            let currentScrollView = scrollViews[column];
            let itemCount = delegate.numberOfItemsInColumn(column, forMultiPicker: self);
            
            lastView = nil;
            
            for item in 0...itemCount{
                let newItemLabel = InsetLabel(frame:currentScrollView.frame);
                currentScrollView.addSubview(newItemLabel);
                newItemLabel.font = boldFont;
                newItemLabel.text = delegate.multiPicker(multiPicker: self, textForItem: item, inColumn: column);
                newItemLabel.sizeToFit();
                newItemLabel.stretchHorizontallyToFillParent();
                newItemLabel.setHeight(delegate.multiPicker(multiPicker: self, heightFactorForItem: item, inColumn: column) * baseHeight);

                if let lastView = lastView{
                    newItemLabel.moveToBelow(lastView);
                }else{
                    newItemLabel.alignParentTopBy(.moving, margin:delegate.multiPicker(multiPicker: self, offsetForItem: 0, inColumn: column));
                }

                let string = "\(column).\(item)";
                
                itemLabels[string] = newItemLabel;
                if( currentPickedItem == string){
                    newItemLabel.backgroundColor = darkBackgroundColor;
                    newItemLabel.textColor = lightTextColor;
                }else{
                    newItemLabel.backgroundColor = lightBackgroundColor;
                    newItemLabel.textColor = darkTextColor;
                }

                newItemLabel.isUserInteractionEnabled = true;
                
                newItemLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemLabelTapHandler(g:))));
                
                lastView = newItemLabel;
            }

        }
    }
    
    public func show(){
        guard let delegate=delegate else {return;}
        self.removeFromSuperview();
        
        let inView = delegate.multiPickerContainerView;
        
        inView.addSubview(self);
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelHandler(g:))));
        mainView.isUserInteractionEnabled = true;
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelHandler(g:))));
        
        if let originalView = originalView {
            frame = originalView.frame ;
            self.stretchUp(-self.frame.size.height);
            mainView.fillParent();
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.fillParent();
            self.mainView.alignParentTopBy(.moving, margin: 100);
            self.mainView.stretchHorizontallyToFillParentWithMargin(inView.frame.width * 0.08);
            self.mainView.setHeight(200);
            self.alpha = 1.0;
        })
    }
    
    public func setStyle(font _font:UIFont,boldFont _boldFont:UIFont, darkBackgroundColor _darkBackgroundColor:UIColor, midBackgroundColor _midBackgroundColor:UIColor, lightBackgroundColor _lightBackgroundColor:UIColor, darkTextColor _darkTextColor:UIColor, lightTextColor _lightTextColor:UIColor,hasDoneButton _boolHasDoneButton:Bool){
        font = _font;
        boldFont = _boldFont;
        darkBackgroundColor = _darkBackgroundColor;
        midBackgroundColor = _midBackgroundColor;
        lightBackgroundColor = _lightBackgroundColor;
        darkTextColor = _darkTextColor;
        lightTextColor = _lightTextColor;
        boolHasDoneButton = _boolHasDoneButton;
    }
    
    @objc func cancelHandler(g:UIGestureRecognizer){
        if(g.view == self){
            delegate?.multiPickerCancelled(multiPicker: self);
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        for otherScrollView in scrollViews{
            if(scrollView != otherScrollView){
                otherScrollView.scrollTo(scrollView.contentOffset);
            }
        }
    }
    
    @objc func itemLabelTapHandler(g _g:UITapGestureRecognizer){
        guard let v = _g.view else {return;}
        
        for (itemString,itemLabel) in itemLabels{
            if(v == itemLabel){
                currentPickedItem = itemString;
                
                let components:[String] = currentPickedItem?.split(".") ?? ["-1","-1"];
                
                delegate?.multiPicker(multiPicker: self, didReturnItem: Int(components[1]) ?? -1, inColumn: Int(components[0]) ?? -1)
                
                return;
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
