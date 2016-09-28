//
//  ViewController.swift
//  Splash
//
//  Created by Matthew Tso on 9/28/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let clientUrl = "https://api.unsplash.com/photos/?client_id=cfd0978593306a55d98b2ed41b174aed276da5a4f35a9d4dfd134fc2d654f817"
        
        let manager = AFHTTPSessionManager() //(baseURL: NSURL(string: clientUrl))
        
//        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.GET(
            clientUrl,
            parameters: nil,
            success: { task, response in
                print("JSON: \(response?.description)")
            },
            failure: { task, error in
                print("ERROR: \(error.localizedDescription)")
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

