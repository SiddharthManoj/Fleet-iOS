//
//  MainPageViewController.swift
//  Fleet
//
//  Created by Derrick Choi on 7/3/2016.
//  Copyright © 2016 fleet. All rights reserved.
//

import Foundation

class MainPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    var index = 0
    
    override func viewDidLoad() {
        
        self.dataSource = self
        self.delegate = self
        
        let firstViewController = self.viewControllerAtIndex(self.index)
        //      let secondViewController = self.viewControllerAtIndex(1)
        //      let thirdViewController = self.viewControllerAtIndex(2)
        let viewControllers: NSArray = [firstViewController]
        self.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController! {
        
        //first view controller = firstViewControllers navigation controller.
        if index == 0 {
            return _addCameraSubview()
        }
        
        //second view controller = secondViewController's navigation controller.
        if index == 1 {
            return VideosSearchViewController()
        }
        
        //third view controller = secondViewController's navigation controller.
        if index == 2 {
            return ProfileViewController()
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKindOfClass(CameraViewController) {
            self.index = 0
        }
        if viewController.isKindOfClass(VideosSearchViewController) {
            self.index = 1
        }
        if viewController.isKindOfClass(ProfileViewController) {
            self.index = 2
            return nil;
        }
        
        //increment the index to get the viewController after the current index
        self.index = self.index + 1
        return self.viewControllerAtIndex(self.index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(CameraViewController) {
            self.index = 0
            return nil
        }
        if viewController.isKindOfClass(VideosSearchViewController) {
            self.index = 1
        }
        if viewController.isKindOfClass(ProfileViewController) {
            self.index = 2
            return nil;
        }
        
        //decrement the index to get the viewController before the current one
        self.index = self.index - 1
        return self.viewControllerAtIndex(self.index)
        
    }
    
    func _addCameraSubview() -> CameraViewController! {
        let cameraController =  CameraViewController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == true {
            cameraController.sourceType = .Camera
            cameraController.mediaTypes = [kUTTypeMovie as String]
            cameraController.allowsEditing = false
            cameraController.delegate = self
        }
        
        return cameraController
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
}