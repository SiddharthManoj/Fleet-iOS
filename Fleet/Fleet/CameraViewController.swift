//
//  Camera2ViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/9/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit
import MobileCoreServices
import MediaPlayer
import AVFoundation

class CameraViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        uploadVideos()
        //startCameraFromViewController(self, withDelegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func uploadVideos() {
        
        //parameters (user id (UID) and the actual data)
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let uuid = defaults.objectForKey("uuid") as! String
//        
//        let manager = NetworkingManager.videoSharedInstance.manager
//        
//        let url = NetworkingManager.videoBaseURLString + "mp4:sample.mp4/" + "playlist.m3u8"
//        
//        let fileURL = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("sample", ofType: "mp4")!)
//        
//        let parameters = [
//            "uuid": uuid,
//            "videoName":"sample",
//            "contentBody" : "Some body content for the test application",
//            "title" : "title of video",
//            "typeOfContent":"video"
//        ]
//        
//        manager.POST(url, parameters: parameters, constructingBodyWithBlock: { (data: AFMultipartFormData!) -> Void in
//            if let _ = try? data.appendPartWithFileURL(fileURL, name: "video_data") {
//                print("Appended video data")
//            }
//            else {
//                print("Could not append video data")
//            }
//            }, progress: nil, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
//                print("Successfully uploaded video")
//            }, failure: { (dataTask: NSURLSessionDataTask?, error: NSError) in
//                print("Failed to upload a video")
//            }
//        )
    }
    
    //create a manager. sharedInstance.video ->do post and get to stream

    // MARK: - UIImagePickerController methods

}
