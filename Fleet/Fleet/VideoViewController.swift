//
//  VideoViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/5/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var doneYPos: CGFloat = 500
    var doneWidth: CGFloat = 200
    var doneHeight: CGFloat = 80
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    var doneString: String = "DONE"
    
    var logoImg: String = "logo.png"
    var loginBoxImg: String = "login_box.png"
    var signUpBoxImg: String = "signup_box.png"
    
    // Do any additional setup after loading the view.
    
    var videoTitle: String!
    var videoLabel: UILabel!
    var doneButton: UIButton!
    
    var focusView: UIView!
    var focusTouch: UITapGestureRecognizer!
    var focusLocation: CGPoint!
    
    var gradient: CGGradientRef!
    
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        
        // quickly just for testing, will delete later
        
        self.videoLabel = UILabel(frame: CGRect(x: self.view.center.x - 400/2, y: 100, width: 400, height: 50))
        self.videoLabel.attributedText = NSAttributedString(string: videoTitle, attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 50)!])
        self.videoLabel.textAlignment = .Center
        self.videoLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(videoLabel)
        
        _addDoneButton()
        _addFocusView()
        _addTapGesture()

    }
    
    // MARK: - Internal methods
    
    func donePressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func focusTapped(sender: UITapGestureRecognizer!)
    {
        self.focusView.backgroundColor = UIColor(white: 0, alpha: 1)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.focusLocation = touch.locationInView(focusView)
            //_handleFocusTap(self.focusLocation)
        }
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    // MARK: - Private methods
    
    private func _addDoneButton()
    {
        self.doneButton = UIButton()
        self.doneButton.setTitle(doneString, forState: .Normal)
        self.doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.doneButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.doneButton.frame = CGRectMake(self.view.center.x - doneWidth/2, doneYPos, doneWidth, doneHeight)
        self.doneButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        self.doneButton.addTarget(self, action: "donePressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.doneButton)
    }
    
    private func _addFocusView()
    {
        self.focusView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.focusView.backgroundColor = UIColor.redColor()
        self.view.addSubview(focusView)
    }
    
    private func _handleFocusTap(tapLocation: CGPoint!)
    {
        let circleLayer = CALayer()
        circleLayer.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        circleLayer.backgroundColor = UIColor(white: 1, alpha: 0.1).CGColor
        circleLayer.shadowOpacity = 1
        circleLayer.shadowColor = UIColor.blackColor().CGColor
        circleLayer.shadowRadius = 30
        
        self.focusView.layer.addSublayer(circleLayer)
    }
    
    /*
    private func _handleFocusTap(focusLocation: CGPoint!)
    {
        let gradientView = GradientView(frame: CGRectMake(0, 0, self.focusView.frame.width, self.focusView.frame.height))
        
        // Set the gradient colors
        gradientView.myColors = [UIColor(white: 1, alpha: 1).CGColor, UIColor(white: 0, alpha: 1).CGColor]
        
        // Optionally set some locations
        //gradientView.locations = [0.2, 1.0]
        
        gradientView.mode = .Radial
        
        gradientView.centerPoint = focusLocation
        
        gradientView.alpha = 0.3
        
        // Add it as a subview in all of its awesome
        self.focusView.addSubview(gradientView)
        
    }
    */

    /*
    private func _handleFocusTap()
    {
        /*
        // Initialize a gradient view
        let gradientView = GradientView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        // Set the gradient colors
        gradientView.colors = [UIColor.redColor(), UIColor.blueColor()]
        
        // Optionally set some locations
        gradientView.locations = [0.8, 1.0]
        
        gradientView.mode = .Radial
        
        // Add it as a subview in all of its awesome
        self.focusView.addSubview(gradientView)
        */
        let context = UIGraphicsGetCurrentContext()
        let size = self.focusView.bounds.size
        
        let locations: [CGFloat] = [0.0, 1.0]
        
        let colors = [UIColor.whiteColor().CGColor,
            UIColor.blueColor().CGColor]
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradientCreateWithColors(colorspace,
            colors, locations)

        let options: CGGradientDrawingOptions = [.DrawsAfterEndLocation]

        let center = CGPoint(x: self.focusView.bounds.midX, y: self.focusView.bounds.midY)
        CGContextDrawRadialGradient(context, gradient, center, 0, center, min(size.width, size.height) / 2, options)

        
    }
    */
    
    private func _addTapGesture()
    {
        //self.focusTouch = UITapGestureRecognizer(target: self, action: "focusTapped:")
        //self.view.addGestureRecognizer(focusTouch)
    }

    
}
