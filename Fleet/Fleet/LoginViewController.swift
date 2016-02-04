//
//  LoginViewController.swift
//  Fleet
//
//  Created by Rahul Madduluri on 2/1/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate
{
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var textFieldXPos: CGFloat = 80
    var textFieldWidth: CGFloat = 200
    var textFieldHeight: CGFloat = 40
    
    var usernameFieldYPos: CGFloat = 160
    var passFieldYPos: CGFloat = 200
    
    var signUpWidth: CGFloat = 100
    var signUpHeight: CGFloat = 50
    var signUpYOffset: CGFloat = 150
    
    var loginWidth: CGFloat = 100
    var loginHeight: CGFloat = 50
    var loginYOffset: CGFloat = 150
    
    // Do any additional setup after loading the view.
    var usernameTextField: UITextField!
    var passTextField: UITextField!
    var loginButton: UIButton!
    var signUpButton: UIButton!

    // MARK: - UIViewController methods

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        _addUsernameTextField()
        _addPassTextField()
        _addLoginButton()
        _addSignUpButton()
    }
    
    // MARK: - Internal methods
    
    func signupPressed(sender: UIButton!)
    {
        /*
        let vc = SignUpViewController()
        self.presentViewController(vc, animated: true, completion: nil)
        */
    }
    
    func loginPressed(sender: UIButton!)
    {
    }

    // MARK: - Private methods
    
    private func _addUsernameTextField()
    {
        self.usernameTextField = UITextField(frame: CGRect(x: textFieldXPos, y: usernameFieldYPos, width: textFieldWidth, height: textFieldHeight))
        let usernamePlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName : UIColor(white: 0, alpha: 0.7)])
        self.usernameTextField.attributedPlaceholder = usernamePlaceholder
        self.usernameTextField.textColor = UIColor.whiteColor()
        self.usernameTextField.delegate = self
        
        self.view.addSubview(usernameTextField)
    }
    
    private func _addPassTextField()
    {
        self.passTextField = UITextField(frame: CGRect(x: textFieldXPos, y: passFieldYPos, width: textFieldWidth, height: textFieldHeight))
        let passPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName : UIColor(white: 0, alpha: 0.7)])
        self.passTextField.attributedPlaceholder = passPlaceholder
        self.passTextField.textColor = UIColor.whiteColor()
        self.passTextField.secureTextEntry = true
        self.passTextField.delegate = self
        
        self.view.addSubview(self.passTextField)
    }
    
    private func _addLoginButton()
    {
        self.loginButton = UIButton()
        self.loginButton.setTitle("Login", forState: .Normal)
        self.loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.loginButton.frame = CGRectMake(self.view.center.x - signUpWidth/2, self.view.center.y + 0.5 * signUpYOffset, signUpWidth, signUpHeight)
        self.loginButton.addTarget(self, action: "loginPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.loginButton)
    }
    
    private func _addSignUpButton()
    {
        self.signUpButton = UIButton()
        self.signUpButton.setTitle("Sign Up", forState: .Normal)
        self.signUpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.signUpButton.frame = CGRectMake(self.view.center.x - signUpWidth/2, self.view.center.y + signUpYOffset, signUpWidth, signUpHeight)
        self.signUpButton.addTarget(self, action: "signupPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.signUpButton)
    }
}
