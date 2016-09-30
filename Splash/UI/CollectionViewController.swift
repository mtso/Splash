//
//  CollectionViewController.swift
//  Splash
//
//  Created by Matthew Tso on 9/28/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "CollectionViewCell"

let ItemsPerLoad = 30 // (maximum allowed)
class CollectionViewController: UICollectionViewController, DataManagerDelegate {
    
    var photos = [PhotoModel]()
    
    let dataManager = DataManager()
    let kf = KingfisherManager()
    
    var lastPageLoaded = 1
    
    var clearCacheLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        dataManager.delegate = self
        dataManager.getData(forPage: lastPageLoaded)
        lastPageLoaded += 1
        
        // Credits View
        let creditsView = CreditsView(width: view.frame.width, bottomOffset: -30)
        collectionView?.addSubview(creditsView)
        
        clearCacheLabel = UILabel(frame: CGRect(x: 0, y: -164, width: view.frame.width, height: 20))
        clearCacheLabel!.font = UIFont.systemFontOfSize(UIFont.systemFontSize(), weight: UIFontWeightMedium)
        clearCacheLabel?.textColor = .redColor()
        clearCacheLabel?.alpha = 0.2
        clearCacheLabel?.textAlignment = .Center
        clearCacheLabel?.text = "Pull Down to Clear Cache"
        
        collectionView?.addSubview(clearCacheLabel!)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -195 {
            clearCacheLabel?.alpha = 1
            clearCacheLabel?.text = "Release to Clear Cache"
        } else {
            clearCacheLabel?.alpha = 0.2
            clearCacheLabel?.text = "Pull Down to Clear Cache"
        }
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.y < -195 {
            kf.cache.clearDiskCacheWithCompletionHandler({ Void in
                print("disk cleared")
                self.screenFlash()
            })
        }
    }
    
    func screenFlash() {
        let flashView = UIView(frame: view.frame)
        flashView.backgroundColor = .whiteColor()
        flashView.alpha = 0
        
        view.insertSubview(flashView, aboveSubview: collectionView!)
        
        UIView.animateWithDuration(0.2, animations: {
            flashView.alpha = 1
            }, completion: { Bool in
                UIView.animateWithDuration(0.2, animations: {
                    flashView.alpha = 0
                }, completion: { Bool in
                    flashView.removeFromSuperview()
                })
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushPhotoModels(photoModels: [PhotoModel]) {
        photos.appendContentsOf(photoModels)
        collectionView?.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowPhotoSegue" {
            
            let selectedRow = collectionView?.indexPathsForSelectedItems()?.first?.row
            let photo = photos[selectedRow!]
            
            let destination = segue.destinationViewController as! PhotoViewController
            destination.imageUrl = photo.rawUrl
            destination.name = photo.name
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
    
        // Configure the cell
        
        let photo = photos[indexPath.row]
        let urlString = photo.thumbnailUrl
        let url = NSURL(string: urlString!)
        
        
        cell.imageView.kf_indicatorType = .Activity
        cell.imageView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.Fade(0.1))], progressBlock: nil, completionHandler: nil)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("ShowPhotoSegue", sender: self)
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row + 7 > photos.count {
            dataManager.getData(forPage: lastPageLoaded)
            lastPageLoaded += 1
        }
    }
    
    // MARK: Unwind Segue
    
    @IBAction func unwindFromPhoto(segue: UIStoryboardSegue) {
        
    }
    
}






