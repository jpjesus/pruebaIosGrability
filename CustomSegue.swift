//
//  CustomSegue.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 21/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    
    override func perform() {
        let sourceVC = self.sourceViewController
        let destination = self.destinationViewController
        
        sourceVC.view.addSubview(destination.view)
        destination.view.transform = CGAffineTransformMakeScale(0.05, 0.05)
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            destination.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (finished) -> Void in
                
               destination.view.removeFromSuperview()
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0 * Double(NSEC_PER_MSEC)))
                
                dispatch_after(time, dispatch_get_main_queue()) {
                
                    
                   sourceVC.presentViewController(destination, animated: false ,completion: nil)
                
                }


        }
    }

    
}
