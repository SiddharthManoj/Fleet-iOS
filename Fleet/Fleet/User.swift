//
//  User.swift
//  Fleet
//
//  Created by Rahul Madduluri on 2/19/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class User: NSObject
{
    
    static var userPath = "users/"
    
    var uuid: String?
    var email: String?
    
    // MARK: - Initializers
    
    // MARK: - Type methods
    
    class func logout ()
    {
        NetworkingManager.webSharedInstance.credentialStore.clearSavedCredentials()
        NetworkingManager.videoSharedInstance.credentialStore.clearSavedCredentials()
    }
    
    class func createNewUser(newUsername: String, newEmail: String, vc: UIViewController)
    {
        let manager = NetworkingManager.webSharedInstance.manager
        let parameters = ["username": newUsername, "email": newEmail]
        
        manager.POST(User.userPath,
            parameters: parameters,
            progress: nil,
            success: {
                (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                if let jsonResult = responseObject as? Dictionary<String, AnyObject> {
                    let successful = jsonResult["success"] as? Bool
                    if (successful == false) {
                        print("Failed to create new user")
                        FBSDKAccessToken.setCurrentAccessToken(nil)
                        FBSDKProfile.setCurrentProfile(nil)
                    }
                    else {
                        NetworkingManager.webSharedInstance.authenticate(FBSDKAccessToken.currentAccessToken().tokenString, email: newEmail, completionClosure: { (userUUID, username, signup) -> () in
                            if (userUUID != nil && username != nil && signup == false) {
                                let defaults = NSUserDefaults.standardUserDefaults()
                                defaults.setObject(userUUID, forKey: "uuid")
                                defaults.setObject(username, forKey: "username")
                                defaults.setObject(newEmail, forKey: "email")

                                let svc: UIViewController = ScrollViewController()
                                vc.presentViewController(svc, animated: true, completion: nil)
                            }
                            else {
                                print("Failed to sign in");
                                
                                let lvc: UIViewController = LoginViewController()
                                FBSDKAccessToken.setCurrentAccessToken(nil)
                                FBSDKProfile.setCurrentProfile(nil)
                                NetworkingManager.webSharedInstance.logout()
                                NetworkingManager.videoSharedInstance.logout()
                                vc.presentViewController(lvc, animated: true, completion: nil)
                            }
                        })
                    }
                }
                else {
                    print("Error: responseObject couldn't be converted to Dictionary")
                    FBSDKAccessToken.setCurrentAccessToken(nil)
                    FBSDKProfile.setCurrentProfile(nil)
                }
            }, failure: {
                (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                let errorMessage = "Error: " + error.localizedDescription
                print(errorMessage)
                
                if let response = dataTask!.response as? NSHTTPURLResponse {
                    if (response.statusCode == 401) {
                        NetworkingManager.webSharedInstance.logout()
                        NetworkingManager.videoSharedInstance.logout()
                        FBSDKAccessToken.setCurrentAccessToken(nil)
                        FBSDKProfile.setCurrentProfile(nil)
                    }
                }
            }
        )
    }
}

