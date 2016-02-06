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
    static let sharedInstance = NetworkingManager()
    static let baseURLString = "http://localhost:3003/api"
    static let authenticateURLPathComponent = "authenticate"
    
    var manager: AFHTTPSessionManager
    var credentialStore : CredentialStore
    
    // MARK: - Initializers
    
    override init()
    {
        let baseURL = NSURL(string: NetworkingManager.baseURLString)
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
    
    func authenticate(username: String!, password: String!)
    {
        
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
