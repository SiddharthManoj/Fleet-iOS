//
//  Video.swift
//  Fleet
//
//  Created by Spencer Congero on 2/5/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import Foundation
import UIKit

class Video: NSObject
{
    var title: String
    var user: String
    var thumbnail: UIImage
    var datePosted: NSDate
    //var timeRemaining: NSTimeInterval
    var timeRemaining: NSInteger
    var rating: NSInteger
    
    // MARK: - Initializers
    
    init(newTitle: String, newUser: String, newDatePosted: NSDate, newTimeRemaining: NSInteger)
    {
        self.title = newTitle
        self.user = newUser
        self.thumbnail = UIImage(named: "default.png")!
        self.datePosted = newDatePosted
        //self.timeRemaining = NSDate().timeIntervalSinceDate(self.datePosted)
        self.timeRemaining = newTimeRemaining
        self.rating = 0
    }
    
}