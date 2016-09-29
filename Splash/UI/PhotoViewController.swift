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
    
    var isImageLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.barTintColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
                
        scrollView.delegate = self
        
        setGestureRecognizer()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if let imageUrl = self.imageUrl {
            let url = NSURL(string: imageUrl)
            
            imageView.kf_indicatorType = .Activity
            
            imageView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.Fade(0.1))], progressBlock: nil, completionHandler: { Void in
                
                self.isImageLoaded = true
                
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
    
    func setGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(saveImage))
        longPress.delegate = self
//        self.view.gestureRecognizers = [longPress]
        
//        imageView.gestureRecognizers = [longPress]
//        imageView.userInteractionEnabled = true
        
        scrollView.addGestureRecognizer(longPress)
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
            
            print("will present view controller")
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