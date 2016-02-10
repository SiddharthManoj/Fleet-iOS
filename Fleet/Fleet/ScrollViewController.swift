//
//  ScrollViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/4/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit
import MobileCoreServices
import MediaPlayer
import AVFoundation

class ScrollViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    
    // Do any additional setup after loading the view.
    
    var scrollView: UIScrollView!
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        _addScrollView()
        
    }
    
    // MARK: - Internal methods
    
    // MARK: - Private methods
    
    private func _addScrollView() {
        self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height)
        
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        
        _addCameraSubview()
        
        let videosVC = VideosSearchViewController()
        let profileVC = ProfileViewController()
        
        var videosFrame = videosVC.view.frame
        videosFrame.origin.x = self.view.frame.size.width
        videosVC.view.frame = videosFrame
        
        self.addChildViewController(videosVC)
        self.scrollView.addSubview(videosVC.view)
        videosVC.didMoveToParentViewController(self)
        
        var profileFrame = profileVC.view.frame
        profileFrame.origin.x = self.view.frame.size.width * 2
        profileVC.view.frame = profileFrame
        
        self.addChildViewController(profileVC)
        self.scrollView.addSubview(profileVC.view)
        profileVC.didMoveToParentViewController(self)
        
        self.scrollView.contentOffset = CGPointMake(0, 0)
        
        self.view = self.scrollView
        
    }
    
    func _addCameraSubview() {
        let cameraController = CameraViewController()
        
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == true {
            cameraController.sourceType = .Camera
            cameraController.mediaTypes = [kUTTypeMovie as String]
            cameraController.allowsEditing = false
            cameraController.delegate = self
            
            //presentViewController(cameraController, animated: true, completion: nil)
            self.addChildViewController(cameraController)
            self.scrollView.addSubview(cameraController.view)
            cameraController.didMoveToParentViewController(self)
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        //dismissViewControllerAnimated(true, completion: nil)
        // Handle a movie capture
        if mediaType == kUTTypeMovie {
            let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path!) {
                UISaveVideoAtPathToSavedPhotosAlbum(path!, self, "video:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }
    
    func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject)
    {
        /*
        var title = "Success"
        var message = "Video was saved"
        
        if let _ = error {
        title = "Error"
        message = "Video failed to save"
        }
        */
        /*
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        */
        /*
        let vc = ScrollViewController()
        let modalStyle = UIModalTransitionStyle.CrossDissolve
        vc.modalTransitionStyle = modalStyle
        self.presentViewController(vc, animated: true, completion: {
        
        })
        */
        
        //startCameraFromViewController(self, withDelegate: self)
        //print(self.scrollView.subviews)
        self.scrollView.subviews[0].removeFromSuperview()
        _addCameraSubview()
    }
    
}





