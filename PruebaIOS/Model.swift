//
//  Model.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 19/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation


var shared: Model? = nil;

typealias requestCompletion = (data: [NSObject : AnyObject], error: NSError?) -> Void
class Model : NSObject{
    
    var availableCategories :Array? = Array<AnyObject>()
    var  filterEntries: Array? = Array<Application>()
    var  entries :Array? = Array<Application>()
    
    struct Static {
        static var dispatchOnceToken: dispatch_once_t = 0
    }
    class func sharedModel() -> Model {
        
        dispatch_once(&Static.dispatchOnceToken, {() -> Void in
            shared = self.init()
        })
        
        
        return shared!
    }
    
    required override init() {
        super.init()
        self.downloadApps()
    }
    
    
    func  downloadApps()
    {
        DataManager.getTopAppsDataFromItunesWithSuccess{(data) -> Void in
            var json: [String: AnyObject]!
            do {
               
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
                let topApps = TopApps(json: json)
                var catAvail :Set = Set<String>()
                for items in (topApps?.feed?.entries)!
                {
                    if (!catAvail.contains(items.category))
                    {
                        catAvail.insert(items.category)
                    }
                }
                    
                self.entries = topApps?.feed?.entries
                self.availableCategories = Array(catAvail.sort())
                self.saveJsonInCacheWithData(data, name:"posts.cache")
                
                NSNotificationCenter.defaultCenter().postNotificationName(Constants.NOTIFCACION_DATA, object: nil)
                
            } catch {
                print(error)
               
            }

        }
    }
    
    func filterEntriesWithCategory(category: String) {
        let filteringPredicate: NSPredicate = NSPredicate(format: "SELF == %@", category)
        self.filterEntries = self.entries?.filter{filteringPredicate.evaluateWithObject($0.category)}
      
    }
    
    
    func loadCache(){
        if(self.loadJsonFromCacheLibraryWithName("posts.cache") != nil)
        {
            var json: [String: AnyObject]!
            do {
            json = try NSJSONSerialization.JSONObjectWithData(self.loadJsonFromCacheLibraryWithName("posts.cache")!, options: NSJSONReadingOptions()) as? [String: AnyObject];
            let topApps = TopApps(json: json)
            var catAvail :Set = Set<String>()
            for items in (topApps?.feed?.entries)!
            {
                if (!catAvail.contains(items.category))
                {
                    catAvail.insert(items.category)
                }
            }
            self.entries = topApps?.feed?.entries
            self.availableCategories = Array(catAvail)
            NSNotificationCenter.defaultCenter().postNotificationName(Constants.NOTIFCACION_DATA, object: nil)
            
            
        }catch {
            print(error)
        }
  
        }
        else
        {
            self.entries = nil
            NSNotificationCenter.defaultCenter().postNotificationName(Constants.NOTIFCACION_DATA, object: nil ,userInfo: nil)
            
        }

    }
    
    func saveJsonInCacheWithData(data:NSData?, name: String) {
        
        
        if (data != nil) {
            data!.writeToFile(self.pathForFileName(name), atomically: true)
        }
    }
    
    func loadJsonFromCacheLibraryWithName(name: String) -> NSData? {
        
        let data = NSData(contentsOfFile: self.pathForFileName(name))
        if(data != nil)
        {
           return data
        }
        else
        {
        return nil
        }
    }
    
    
    func pathForFileName(name: String) -> String {
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        let documentsDirectory: String = paths[0] as! String
        return NSURL(fileURLWithPath: documentsDirectory).URLByAppendingPathComponent("/\(name)").relativePath!
    }
    
    
    
    //Funciones para guardar las imagenes en cache
    func saveImage(image: UIImage, AppID appID: String) {
        self.saveImageToCacheLibrary(image, name: appID)
    }
    
    func saveImageToCacheLibrary(image: UIImage?, name: String) {
        
        let name1:String = "\(name)\(".icon")"
        if image != nil {
            var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
            let documentsDirectory: String = paths[0] as! String
            let path: String? = NSURL(fileURLWithPath: documentsDirectory).URLByAppendingPathComponent("/\(name1)").relativePath
            let data: NSData = UIImagePNGRepresentation(image!)!
            data.writeToFile(path!, atomically: true)
        }
        
        
    }
    /*--------------------------------------*/
    
    
    func loadImageWithAppID(appID: String) -> UIImage? {
        return self.loadImageFromCacheLibraryWithName(appID)
    }
    
    
    func loadImageFromCacheLibraryWithName(name: String) -> UIImage? {
      
        let name1:String = "\(name)\(".icon")"
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        let documentsDirectory: String = paths[0] as! String
        let path: String = NSURL(fileURLWithPath: documentsDirectory).URLByAppendingPathComponent("/\(name1)").relativePath!
        let data = NSData(contentsOfFile: path)
        if data != nil
        {
        let image = UIImage(contentsOfFile: path)!
            return image
        }
        else
        {
        return nil
        }
    }
    
    
    
}