import UIKit

extension UIView{
 func centreHorizontallyInParent(){
    frame=CGRectMake(0.5 * (superview!.frame.size.width - self.frame.size.width),self.frame.origin.y,self.frame.size.width,self.frame.size.height);
 }
}
