//
//  CategoriesTableViewController.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 21/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation



class CategoriesTableViewController: UITableViewController,UIViewControllerTransitioningDelegate 
{
    let reuseIdentifier: String = "CategCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return (Model.sharedModel().availableCategories?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CategoryTableViewCell = (tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath:indexPath)) as! CategoryTableViewCell
        cell.imgCateg.image=UIImage(named:Model.sharedModel().availableCategories![indexPath.row] as! String)!
        cell.lblCategName.text=Model.sharedModel().availableCategories![indexPath.row] as? String
         cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        Model.sharedModel().filterEntriesWithCategory(Model.sharedModel().availableCategories![indexPath.row] as! String)
        self.performSegueWithIdentifier("toApplications", sender: self)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = (view as! UITableViewHeaderFooterView)
        let frame: CGRect = footer.contentView.frame
        let lbl: UILabel = UILabel(frame: frame)
        lbl.text = "Categorías"
        lbl.textAlignment = .Center
        footer.addSubview(lbl)
        lbl.backgroundColor = UIColor.whiteColor()
        footer.contentView.backgroundColor = UIColor.whiteColor()
    }

}