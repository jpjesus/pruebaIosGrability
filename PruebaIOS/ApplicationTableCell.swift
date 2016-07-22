//
//  ApplicationTableCell.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 20/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation



class ApplicationTableCell : UITableViewCell
{

    @IBOutlet var lblAppName: UILabel!
    @IBOutlet var imgApp: UIImageView!
    @IBOutlet var lblSummary: UILabel!
    
    var appID:String = ""
    
    override func awakeFromNib() {
  
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func downloadAppImageWithURL(urlStr: String) {
        
        if ((Model.sharedModel().loadImageWithAppID(self.appID)) != nil) {
            self.imgApp.image = Model.sharedModel().loadImageWithAppID(self.appID)
        }
        else
        {
            if let url = NSURL(string: urlStr) {
                let request = NSURLRequest(URL: url)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                    (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                    if let imageData = data as NSData? {
                        self.imgApp.image = UIImage(data: imageData)
                        Model.sharedModel().saveImage(self.imgApp.image!, AppID: self.appID)
                    }
                }
            }
        }
        
    }
    

    
    
}