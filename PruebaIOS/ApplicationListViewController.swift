//
//  ApplicationListViewController.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 20/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation

class ApplicationListViewController : UIViewController , UITableViewDelegate , UITableViewDataSource ,UIViewControllerTransitioningDelegate 
{
    let reuseIdentifier:String = "ApplicationTabCell"
     var currentIndexPath: NSIndexPath?
    @IBOutlet var lblCategTitle: UILabel!
    @IBOutlet var tblApplications: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblCategTitle.text = Model.sharedModel().filterEntries?.first!.category
        self.tblApplications.delegate = self
        self.tblApplications.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Model.sharedModel().filterEntries?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ApplicationTableCell = (tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ApplicationTableCell)
        cell.lblAppName.text = Model.sharedModel().filterEntries![indexPath.row].name
        cell.lblSummary.text = Model.sharedModel().filterEntries![indexPath.row].sumary
        cell.appID = Model.sharedModel().filterEntries![indexPath.row].appId
        cell.imgApp.image = UIImage(named: "AppPlaceholder")!
        cell.imgApp.layer.cornerRadius = 8
        cell.imgApp.layer.masksToBounds = true
       
        cell.downloadAppImageWithURL(Model.sharedModel().filterEntries![indexPath.row].images![2].images)
        cell.accessoryType = .DisclosureIndicator
        return cell
    }

    func segueNameForCurrentDevice() -> String {
        return self.isiPad() ? "goCategoryGrid" : "goCategoryList"
    }
    
 func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        self.performSegueWithIdentifier("goAppDetail", sender: self)
    }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController is ApplicationDetailViewController) {
            let dvc: ApplicationDetailViewController = (segue.destinationViewController as! ApplicationDetailViewController)
            currentIndexPath = self.tblApplications.indexPathForSelectedRow

            dvc.applicatioDetail = Model.sharedModel().filterEntries![currentIndexPath!.row]
        }
    }
    
    
    @IBAction func goBackToCategories(sender: AnyObject) {
        
        self.performSegueWithIdentifier(self.segueNameForCurrentDevice(), sender: self)
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