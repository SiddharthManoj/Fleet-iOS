//
//  NetworkingManager.swift
//  Fleet
//
//  Created by Rahul Madduluri on 2/5/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class NetworkingManager: NSObject
{
    static let webBaseURLString = "http://localhost:3003/api"
    static let videoBaseURLString = "http://localhost:1935"
    static let webSharedInstance = NetworkingManager(baseURL: webBaseURLString)
    static let videoSharedInstance = NetworkingManager(baseURL: videoBaseURLString)

    static let authenticateURLPathComponent = "authenticate"
    static let videoSharedInstance = NetworkingManager()
    static let videoBaseURLString = "http://[wowza-ip]:1935/vod/"
    
    var manager: AFHTTPSessionManager
    var credentialStore : CredentialStore
    
    // MARK: - Initializers
    
    init(baseURL: String)
    {
        let baseURL = NSURL(string: baseURL)
        self.manager = AFHTTPSessionManager(baseURL: baseURL)
        self.credentialStore = CredentialStore()
        
        super.init()
        
        self._setAuthTokenHeader()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("tokenChanged:"), name: "token-changed", object: nil)
    }
    
    // MARK: - Internal methods
    
    @objc func tokenChanged(notification: NSNotification)
    {
        self._setAuthTokenHeader()
    }
    
    func authenticate(fb_token: String!, email: String!, completionClosure:(userUUID: String!, username: String!, signup: Bool) -> ())
    {
        let parameters = ["email": email, "fb_token": fb_token]
        
        self.manager.POST(NetworkingManager.authenticateURLPathComponent,
            parameters: parameters,
            progress:  nil,
            success: {
                (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                if let jsonResult = responseObject as? Dictionary<String, AnyObject> {
                    let authToken = jsonResult["token"] as? String
                    let userUUID = jsonResult["uuid"] as? String
                    let email = jsonResult["email"] as? String
                    let username = jsonResult["username"] as? String
                    let userExists = jsonResult["exists"] as? Bool
                    
                    if (authToken != nil && userUUID != nil && email != nil && username != nil) {
                        self.credentialStore.setAuthToken(authToken)
                        completionClosure(userUUID: userUUID, username: username, signup: false)
                    }
                    else if (userExists != nil && userExists == false) {
                        completionClosure(userUUID: userUUID, username:nil, signup: true)
                    }
                }
                else {
                    print("Error: responseObject couldn't be converted to Dictionary")
                }
            }, failure: {
                (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                let errorMessage = "Error: " + error.localizedDescription
                print(errorMessage)
                
                if let response = dataTask!.response as? NSHTTPURLResponse {
                    if (response.statusCode == 401) {
                        NetworkingManager.webSharedInstance.credentialStore.clearSavedCredentials()
                    }
                }
            }
        )
    }
    
    func logout()
    {
        self.credentialStore.clearSavedCredentials()
    }
    
    // MARK: - Private methods
    
    private func _setAuthTokenHeader()
    {
        let authToken = self.credentialStore.authToken()
        if (authToken != nil) {
            self.manager.requestSerializer.setValue(authToken, forHTTPHeaderField: "x-auth-token")
        }
    }
}
