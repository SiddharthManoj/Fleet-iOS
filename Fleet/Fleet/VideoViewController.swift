//
//  VideoViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/5/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit
import Foundation

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
    
    var numBars: Int = 41
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    var doneString: String = "DONE"
    
    // Do any additional setup after loading the view.
    
    var videoTitle: String!
    var videoLabel: UILabel!
    var doneButton: UIButton!
    
    var focusView: UIImageView!
    var focusTouch: UITapGestureRecognizer!
    var focusTimes: [Double]!
    var duration: Double!
    var author: String!
    
    var scaledFocusTimes: [Int]!
    
    var gradient: CGGradientRef!
    
    var timelineBars: [UIImageView]!

    var timelineBarHeights: [CGFloat]!
    
    var counter: Int!
    
    var focusCounter: Int!
    
    var timerSpeed: NSTimeInterval!
    
    
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
        
        self.scaledFocusTimes = []
        
        self.counter = 1
        self.focusCounter = 0;
        
        self.timerSpeed = self.duration/Double(numBars)
        
        _addDoneButton()
        _addFocusView()
        _addTapGesture()
        _setHeights()
        _addTimeline()
        _addTimer()

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    // MARK: - UITextField methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Internal methods
    
    func donePressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func focusTapped(sender: UITapGestureRecognizer!)
    {
        //self.focusView.backgroundColor = UIColor(white: 0, alpha: 1)
        
        if self.focusCounter<self.scaledFocusTimes.count {
            self.counter = self.scaledFocusTimes[self.focusCounter]
            self.focusCounter = self.focusCounter + 1;
        }
    }
    
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.focusLocation = touch.locationInView(focusView)
            //_handleFocusTap(self.focusLocation)
        }
        super.touchesBegan(touches, withEvent: event)
        
    }
    */
    
    func countSec(sender: NSTimer!)
    {
        for bar in self.timelineBars {
            UIView.animateWithDuration(1, animations: {
                bar.frame = CGRect(x: bar.frame.origin.x, y: -5, width: 5, height: max(CGFloat(45 - abs(self.timelineBars.indexOf(bar)! - self.counter)*5), 25))
                for i in 0...self.scaledFocusTimes.count-1 {
                    if self.timelineBars.indexOf(bar)==self.scaledFocusTimes[i] {
                        bar.frame = CGRect(x: bar.frame.origin.x, y: -5, width: 9, height: max(CGFloat(45 - abs(self.timelineBars.indexOf(bar)! - self.counter)*5)+10, 25+10))
                    }
                }
                
            })
        }

        self.counter = self.counter + 1
        _updateFocusCount()
    }
    
    // MARK: - Private methods
    
    private func _updateFocusCount() {
        if self.focusCounter<self.scaledFocusTimes.count {
            if self.counter==self.scaledFocusTimes[self.focusCounter] {
                self.focusCounter = self.focusCounter + 1
            }
        }
    }
    
    private func _addDoneButton()
    {
        self.doneButton = UIButton()
        self.doneButton.setTitle(doneString, forState: .Normal)
        self.doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.doneButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.doneButton.frame = CGRectMake(self.view.center.x - doneWidth/2, doneYPos, doneWidth, doneHeight)
        self.doneButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        self.doneButton.addTarget(self, action: "donePressed:", forControlEvents: .TouchUpInside)
//        self.doneButton.addTarget(self, action: #selector(VideoViewController.donePressed(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.doneButton)
    }
    
    private func _addFocusView()
    {
        self.focusView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.focusView.image = UIImage(named: "china_background")
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
        self.focusTouch = UITapGestureRecognizer(target: self, action: "focusTapped:")
        self.view.addGestureRecognizer(focusTouch)
    }
    
    private func _addTimeline()
    {
        for i in 0...self.focusTimes.count-1 {
            let scaledInt = Int(floor(Double(numBars)*self.focusTimes[i]/self.duration))
            self.scaledFocusTimes.append(scaledInt)
        }
        
        self.timelineBars = [UIImageView]()
        self.timelineBars.removeAll()
        for i in 0...(numBars) {
            let newBar = UIImageView(frame: CGRect(x:Int(self.view.frame.width)/numBars * i, y: -5, width: 5, height: Int(self.timelineBarHeights[i])))
            newBar.alpha = 0.9
            newBar.image = UIImage(named: "time_bar.png")
            for j in 0...self.scaledFocusTimes.count-1 {
                if i==self.scaledFocusTimes[j] {
                    newBar.frame = CGRect(x:Int(self.view.frame.width)/numBars * i - 2, y: -5, width: 9, height: Int(self.timelineBarHeights[i]+10))
                    newBar.image = UIImage(named: "green_timebar.png")
                    break;
                }
            }
            self.timelineBars.append(newBar)
            self.view.addSubview(self.timelineBars[i])
        }
    }
    
    private func _setHeights()
    {
        self.timelineBarHeights = [45, 40, 35, 30]
        for _ in 0...(numBars - 3) {
            self.timelineBarHeights.append(25)
        }
    }
    
    private func _addTimer()
    {
        _ = NSTimer.scheduledTimerWithTimeInterval(timerSpeed, target: self, selector: "countSec:", userInfo: nil, repeats: true)
//        _ = NSTimer.scheduledTimerWithTimeInterval(timerSpeed, target: self, selector: #selector(VideoViewController.countSec(_:)), userInfo: nil, repeats: true)
    }

}
