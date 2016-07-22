//
//  NavigationController.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 19/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation


class NavigationController:NSObject, UINavigationControllerDelegate {

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustimAnimation()
    }
}