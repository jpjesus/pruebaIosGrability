//
//  AplicationDetailViewController.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 21/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation


class ApplicationDetailViewController : UIViewController {


    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblLegal: UILabel!
    @IBOutlet var imgApp: UIImageView!
    @IBOutlet var lblCategoria: UILabel!
    @IBOutlet var lblName: UILabel!
    var applicatioDetail:Application?
    @IBOutlet var TXVSummary: UITextView!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        self.lblName.text = applicatioDetail?.name
        self.lblCategoria.text = applicatioDetail?.category
        self.TXVSummary.text = applicatioDetail?.sumary
        self.lblLegal.text=applicatioDetail?.legal
        self.lblPrice.text=applicatioDetail?.price
        self.getAppIconWithURL((applicatioDetail?.images![2].images)!,AppID: (applicatioDetail?.appId)! )
        self.imgApp.layer.cornerRadius = 16
        self.imgApp.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toDonwloadURL(sender: AnyObject) {
        
        if (TARGET_OS_SIMULATOR == 0) {
            UIApplication.sharedApplication().openURL(NSURL(string:(self.applicatioDetail?.link)!)!)
        }
        else {
            UIAlertView(title: "Error", message: "Simulator can't open the AppStore, try on an actual device.", delegate: nil, cancelButtonTitle: "Return", otherButtonTitles: "").show()
        }
    }
    
    @IBAction func backToAppList(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goBackListApp", sender:self)
    }

    func getAppIconWithURL(url: String, AppID: String) {
        if (Model.sharedModel().loadImageWithAppID(AppID) != nil) {
            self.imgApp.image = Model.sharedModel().loadImageWithAppID(AppID)
        }
        else {
            if let url = NSURL(string: url) {
                let request = NSURLRequest(URL: url)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                    (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                    if let imageData = data as NSData? {
                        self.imgApp.image = UIImage(data: imageData)
                        Model.sharedModel().saveImage(self.imgApp.image!, AppID: AppID)
                    }
                }
            }
        }
    }
}