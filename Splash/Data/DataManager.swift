//
//  DataManager.swift
//  Splash
//
//  Created by Matthew Tso on 9/28/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import AFNetworking

protocol DataManagerDelegate {
    func pushPhotoModels(photoModels: [PhotoModel])
}

class DataManager {
    
    var delegate: DataManagerDelegate?
    
    let manager = AFHTTPSessionManager(baseURL: NSURL(string: "https://api.unsplash.com/") )
    
    init() {
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
    }
    
    func getData(forPage pageNumber: Int) {
        
        let clientId = "cfd0978593306a55d98b2ed41b174aed276da5a4f35a9d4dfd134fc2d654f817"
        
        manager.GET("photos/?client_id=" + clientId,
                    parameters: [ "page": pageNumber, "per_page" : ItemsPerLoad ],
                    progress: nil,
                    success: { task, data in
                        
                        var photoModels = [PhotoModel]()
                        
                        if let photoData = data as? NSArray {
                            for photo in photoData {
                                let photo = photo as! NSDictionary
                                
                                if let thumbnail = photo["urls"]!["thumb"] as? String,
                                   let rawUrl    = photo["urls"]!["raw"] as? String,
                                   let name      = photo["user"]!["name"] as? String {
                                    
                                    let photo = PhotoModel(rawUrl: rawUrl, thumbnailUrl: thumbnail, name: name)
                                    photoModels.append(photo)
                                    
                                }
                            }
                        }
                        
                        self.delegate?.pushPhotoModels(photoModels)
                    },
                    failure: { task, error in
                        print(error)
                    })
    }
}
