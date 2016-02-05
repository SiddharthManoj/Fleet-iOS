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
    var settingsWidth: CGFloat = 200
    var settingsHeight: CGFloat = 80
    
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
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        // quickly just for testing, will delete later
        
        self.profileLabel = UILabel(frame: CGRect(x: self.view.center.x - 200/2, y: 100, width: 200, height: 50))
        self.profileLabel.attributedText = NSAttributedString(string: "profile", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 50)!])
        self.profileLabel.textAlignment = .Center
        self.profileLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(profileLabel)
        
        /////
        
        
        _addSettingsButton()

        
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
        self.settingsButton.setTitle(settingsString, forState: .Normal)
        self.settingsButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.settingsButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.settingsButton.frame = CGRectMake(self.view.center.x - settingsWidth/2, settingsYPos, settingsWidth, settingsHeight)
        self.settingsButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        self.settingsButton.addTarget(self, action: "settingsPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.settingsButton)
    }
    
}