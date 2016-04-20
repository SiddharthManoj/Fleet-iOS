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
    static var videoPath = "videos/"
    
    var title: String
    var user: String
    var thumbnail: UIImage
    var datePosted: NSDate
    var rating: Int
    var duration: Double
    var focusTimes: [Double]
    
    // MARK: - Initializers
    
    init(newTitle: String, newUser: String, newDatePosted: NSDate, newDuration: Double, newFocusTimes: [Double])
    {
        self.title = newTitle
        self.user = newUser
        self.thumbnail = UIImage(named: "default.png")!
        self.datePosted = newDatePosted
        self.rating = 0
        self.duration = newDuration
        self.focusTimes = newFocusTimes
    }
    
}