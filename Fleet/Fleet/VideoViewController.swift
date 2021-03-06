//
//  VideoViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/5/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Foundation

class VideoViewController: UIViewController {

    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var numBars: Int = 41
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    
    // Do any additional setup after loading the view.
    
    var videoTitle: String!
    var videoLabel: UILabel!
    var authorLabel: UILabel!
    
    var focusView: UIImageView!
    var focusTouch: UITapGestureRecognizer!
    var focusTimes: [Double]!
    var duration: Double!
    var author: String!
    var s3: String!
    
    var scaledFocusTimes: [Int]!
    var gradient: CGGradientRef!
    var timelineBars: [UIImageView]!
    var timelineBarHeights: [CGFloat]!
    var counter: Int!
    var focusCounter: Int!
    var timerSpeed: NSTimeInterval!
    
    var playerTimerObserver: AnyObject!
    
    var player: AVPlayer!
    
    
    // MARK: - UIViewController methods
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        
        // quickly just for testing, will delete later
        
        self.videoLabel = UILabel(frame: CGRect(x: self.view.center.x - 250, y: 80, width: 400, height: 50))
        self.videoLabel.attributedText = NSAttributedString(string: videoTitle, attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 20)!])
        self.videoLabel.textAlignment = .Center
        self.videoLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.authorLabel = UILabel(frame: CGRect(x: self.view.center.x - 300, y: 100, width: 400, height: 50))
        self.authorLabel.attributedText = NSAttributedString(string: self.author, attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 16)!])
        self.authorLabel.textAlignment = .Center
        self.authorLabel.backgroundColor = UIColor(white: 1, alpha: 0)

        
        self.view.addSubview(videoLabel)
        self.view.addSubview(self.authorLabel)
        
        self.scaledFocusTimes = []
        
        self.counter = 1
        self.focusCounter = 0;
        
        self.timerSpeed = self.duration/Double(numBars)
        
        self._playVideo()
        
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
    
    func focusTapped(sender: UITapGestureRecognizer!)
    {
        if (self.focusTimes.count > 0 && self.focusCounter < self.focusTimes.count) {
            self.player.seekToTime(CMTimeMakeWithSeconds(self.focusTimes[self.focusCounter], 1000000000))
        }
        else {
            self.player.pause()
            self.player.removeTimeObserver(self.playerTimerObserver)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        if self.focusCounter<self.scaledFocusTimes.count {
            self.counter = self.scaledFocusTimes[self.focusCounter]
            self.focusCounter = self.focusCounter + 1;
        }
    }
    
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
    
    private func _addFocusView()
    {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
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
    
    private func _playVideo()
    {
        var url: String!
        if (self.s3 != nil && !self.s3.isEmpty) {
            url = NetworkingManager.videoBaseURLString + self.s3 + "/playlist.m3u8"
        }
        else {
            url = NetworkingManager.videoBaseURLString + "mp4:sample.mp4/" + "playlist.m3u8"
        }
        
        let videoURL = NSURL(string: url)
        self.player = AVPlayer(URL: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        self.player.play()
        
    }
    
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
        
        let interval = CMTimeMakeWithSeconds(1.0, 1000000000)
        self.playerTimerObserver = self.player.addPeriodicTimeObserverForInterval(interval, queue: nil, usingBlock: { (time: CMTime) in
            self.countSec(nil)
        })
 
        //_ = NSTimer.scheduledTimerWithTimeInterval(timerSpeed, target: self, selector: #selector(VideoViewController.countSec(_:)), userInfo: nil, repeats: true)
    }

}
