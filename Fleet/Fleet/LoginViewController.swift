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
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var logoXPos: CGFloat = 34
    var logoYPos: CGFloat = 58
    var logoWidth: CGFloat = 80
    var logoHeight: CGFloat = 80
    
    var fleetNameXPos: CGFloat = 124
    var fleetNameYPos: CGFloat = 42
    var fleetNameWidth: CGFloat = 300
    var fleetNameHeight: CGFloat = 100
    
    var fleetTagXPos: CGFloat = 60
    var fleetTagYPos: CGFloat = 140
    var fleetTagWidth: CGFloat = 274
    var fleetTagHeight: CGFloat = 40
    
    var loginBoxXPos: CGFloat = 116
    var loginBoxYPos: CGFloat = 220
    var loginBoxWidth: CGFloat = 140
    var loginBoxHeight: CGFloat = 40
    
    var loginTextXPos: CGFloat = 116
    var loginTextYPos: CGFloat = 220
    var loginTextWidth: CGFloat = 100
    var loginTextHeight: CGFloat = 40
    
    var textFieldXPos: CGFloat = 80
    var textFieldWidth: CGFloat = 300
    var textFieldHeight: CGFloat = 40
    
    var nameFieldYPos: CGFloat = 310
    var passFieldYPos: CGFloat = 360
    
    var signUpWidth: CGFloat = 100
    var signUpHeight: CGFloat = 50
    var signUpYOffset: CGFloat = 150
    
    var loginWidth: CGFloat = 320
    var loginHeight: CGFloat = 50
    var loginYOffset: CGFloat = 260
    
    // Do any additional setup after loading the view.
    var fleetLogo: UIImageView!
    var fleetName: UITextView!
    var fleetTag: UITextView!
    var loginBox: UIImageView!
    var loginText: UITextView!
    var nameTextField: UITextField!
    var passTextField: UITextField!
    var loginButton: UIButton!
    var signUpButton: UIButton!

    // MARK: - UIViewController methods

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        _addFleetHeading()
        _addLoginBox()
        _addNameTextField()
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
    
    private func _addFleetHeading()
    {
        self.fleetName = UITextView(frame: CGRect(x: fleetNameXPos, y: fleetNameYPos, width: fleetNameWidth, height: fleetNameHeight))
        self.fleetName.attributedText = NSAttributedString(string: "fleet", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: "Corbert-Regular", size: 85)!])
        self.fleetName.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(fleetName)
        
        self.fleetLogo = UIImageView(frame: CGRect(x: logoXPos, y: logoYPos, width: logoWidth, height: logoHeight))
        self.fleetLogo.image = UIImage(named: "logo.png")
        
        self.view.addSubview(fleetLogo)
        
        self.fleetTag = UITextView(frame: CGRect(x: self.view.center.x - fleetTagWidth/2, y: fleetTagYPos, width: fleetTagWidth, height: fleetTagHeight))
        self.fleetTag.attributedText = NSAttributedString(string: "see the world. as it happens.", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "Quicksand-Regular", size: 18)!])
        self.fleetTag.textAlignment = .Center
        self.fleetTag.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(fleetTag)
        
    }
    
    private func _addLoginBox()
    {
        self.loginBox = UIImageView(frame: CGRect(x: loginBoxXPos, y: loginBoxYPos, width: loginBoxWidth, height: loginBoxHeight))
        self.loginBox.image = UIImage(named: "box_outline.png")
        
        self.view.addSubview(loginBox)
        
        self.loginText = UITextView(frame: CGRect(x: self.view.center.x - loginTextWidth/2, y: loginTextYPos, width: loginTextWidth, height: loginTextHeight))
        self.loginText.attributedText = NSAttributedString(string: "LOG IN", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "Quicksand-Regular", size: 21)!])
        self.loginText.backgroundColor = UIColor(white: 1, alpha: 0)
        self.loginText.textAlignment = .Center
        
        self.view.addSubview(loginText)
    }
    
    private func _addNameTextField()
    {
        self.nameTextField = UITextField(frame: CGRect(x: self.view.center.x - textFieldWidth/2, y: nameFieldYPos, width: textFieldWidth, height: textFieldHeight))
        self.nameTextField.font = UIFont(name: "Quicksand-Regular", size: 20)
        let namePlaceholder = NSAttributedString(string: "NAME", attributes: [NSForegroundColorAttributeName : UIColor(white: 0, alpha: 0.5)])
        self.nameTextField.attributedPlaceholder = namePlaceholder
        self.nameTextField.textAlignment = .Center
        self.nameTextField.textColor = UIColor.blackColor()
        self.nameTextField.delegate = self
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width, width:  nameTextField.frame.size.width, height: nameTextField.frame.size.height)
        
        border.borderWidth = width
        nameTextField.layer.addSublayer(border)
        nameTextField.layer.masksToBounds = true
        
        self.view.addSubview(nameTextField)
    }
    
    private func _addPassTextField()
    {
        self.passTextField = UITextField(frame: CGRect(x: self.view.center.x - textFieldWidth/2, y: passFieldYPos, width: textFieldWidth, height: textFieldHeight))
        self.passTextField.font = UIFont(name: "Quicksand-Regular", size: 20)
        let passPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName : UIColor(white: 0, alpha: 0.5)])
        self.passTextField.attributedPlaceholder = passPlaceholder
        self.passTextField.textAlignment = .Center
        self.passTextField.textColor = UIColor.blackColor()
        self.passTextField.secureTextEntry = true
        self.passTextField.delegate = self
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRect(x: 0, y: passTextField.frame.size.height - width, width:  passTextField.frame.size.width, height: passTextField.frame.size.height)
        
        border.borderWidth = width
        passTextField.layer.addSublayer(border)
        passTextField.layer.masksToBounds = true
        
        self.view.addSubview(self.passTextField)
    }
    
    private func _addLoginButton()
    {
        self.loginButton = UIButton()
        self.loginButton.setTitle("LOG IN", forState: .Normal)
        self.loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.loginButton.titleLabel?.font = UIFont(name: "Quicksand-Regular", size: 20)
        self.loginButton.frame = CGRectMake(self.view.center.x - loginWidth/2, self.view.center.y + loginYOffset, loginWidth, loginHeight)
        self.loginButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
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
        
        //self.view.addSubview(self.signUpButton)
    }
}
