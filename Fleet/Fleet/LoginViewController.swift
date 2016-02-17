//
//  LoginViewController.swift
//  Fleet
//
//  Created by Rahul Madduluri on 2/1/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate
{
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var logoXPos: CGFloat = 38
    var logoYPos: CGFloat = 58
    var logoWidth: CGFloat = 80
    var logoHeight: CGFloat = 80
    
    var fleetNameXPos: CGFloat = 135
    var fleetNameYPos: CGFloat = 52
    var fleetNameWidth: CGFloat = 300
    var fleetNameHeight: CGFloat = 100
    
    var fleetTagXPos: CGFloat = 60
    var fleetTagYPos: CGFloat = 140
    var fleetTagWidth: CGFloat = 274
    var fleetTagHeight: CGFloat = 40
    
    var loginWidth: CGFloat = 320
    var loginHeight: CGFloat = 50
    var loginYOffset: CGFloat = 400
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    var fleetTagString: String = "see the world. as it happens."
    var loginQuestionString: String = "new to fleet?"
    
    var logoImg: String = "logo.png"
    
    // Do any additional setup after loading the view.
    var fleetLogo: UIImageView!
    var fleetName: UILabel!
    var fleetTag: UILabel!
    
    // MARK: - UIViewController methods

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        _addFleetHeading()
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            _addFBLoginButton()
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in
            let vc = ScrollViewController()
            self.presentViewController(vc, animated: false, completion: nil)
        }
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
    
    // MARK: - FB Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
            print("Error: \(error)")
        }
        else if result.isCancelled {
            // Handle cancellations
            print("Login Cancelled")
        }
        else {
            if result.grantedPermissions.contains("email")
            {
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
                graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                    if ((error) != nil)
                    {
                        print("Error: \(error)")
                    }
                    else
                    {
                        let email: String = result.valueForKey("email") as! String
                        
                        NetworkingManager.sharedInstance.authenticate(FBSDKAccessToken.currentAccessToken().tokenString, email: email, completionClosure: {
                            (userUUID: String!, signup: Bool) in
                            
                            var vc: UIViewController
                            
                            if (signup == true) {
                                vc = SignUpViewController()
                            }
                            else {
                                vc = ScrollViewController()
                                let defaults = NSUserDefaults.standardUserDefaults()
                                defaults.setObject(userUUID, forKey: "uuid")
                                defaults.setObject(email, forKey: "email")
                            }
                        
                            self.presentViewController(vc, animated: true, completion: nil)
                        })
                    }
                })
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    // MARK: - Internal methods
    
    // MARK: - Private methods
    
    private func _addFleetHeading()
    {
        self.fleetName = UILabel(frame: CGRect(x: fleetNameXPos, y: fleetNameYPos, width: fleetNameWidth, height: fleetNameHeight))
        self.fleetName.attributedText = NSAttributedString(string: fleetTitle, attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 85)!])
        self.fleetName.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(fleetName)
        
        self.fleetLogo = UIImageView(frame: CGRect(x: logoXPos, y: logoYPos, width: logoWidth, height: logoHeight))
        self.fleetLogo.image = UIImage(named: logoImg)
        
        self.view.addSubview(fleetLogo)
        
        self.fleetTag = UILabel(frame: CGRect(x: self.view.center.x - fleetTagWidth/2, y: fleetTagYPos, width: fleetTagWidth, height: fleetTagHeight))
        let fleetText = NSMutableAttributedString(string: fleetTagString, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: quicksandReg, size: 18)!,
            ])
        fleetText.addAttributes([NSFontAttributeName : UIFont(name: quicksandBold, size: 18)!], range: NSMakeRange(18,2))
        self.fleetTag.attributedText = fleetText
        self.fleetTag.textAlignment = .Center
        self.fleetTag.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(fleetTag)
        
    }
    
    private func _addFBLoginButton()
    {
        let fbLoginButton: FBSDKLoginButton = FBSDKLoginButton()
        fbLoginButton.center = CGPointMake(self.view.center.x, self.loginYOffset)
        self.view.addSubview(fbLoginButton)
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.delegate = self
    }
}
