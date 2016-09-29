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

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var navigationBarTitle: UINavigationItem!
    
    var imageUrl: String?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.barTintColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        imageView.contentMode = .ScaleAspectFit
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if let imageUrl = self.imageUrl {
            let url = NSURL(string: imageUrl)
            
            imageView.kf_indicatorType = .Activity
            imageView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.Fade(0.1))], progressBlock: nil, completionHandler: nil)

        }
        if let name = self.name {
            navigationBarTitle.title = name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
