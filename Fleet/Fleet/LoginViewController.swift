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
    
    var signUpYPos: CGFloat = 481
    var signUpWidth: CGFloat = 260
    var signUpHeight: CGFloat = 50
    
    var signUpBoxXPos: CGFloat = 116
    var signUpBoxYPos: CGFloat = 485
    var signUpBoxWidth: CGFloat = 253
    var signUpBoxHeight: CGFloat = 42
    
    var loginWidth: CGFloat = 320
    var loginHeight: CGFloat = 50
    var loginYOffset: CGFloat = 260
    
    var signUpQuestionYPos: CGFloat = 444
    var signUpQuestionWidth: CGFloat = 200
    var signUpQuestionHeight: CGFloat = 50
    
    // Do any additional setup after loading the view.
    var fleetLogo: UIImageView!
    var fleetName: UILabel!
    var fleetTag: UILabel!
    var loginBox: UIImageView!
    var loginText: UITextView!
    var nameTextField: UITextField!
    var nameLabel: UILabel!
    var namePlaceholder: NSMutableAttributedString!
    var passTextField: UITextField!
    var passLabel: UILabel!
    var loginButton: UIButton!
    var signUpButton: UIButton!
    var signUpBox: UIImageView!
    
    var nameBorder = CALayer()
    var passBorder = CALayer()

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
    
    func namePressed(sender: UITextField!)
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Left
        
        UIView.animateWithDuration(0.5, animations: {
            self.nameLabel.center = CGPointMake(22, 20)
            self.nameLabel.alpha = 1
            self.nameBorder.borderColor = UIColor(white: 0, alpha: 1).CGColor
        })
    }
    
    func passPressed(sender: UITextField!)
    {
        UIView.animateWithDuration(0.5, animations: {
            self.passLabel.center = CGPointMake(45, 20)
            self.passLabel.alpha = 1
            self.passBorder.borderColor = UIColor(white: 0, alpha: 1).CGColor
        })
    }
    
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
        self.fleetName = UILabel(frame: CGRect(x: fleetNameXPos, y: fleetNameYPos, width: fleetNameWidth, height: fleetNameHeight))
        self.fleetName.attributedText = NSAttributedString(string: "fleet", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: "Corbert-Regular", size: 85)!])
        self.fleetName.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(fleetName)
        
        self.fleetLogo = UIImageView(frame: CGRect(x: logoXPos, y: logoYPos, width: logoWidth, height: logoHeight))
        self.fleetLogo.image = UIImage(named: "logo.png")
        
        self.view.addSubview(fleetLogo)
        
        self.fleetTag = UILabel(frame: CGRect(x: self.view.center.x - fleetTagWidth/2, y: fleetTagYPos, width: fleetTagWidth, height: fleetTagHeight))
        let fleetText = NSMutableAttributedString(string: "see the world. as it happens.", attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Quicksand-Regular", size: 18)!,
            ])
        fleetText.addAttributes([NSFontAttributeName : UIFont(name: "Quicksand-Bold", size: 18)!], range: NSMakeRange(18,2))
        self.fleetTag.attributedText = fleetText
        self.fleetTag.textAlignment = .Center
        self.fleetTag.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(fleetTag)
        
    }
    
    private func _addLoginBox()
    {
        self.loginBox = UIImageView(frame: CGRect(x: loginBoxXPos, y: loginBoxYPos, width: loginBoxWidth, height: loginBoxHeight))
        self.loginBox.image = UIImage(named: "login_box.png")
        
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
        self.nameTextField.font = UIFont(name: "Quicksand-Regular", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let passPlaceholder = NSAttributedString(string: "NAME", attributes: [
            NSForegroundColorAttributeName : UIColor(white: 0, alpha: 1),
            NSFontAttributeName : UIFont(name: "Quicksand-Regular", size: 16)!
            ])
        
        self.nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        self.nameLabel.attributedText = passPlaceholder
        self.nameLabel.textAlignment = .Center
        self.nameLabel.alpha = 0.5
        self.nameLabel.center = CGPointMake(self.nameTextField.frame.width/2, self.nameTextField.frame.height/2)
        
        self.nameTextField.addSubview(nameLabel)

        self.nameTextField.textColor = UIColor.blackColor()
        self.nameTextField.delegate = self

        let width = CGFloat(1.0)
        self.nameBorder.borderColor = UIColor(white: 0, alpha: 0.3).CGColor
        self.nameBorder.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width, width:  nameTextField.frame.size.width, height: nameTextField.frame.size.height)
        
        self.nameBorder.borderWidth = width
        self.nameTextField.layer.addSublayer(self.nameBorder)
        self.nameTextField.layer.masksToBounds = true
        
        nameTextField.leftViewMode = UITextFieldViewMode.Always
        nameTextField.leftView = UIView(frame: CGRectMake(0,0,110,10))
        
        self.nameTextField.addTarget(self, action: "namePressed:", forControlEvents: .TouchDown)
        
        self.view.addSubview(nameTextField)
    }
    
    private func _addPassTextField()
    {
        self.passTextField = UITextField(frame: CGRect(x: self.view.center.x - textFieldWidth/2, y: passFieldYPos, width: textFieldWidth, height: textFieldHeight))
        self.passTextField.font = UIFont(name: "Quicksand-Regular", size: 16)
        let passPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [
            NSForegroundColorAttributeName : UIColor(white: 0, alpha: 1),
            NSFontAttributeName : UIFont(name: "Quicksand-Regular", size: 16)!
            ])
        //self.passTextField.attributedPlaceholder = passPlaceholder
        
        self.passLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        self.passLabel.attributedText = passPlaceholder
        self.passLabel.textAlignment = .Center
        self.passLabel.alpha = 0.5
        self.passLabel.center = CGPointMake(self.passTextField.frame.width/2, self.passTextField.frame.height/2)
        
        self.passTextField.addSubview(passLabel)
        
        self.passTextField.textColor = UIColor.blackColor()
        self.passTextField.secureTextEntry = true
        self.passTextField.delegate = self

        let width = CGFloat(1.0)
        self.passBorder.borderColor = UIColor(white: 0, alpha: 0.3).CGColor
        self.passBorder.frame = CGRect(x: 0, y: passTextField.frame.size.height - width, width:  passTextField.frame.size.width, height: passTextField.frame.size.height)
        
        self.passBorder.borderWidth = width
        passTextField.layer.addSublayer(self.passBorder)
        passTextField.layer.masksToBounds = true
        
        passTextField.leftViewMode = UITextFieldViewMode.Always
        passTextField.leftView = UIView(frame: CGRectMake(0,0,110,10))
        
        self.passTextField.addTarget(self, action: "passPressed:", forControlEvents: .TouchDown)
        
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
        let signUpQuestionLabel = UILabel(frame: CGRect(x: self.view.center.x - signUpQuestionWidth/2, y: signUpQuestionYPos, width: signUpQuestionWidth, height: signUpQuestionHeight))
        
        let signUpQuestionText = NSMutableAttributedString(string: "new to fleet?", attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Quicksand-Regular", size: 18)!,
            ])

        signUpQuestionLabel.attributedText = signUpQuestionText
        signUpQuestionLabel.textAlignment = .Center
        signUpQuestionLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(signUpQuestionLabel)
        
        self.signUpBox = UIImageView(frame: CGRect(x: self.view.center.x - signUpBoxWidth/2, y: signUpBoxYPos, width: signUpBoxWidth, height: signUpBoxHeight))
        self.signUpBox.image = UIImage(named: "signup_box.png")
        
        self.view.addSubview(signUpBox)
        
        self.signUpButton = UIButton()
        self.signUpButton.setTitle("SIGN UP", forState: .Normal)
        self.signUpButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.signUpButton.titleLabel?.font = UIFont(name: "Quicksand-Regular", size: 20)
        self.signUpButton.frame = CGRectMake(self.view.center.x - signUpWidth/2, signUpYPos, signUpWidth, signUpHeight)
        self.signUpButton.addTarget(self, action: "signupPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.signUpButton)
    }
}
