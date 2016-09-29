//
//  PhotoViewController.swift
//  Splash
//
//  Created by Matthew Tso on 9/28/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var likeButton: UIBarButtonItem!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var navigationBarTitle: UINavigationItem!
    
    var imageUrl: String?
    var name: String?
    
    var zoomedInScale: CGFloat?
    
    var isImageLoaded = false
    
    var activityIndicator: UIActivityIndicatorView?
    
    var isNavigationBarHidden = false {
        didSet {
            if isNavigationBarHidden {
                navigationBar.hidden = true
                view.backgroundColor = .blackColor()
            } else {
                navigationBar.hidden = false
                view.backgroundColor = .whiteColor()
            }
//            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return isNavigationBarHidden ? true : false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.center = CGPoint(x: CGRectGetMidX(view.frame), y: CGRectGetMidY(view.frame))
        activityIndicator?.color = .grayColor()
        activityIndicator?.startAnimating()
        
        view.insertSubview(activityIndicator!, aboveSubview: scrollView)

        setGestureRecognizers()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if let imageUrl = self.imageUrl {
            let url = NSURL(string: imageUrl)
            
            imageView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.Fade(0.1))], progressBlock: nil, completionHandler: { Void in
                
                self.isImageLoaded = true
                self.activityIndicator?.stopAnimating()
                
                self.updateMinZoomScale(for: self.view.bounds.size)
                self.updateConstraints(for: self.view.bounds.size)
            })
        }
        if let name = self.name {
            navigationBarTitle.title = name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setGestureRecognizers() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.requireGestureRecognizerToFail(doubleTap)
        
        scrollView.addGestureRecognizer(longPress)
        scrollView.addGestureRecognizer(doubleTap)
        scrollView.addGestureRecognizer(singleTap)
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            saveImage()
        }
    }
    
    func handleDoubleTap(sender: UITapGestureRecognizer) {
        let location = sender.locationInView(imageView)
        toggleZoom(location)
    }
    
    func handleSingleTap(sender: UITapGestureRecognizer) {
        isNavigationBarHidden = !isNavigationBarHidden
    }
    
    func saveImage() {
        if let image = imageView.image {
            let actionSheet = UIAlertController(title: "Save to Camera Roll", message: nil, preferredStyle: .ActionSheet)
            
            let saveAction = UIAlertAction(title: "Save Image", style: .Default, handler: { Void in
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            actionSheet.addAction(saveAction)
            actionSheet.addAction(cancelAction)
            
            presentViewController(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func likeButtonClick(sender: AnyObject) {
        self.saveImage()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}