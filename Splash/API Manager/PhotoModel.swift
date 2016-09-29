//
//  PhotoModel.swift
//  Splash
//
//  Created by Matthew Tso on 9/28/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit

class PhotoModel {
    
    var rawUrl: String?
    var thumbnailUrl: String?
    var name: String?
    
    init(rawUrl: String, thumbnailUrl: String, name: String) {
        self.rawUrl = rawUrl
        self.thumbnailUrl = thumbnailUrl
        self.name = name
    }
    
}