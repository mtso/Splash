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

    var lastPageLoaded = 1

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
        
        // Credits Label
        let labelMark = UILabel(frame: CGRect(x: 0, y: -30, width: view.frame.width, height: 20) )
        labelMark.textAlignment = .Center
        labelMark.text = "Made by Matthew Tso"
        collectionView?.addSubview(labelMark)
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
        
        if indexPath.row + 1 == photos.count {
            dataManager.getData(forPage: lastPageLoaded)
            lastPageLoaded += 1
        }
    }
    

    // MARK: Unwind Segue
    
    @IBAction func unwindFromPhoto(segue: UIStoryboardSegue) {
        
    }
    
}






