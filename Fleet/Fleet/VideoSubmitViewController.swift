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

class VideoSubmitViewController: UIViewController, UITextFieldDelegate
{
    var fileURL = NSURL()
    
    //colors
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    //font
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"

    var tag1Label: UILabel!
    var tag2Label: UILabel!
    var tag1TextField: UITextField!
    var tag1Placeholder: NSMutableAttributedString!
    var tag2TextField: UITextField!
    var tag2Placeholder: NSMutableAttributedString!

    var publishButton: UIButton!
    
    //positions
    var publishXPos: CGFloat = 60
    var publishYPos: CGFloat = 480
    var publishWidth: CGFloat = 260
    var publishHeight: CGFloat = 50
    
    var textFieldXPos: CGFloat = 80
    var textFieldWidth: CGFloat = 300
    var textFieldHeight: CGFloat = 40
    
    var tag1FieldYPos: CGFloat = 280
    var tag2FieldYPos: CGFloat = 340
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor

        self._addTagFields()
        self._addPublishButton()
    }
    
    // MARK: - UITextField methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Internal methods
    
    func publishPressed(sender: UIButton!)
    {
        if (!self.tag1TextField.text!.isEmpty && !self.tag2TextField.text!.isEmpty) {
            self._uploadVideos()
        }
    }
    
    func tag1Pressed(sender: UITextField!)
    {
        UIView.animateWithDuration(0.5, animations: {
            self.tag1Label.center = CGPointMake(38, 20)
            self.tag1Label.alpha = 1
        })
    }
    
    func tag2Pressed(sender: UITextField!)
    {
        UIView.animateWithDuration(0.5, animations: {
            self.tag2Label.center = CGPointMake(38, 20)
            self.tag2Label.alpha = 1
        })
    }
    
    // MARK: - Private methods
    
    private func _addTagFields()
    {
        self.tag1TextField = UITextField(frame: CGRect(x: self.view.center.x - self.textFieldWidth/2, y: self.tag1FieldYPos, width: self.textFieldWidth, height: self.textFieldHeight))
        self.tag1TextField.font = UIFont(name: self.quicksandReg, size: 16)
        self.tag1TextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.tag1TextField.textColor = UIColor.grayColor()
        self.tag1TextField.delegate = self
        
        self.tag2TextField = UITextField(frame: CGRect(x: self.view.center.x - self.textFieldWidth/2, y: self.tag2FieldYPos, width: self.textFieldWidth, height: self.textFieldHeight))
        self.tag2TextField.font = UIFont(name: self.quicksandReg, size: 16)
        self.tag2TextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.tag2TextField.textColor = UIColor.grayColor()
        self.tag2TextField.delegate = self
        
        let placeholder = NSAttributedString(string: "tag", attributes: [
            NSForegroundColorAttributeName : UIColor(white: 0, alpha: 1),
            NSFontAttributeName : UIFont(name: self.quicksandReg, size: 16)!
            ])
        
        self.tag1Label = UILabel(frame: CGRect(x: -150, y: 0, width: 100, height: 40))
        self.tag1Label.attributedText = placeholder
        self.tag1Label.textAlignment = .Center
        self.tag1Label.alpha = 0.5
        self.tag1Label.center = CGPointMake(self.tag1TextField.frame.width/2, self.tag1TextField.frame.height/2)
        self.tag2Label = UILabel(frame: CGRect(x: -150, y: 0, width: 100, height: 40))
        self.tag2Label.attributedText = placeholder
        self.tag2Label.textAlignment = .Center
        self.tag2Label.alpha = 0.5
        self.tag2Label.center = CGPointMake(self.tag1TextField.frame.width/2, self.tag1TextField.frame.height/2)
        
        self.tag1TextField.addSubview(self.tag1Label)
        self.tag2TextField.addSubview(self.tag2Label)
        
        self.tag1TextField.layer.masksToBounds = true
        self.tag2TextField.layer.masksToBounds = true
        
        self.tag1TextField.leftViewMode = UITextFieldViewMode.Always
        self.tag2TextField.leftViewMode = UITextFieldViewMode.Always
        self.tag1TextField.leftView = UIView(frame: CGRectMake(0,0,110,10))
        self.tag2TextField.leftView = UIView(frame: CGRectMake(0,0,110,10))
        
        self.tag1TextField.addTarget(self, action: #selector(VideoSubmitViewController.tag1Pressed(_:)), forControlEvents: .TouchDown)
        self.tag2TextField.addTarget(self, action: #selector(VideoSubmitViewController.tag2Pressed(_:)), forControlEvents: .TouchDown)
        
        self.view.addSubview(self.tag1TextField)
        self.view.addSubview(self.tag2TextField)

    }
    
    private func _addPublishButton()
    {
        self.publishButton = UIButton()
        self.publishButton.setTitle("Publish", forState: .Normal)
        self.publishButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.publishButton.titleLabel?.font = UIFont(name: self.quicksandReg, size: 20)
        self.publishButton.frame = CGRect(x: self.publishXPos, y: self.publishYPos, width: self.publishWidth, height: self.publishHeight)
        self.publishButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        
        self.publishButton.addTarget(self, action: #selector(VideoSubmitViewController.publishPressed(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.publishButton)

    }
    
    private func _uploadVideos()
    {
        var uuid = UserDefaults.currentUserUuid() as String!
        
        let manager = NetworkingManager.videoSharedInstance.manager
        
        let url = NetworkingManager.videoBaseURLString
        
        if (uuid == nil) {
            uuid = "test"
        }
        
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
                self.dismissViewControllerAnimated(false, completion: nil)
                
            }, failure: { (dataTask: NSURLSessionDataTask?, error: NSError) in
                print("Failed to upload a video")
                self.dismissViewControllerAnimated(false, completion: nil)
            }
        )
    }
}
