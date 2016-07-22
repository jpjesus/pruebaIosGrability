//
//  CategoriesCollectionViewController.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 19/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation


class CategoriesCollectionViewController : UICollectionViewController ,UIViewControllerTransitioningDelegate  {
    
    let reuseIdentifier: String = "CategoryCell"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return (Model.sharedModel().availableCategories?.count)!
     
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goTableView" {
            let toViewController = segue.destinationViewController as! UITableViewController
            toViewController.transitioningDelegate = self
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath : NSIndexPath)  {
        Model.sharedModel().filterEntriesWithCategory(Model.sharedModel().availableCategories![indexPath.row] as! String)
        self.performSegueWithIdentifier("toApplications", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(0, 60)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerView", forIndexPath: indexPath)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: CategoryCollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath:indexPath ) as! CategoryCollectionViewCell)
        cell.lblcategName.text = Model.sharedModel().availableCategories![indexPath.row] as? String

       cell.imgCateg.image=UIImage(named:Model.sharedModel().availableCategories![indexPath.row] as! String)!
         cell.layer.borderColor = UIColor(white: 0.9, alpha: 0).CGColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 4
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return  true
    }

    
    
    
}