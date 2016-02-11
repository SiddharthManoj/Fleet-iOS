//
//  ProfileViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/4/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate
{
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var settingsYPos: CGFloat = 300
    var settingsWidth: CGFloat = 50
    var settingsHeight: CGFloat = 50
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    var settingsString: String = "SETTINGS"
    
    var logoImg: String = "logo.png"
    var loginBoxImg: String = "login_box.png"
    var signUpBoxImg: String = "signup_box.png"
    
    // Do any additional setup after loading the view.
    
    var profileLabel: UILabel!
    var settingsButton: UIButton!
    var nameLabel: UILabel!
    var pointsNumLabel: UILabel!
    var pointsLabel: UILabel!
    var followersNumLabel: UILabel!
    var followersLabel: UILabel!
    
    var postsLabel: UILabel!
    var annotationsLabel: UILabel!
    
    var postsBorderTop = CALayer()
    var postsBorderBottom = CALayer()
    
    var annotationsBorderTop = CALayer()
    var annotationsBorderBottom = CALayer()
    
    var postsContainer: UIView!
    var annotationsContainer: UIView!
    
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        
        _addSettingsButton()
        _addProfile()
        _addPosts()
        _addAnnotations()

        
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
    
    func settingsPressed(sender: UIButton!)
    {
        let vc = SettingsViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func _addSettingsButton()
    {
        self.settingsButton = UIButton()
        self.settingsButton.setImage(UIImage(named: "settings_icon.png"), forState: .Normal)
        self.settingsButton.frame = CGRectMake(310, 30, settingsWidth, settingsHeight)
        self.settingsButton.addTarget(self, action: "settingsPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.settingsButton)
    }
    
    private func _addProfile()
    {
        // profile circle
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 70,y: 120), radius: CGFloat(58), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath

        shapeLayer.fillColor = UIColor(white: 0.96, alpha: 1).CGColor
        
        view.layer.addSublayer(shapeLayer)
        
        // name
        self.nameLabel = UILabel(frame: CGRect(x: 140, y: 85, width: 250, height: 40))
        self.nameLabel.attributedText = NSAttributedString(string: "User Name", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: quicksandReg, size: 22)!])
        self.nameLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.nameLabel.textAlignment = .Left
        
        self.view.addSubview(nameLabel)
        
        // points
        self.pointsNumLabel = UILabel(frame: CGRect(x: 142, y: 121, width: 40, height: 40))
        self.pointsNumLabel.attributedText = NSAttributedString(string: "279", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: quicksandReg, size: 20)!])
        self.pointsNumLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.pointsNumLabel.textAlignment = .Left
        
        self.pointsLabel = UILabel(frame: CGRect(x: 186, y: 121, width: 100, height: 40))
        self.pointsLabel.attributedText = NSAttributedString(string: "points", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: quicksandReg, size: 20)!])
        self.pointsLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.pointsLabel.textAlignment = .Left
        
        self.view.addSubview(pointsNumLabel)
        self.view.addSubview(pointsLabel)
        
        // followers
        
        self.followersNumLabel = UILabel(frame: CGRect(x: 142, y: 145, width: 40, height: 40))
        self.followersNumLabel.attributedText = NSAttributedString(string: "142", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: quicksandReg, size: 20)!])
        self.followersNumLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.followersNumLabel.textAlignment = .Left
        
        self.followersLabel = UILabel(frame: CGRect(x: 186, y: 145, width: 100, height: 40))
        self.followersLabel.attributedText = NSAttributedString(string: "followers", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: quicksandReg, size: 20)!])
        self.followersLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.followersLabel.textAlignment = .Left
        
        self.view.addSubview(followersNumLabel)
        self.view.addSubview(followersLabel)
        
    }
    
    private func _addPosts()
    {
        // posts label
        self.postsLabel = UILabel(frame: CGRect(x: 15, y: 225, width: 100, height: 30))
        self.postsLabel.attributedText = NSAttributedString(string: "Posts", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: quicksandReg, size: 22)!])
        self.postsLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.postsLabel.textAlignment = .Left
        
        self.view.addSubview(postsLabel)
        
        // container
        self.postsContainer = UIView(frame: CGRect(x: 0, y: 262, width: self.view.frame.width, height: 136))
        self.postsContainer.backgroundColor = UIColor(white: 0.98, alpha: 1)
        let width = CGFloat(1.0)
        self.postsBorderTop.borderColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1).CGColor
        self.postsBorderTop.frame = CGRect(x: 0, y: width, width: postsContainer.frame.width, height: width)
        
        self.postsBorderTop.borderWidth = width
        self.postsContainer.layer.addSublayer(self.postsBorderTop)
        self.postsContainer.layer.masksToBounds = true
        
        self.postsBorderBottom.borderColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1).CGColor
        self.postsBorderBottom.frame = CGRect(x: 0, y: postsContainer.frame.height - width, width:  postsContainer.frame.width, height: postsContainer.frame.height)
        
        self.postsBorderBottom.borderWidth = width
        self.postsContainer.layer.addSublayer(self.postsBorderBottom)
        self.postsContainer.layer.masksToBounds = true
        
        self.view.addSubview(postsContainer)
        
        
        
        // videos
        
        
    }
    
    private func _addAnnotations()
    {
        // annotations label
        self.annotationsLabel = UILabel(frame: CGRect(x: 15, y: 429, width: 200, height: 30))
        self.annotationsLabel.attributedText = NSAttributedString(string: "Annotations", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: quicksandReg, size: 22)!])
        self.annotationsLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.annotationsLabel.textAlignment = .Left
        
        self.view.addSubview(annotationsLabel)
        
        // container
        self.annotationsContainer = UIView(frame: CGRect(x: 0, y: 466, width: self.view.frame.width, height: 136))
        self.annotationsContainer.backgroundColor = UIColor(white: 0.98, alpha: 1)
        let width = CGFloat(1.0)
        self.annotationsBorderTop.borderColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1).CGColor
        self.annotationsBorderTop.frame = CGRect(x: 0, y: width, width: annotationsContainer.frame.width, height: width)
        
        self.annotationsBorderTop.borderWidth = width
        self.annotationsContainer.layer.addSublayer(self.annotationsBorderTop)
        self.annotationsContainer.layer.masksToBounds = true
        
        self.annotationsBorderBottom.borderColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1).CGColor
        self.annotationsBorderBottom.frame = CGRect(x: 0, y: annotationsContainer.frame.height - width, width:  annotationsContainer.frame.width, height: annotationsContainer.frame.height)
        
        self.annotationsBorderBottom.borderWidth = width
        self.annotationsContainer.layer.addSublayer(self.annotationsBorderBottom)
        self.annotationsContainer.layer.masksToBounds = true
        
        self.view.addSubview(annotationsContainer)
        
        
        // videos
    }
    
}