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

class CameraViewController: UIViewController, UINavigationControllerDelegate, AVCaptureFileOutputRecordingDelegate {
    
    var recordButton: UIButton!
    
    var recordButtonYPos: CGFloat = 300
    var recordButtonWidth: CGFloat = 50
    var recordButtonHeight: CGFloat = 50
    
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureMovieFileOutput()
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var captureDevice: AVCaptureDevice?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //uploadVideos()
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if (device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        beginSession()
                    }
                }
            }
        }

        self._addRecordButton()
    }
    
    func recordPressed(sender: UIButton!) {
        let recordingDelegate:AVCaptureFileOutputRecordingDelegate? = self
        
        // Do recording and save the output to the `filePath`
        if (self.videoOutput.recording == true) {
            self.videoOutput.stopRecording()
        }
        else {
            var captureSessionHasOutput = false
            for output in self.captureSession.outputs {
                if (output as! AVCaptureMovieFileOutput == self.videoOutput) {
                    captureSessionHasOutput = true
                }
            }
            
            if (!captureSessionHasOutput) {
                self.captureSession.addOutput(self.videoOutput)
            }
            
            let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let filePath = documentsURL.URLByAppendingPathComponent("temp")
            
            let con = self.videoOutput.connectionWithMediaType(AVMediaTypeVideo)
            if (con != nil && con.active) {
                self.videoOutput.startRecordingToOutputFileURL(filePath, recordingDelegate: recordingDelegate)
            }
            else {
                print("Could not record video. Connection could not be established w/ session")
            }
        }

    }
    
    private func _addRecordButton() {
        self.recordButton = UIButton()
        self.recordButton.setImage(UIImage(named: "record_button.png"), forState: .Normal)
        self.recordButton.frame = CGRectMake(self.view.center.x - recordButtonWidth/2, recordButtonYPos, recordButtonWidth, recordButtonHeight)
        
        self.recordButton.addTarget(self, action: "recordPressed:", forControlEvents: .TouchUpInside)
//        self.recordButton.addTarget(self, action: #selector(CameraViewController.recordPressed(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.recordButton)
    }
    
    func focusTo(value: Float) {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                })
                device.unlockForConfiguration()
            } catch {
                // handle error
                return
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch = touches.first! as UITouch
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch = touches.first! as UITouch
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    func configureDevice() {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                
                device.focusMode = .Locked
                device.unlockForConfiguration()
            } catch {
                // handle error
                return
            }
        }
    }
    
    func beginSession() {
        configureDevice()
        
        do {
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
        } catch {
            // handle error
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
        
//        var err : NSError? = nil
//        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
//        
//        if err != nil {
//            println("error: \(err?.localizedDescription)")
//        }
//        
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        self.cameraView.layer.addSublayer(previewLayer)
//        self.cameraView.bringSubviewToFront(takePhotoButton)
//        self.cameraView.bringSubviewToFront(self.snappedPicture)
//        self.cameraView.bringSubviewToFront(self.backButton)
//        previewLayer?.frame = self.cameraView.layer.frame
//        captureSession.startRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        return
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        return
    }
    
    
    func uploadVideos() {
        
        //parameters (user id (UID) and the actual data)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let uuid = defaults.objectForKey("uuid") as! String
        
        let manager = NetworkingManager.videoSharedInstance.manager
        
        let url = NetworkingManager.videoBaseURLString + "mp4:sample.mp4/" + "playlist.m3u8"
        
        let fileURL = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("sample", ofType: "mp4")!)
        
        let parameters = [
            "uuid": uuid,
            "videoName":"sample",
            "contentBody" : "Some body content for the test application",
            "title" : "title of video",
            "typeOfContent":"video"
        ]
        
        manager.POST(url, parameters: parameters, constructingBodyWithBlock: { (data: AFMultipartFormData!) -> Void in
            if let _ = try? data.appendPartWithFileURL(fileURL, name: "video_data") {
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
    
    //create a manager. sharedInstance.video ->do post and get to stream

    // MARK: - UIImagePickerController methods

}
