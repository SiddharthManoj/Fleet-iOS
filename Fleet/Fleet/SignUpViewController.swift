//
//  SignUpViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/4/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate
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
    
    var textFieldXPos: CGFloat = 80
    var textFieldWidth: CGFloat = 300
    var textFieldHeight: CGFloat = 40
    
    var nameFieldYPos: CGFloat = 310
    
    var signUpYPos: CGFloat = 481
    var signUpWidth: CGFloat = 260
    var signUpHeight: CGFloat = 50
    
    var signUpBoxXPos: CGFloat = 116
    var signUpBoxYPos: CGFloat = 485
    var signUpBoxWidth: CGFloat = 253
    var signUpBoxHeight: CGFloat = 42
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    var fleetTagString: String = "see the world. as it happens."
    
    var signUpString: String = "SIGN UP"
    
    var nameString: String = "username"
    
    var logoImg: String = "logo.png"
    var loginBoxImg: String = "login_box.png"
    var signUpBoxImg: String = "signup_box.png"
    
    // Do any additional setup after loading the view.
    var fleetLogo: UIImageView!
    var fleetName: UILabel!
    var fleetTag: UILabel!
    var nameTextField: UITextField!
    var nameLabel: UILabel!
    var namePlaceholder: NSMutableAttributedString!
    var signUpButton: UIButton!
    var signUpBox: UIImageView!
    
    var nameBorder = CALayer()
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        _addFleetHeading()
        _addNameTextField()
        _addSignupButton()
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
    
    // MARK: - Internal methods
    
    func namePressed(sender: UITextField!)
    {
        UIView.animateWithDuration(0.5, animations: {
            self.nameLabel.center = CGPointMake(22, 20)
            self.nameLabel.alpha = 1
            self.nameBorder.borderColor = UIColor(white: 0, alpha: 1).CGColor
        })
    }
    
    func signupPressed(sender: UIButton!)
    {
       
    }
    
    func loginPressed(sender: UIButton!)
    {
        let vc = LoginViewController()
        let modalStyle = UIModalTransitionStyle.FlipHorizontal
        vc.modalTransitionStyle = modalStyle
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
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
    
    private func _addNameTextField()
    {
        self.nameTextField = UITextField(frame: CGRect(x: self.view.center.x - textFieldWidth/2, y: nameFieldYPos, width: textFieldWidth, height: textFieldHeight))
        self.nameTextField.font = UIFont(name: quicksandReg, size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let passPlaceholder = NSAttributedString(string: nameString, attributes: [
            NSForegroundColorAttributeName : UIColor(white: 0, alpha: 1),
            NSFontAttributeName : UIFont(name: quicksandReg, size: 16)!
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
    
    private func _addSignupButton()
    {
        let signupButton: UIButton = UIButton()
        signupButton.setTitle(signUpString, forState: .Normal)
        signupButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signupButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        signupButton.frame = CGRectMake(self.view.center.x - signUpWidth/2, self.view.center.y + signUpYPos, signUpWidth, signUpHeight)
        signupButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        signupButton.addTarget(self, action: "signupPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(signupButton)
    }
}
