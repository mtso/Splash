//
//  CollectionViewCell.swift
//  Splash
//
//  Created by Matthew Tso on 9/28/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import AFNetworking

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    var data: PhotoModel? {
        didSet {
            getThumb(data!.thumbnailUrl!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: contentView.frame)
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getThumb(url: String) {
        
    }
}
