//
//  CameraViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/4/16.
//  Copyright © 2016 fleet. All rights reserved.
//


// ********** GRAVEYARD -- MIGHT NEED AT SOME POINT LATER **********

import UIKit
import MobileCoreServices
import MediaPlayer
import AVFoundation

class Camera3ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
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

    var logoImg: String = "logo.png"
    var loginBoxImg: String = "login_box.png"
    var signUpBoxImg: String = "signup_box.png"
    
    // Do any additional setup after loading the view.
    
    var previewView: UIView!
    var capturedImage: UIImageView!
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var captureButton: UIButton!
    
    // MARK: - UIViewController methods
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.previewView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(previewView)
        
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)

                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
                previewView.layer.addSublayer(previewLayer!)
                
                self.previewLayer!.frame = previewView.bounds
                
                captureSession!.startRunning()
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        /*
        // quickly just for testing, will delete later
        
        self.cameraLabel = UILabel(frame: CGRect(x: self.view.center.x - 200/2, y: 100, width: 200, height: 50))
        self.cameraLabel.attributedText = NSAttributedString(string: "camera", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 50)!])
        self.cameraLabel.textAlignment = .Center
        self.cameraLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(cameraLabel)
        */

        startCameraFromViewController(self, withDelegate: self)

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //_addCaptureButton()
    }
    
    // MARK: - UIImagePickerController methods
    
    func startCameraFromViewController(viewController: UIViewController, withDelegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
            return false
        }
        
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeMovie as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismissViewControllerAnimated(true, completion: nil)
        // Handle a movie capture
        if mediaType == kUTTypeMovie {
            let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path!) {
                UISaveVideoAtPathToSavedPhotosAlbum(path!, self, "video:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }
    
    func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
        var title = "Success"
        var message = "Video was saved"
        
        if let _ = error {
            title = "Error"
            message = "Video failed to save"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

    
    // MARK: - Internal methods
    
    func captureButtonPressed(sender: UIButton!)
    {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    self.capturedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                    self.capturedImage.image = image
                    self.view.addSubview(self.capturedImage)
                }
            })
        }
    }
    
    func recordVideo(sender: UIButton!)
    {
        startCameraFromViewController(self, withDelegate: self)
    }
    
    // MARK: - Private methods

    private func _addCaptureButton()
    {
        self.captureButton = UIButton(type: .Custom)
        self.captureButton.frame = CGRect(x: self.view.frame.width/2 - 40, y: 440, width: 80, height: 80)
        self.captureButton.layer.cornerRadius = 0.5 * self.captureButton.bounds.size.width
        self.captureButton.addTarget(self, action: "recordVideo:", forControlEvents: .TouchUpInside)
        self.captureButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
        self.view.addSubview(captureButton)
    }
    
    
}










