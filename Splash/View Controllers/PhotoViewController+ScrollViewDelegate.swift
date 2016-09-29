//
//  PhotoViewController+ScrollViewDelegate.swift
//  Splash
//
//  Created by Matthew Tso on 9/29/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit

extension PhotoViewController: UIScrollViewDelegate {
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
