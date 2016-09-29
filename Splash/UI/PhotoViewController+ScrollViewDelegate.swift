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

    func updateMinZoomScale(for size: CGSize) {
        guard isImageLoaded == true else { return }
        guard let imageWidth = imageView.image?.size.width,
              let imageHeight = imageView.image?.size.height else { return }
        
        let widthScale = size.width / imageWidth
        let heightScale = size.height / imageHeight
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScale(for: view.bounds.size)
    }

    func updateConstraints(for size: CGSize) {
        guard isImageLoaded == true else { return }

        let displayWidth = imageView.layer.frame.width
        let displayHeight = imageView.layer.frame.height
        
        let xOffset = max(0, (size.width - displayWidth) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset

        let yOffset = max(0, (size.height - displayHeight) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        view.layoutIfNeeded()
    }

    func scrollViewDidZoom(scrollView: UIScrollView) {
        updateConstraints(for: view.bounds.size)
    }
}

//extension PhotoViewController: UIGestureRecognizerDelegate {

//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if otherGestureRecognizer.isKindOfClass(UILongPressGestureRecognizer) {
//            print("long pressed")
//            return true
//        }
//        return false
//    }
//}