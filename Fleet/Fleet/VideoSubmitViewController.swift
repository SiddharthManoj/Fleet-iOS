//
//  VideoSubmitViewController.swift
//  Fleet
//
//  Created by Rahul Madduluri on 4/19/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit
import MobileCoreServices
import MediaPlayer
import AVFoundation

class VideoSubmitViewController: UIViewController
{
    var fileURL = NSURL()
    
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255

    var tag1TextField: UITextField!
    var tag1Label: UILabel!
    var tag1Placeholder: NSMutableAttributedString!
    var publishButton: UIButton!
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    func _uploadVideos() {
        
        //parameters (user id (UID) and the actual data)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let uuid = defaults.objectForKey("uuid") as! String
        
        let manager = NetworkingManager.videoSharedInstance.manager
        
        let url = NetworkingManager.videoBaseURLString + "mp4:sample.mp4/" + "playlist.m3u8"
        
        let parameters = [
            "uuid": uuid,
            "videoName":"sample",
            "contentBody" : "Some body content for the test application",
            "title" : "title of video",
            "typeOfContent":"video"
        ]
        
        manager.POST(url, parameters: parameters, constructingBodyWithBlock: { (data: AFMultipartFormData!) -> Void in
            if let _ = try? data.appendPartWithFileURL(self.fileURL, name: "video_data") {
                print("Appended video data")
            }
            else {
                print("Could not append video data")
            }
            }, progress: nil, success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                print("Successfully uploaded video")
            }, failure: { (dataTask: NSURLSessionDataTask?, error: NSError) in
                print("Failed to upload a video")
            }
        )
    }
}
