//
//  CustomAnimation.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 22/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation


class CustimAnimation : NSObject, UIViewControllerAnimatedTransitioning
{
    
    
func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.45
}

func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let containerView: UIView = transitionContext.containerView()!
    let originatingVC: UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    let destinationVC: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
    containerView.addSubview(destinationVC.view!)
    destinationVC.view.transform = CGAffineTransformMakeScale(0.01, 0.01)
    let duration: NSTimeInterval = self.transitionDuration(transitionContext)
    UIView.animateWithDuration(duration, animations: {() -> Void in
        destinationVC.view.transform = CGAffineTransformIdentity
        originatingVC.view.transform = self.transformForVC(originatingVC)
        }, completion: {(finished: Bool) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })
}

func transformForVC(VC: UIViewController) -> CGAffineTransform {
    if (VC is ViewController) {
        let scale: CGAffineTransform = CGAffineTransformMakeScale(0.1, 0.1)
        return CGAffineTransformRotate(scale, 2 * 1)
    }
    else {
        return CGAffineTransformMakeScale(0.1, 0.1)
    }
}
}