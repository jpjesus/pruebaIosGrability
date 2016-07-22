//
//  ViewController.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 18/07/16.
//  Copyright (c) 2016 Jesus Alberto. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var NetworkView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.sharedModel()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.loadData) , name:  Constants.NOTIFCACION_DATA , object:nil)
        self.NetworkView.hidden = true;
        
    }
    
    
    func loadData (notification: NSNotification?)
    {
        dispatch_async(dispatch_get_main_queue(), {
            if (Model.sharedModel().entries != nil)
            {
                if self.isiPad() {
                    
                    self.performSegueWithIdentifier("goCollectionView", sender: self)
                }
                    
                else
                {
                    self.performSegueWithIdentifier("goTableView", sender: self)
                }
                
            }
            else{
                Model.sharedModel().downloadApps()
                self.NetworkView.hidden = false;
                
            }
        })
        
    }
    
    @IBAction func tryAgainAction(sender: AnyObject) {
        self.NetworkView.hidden=true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct Static {
        static var token: dispatch_once_t = 0
        static var isIPad: Bool = false
    }
    func isiPad() -> Bool {
        
        dispatch_once(&Static.token, {() -> Void in
            Static.isIPad = UIDevice.currentDevice().userInterfaceIdiom == .Pad
        })
        return Static.isIPad
    }
 
}

