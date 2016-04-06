//
//  UserDefaults.swift
//  Fleet
//
//  Created by Rahul Madduluri on 3/6/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class UserDefaults: NSObject
{
    
    // MARK: - Type methods
    
    class func currentUserUuid () -> String?
    {
        let currentUserUuid = NSUserDefaults.standardUserDefaults().stringForKey("uuid")
        if (currentUserUuid == nil) {
            print("ERROR - could not find current user uuid")
        }
        return currentUserUuid
    }
}
