//
//  SettingsViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/4/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate
{
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var supportYPos: CGFloat = 100
    var supportWidth: CGFloat = 200
    var supportHeight: CGFloat = 60
    
    var privacyPolicyYPos: CGFloat = 180
    var privacyPolicyWidth: CGFloat = 200
    var privacyPolicyHeight: CGFloat = 60
    
    var termsofServiceYPos: CGFloat = 260
    var termsofServiceWidth: CGFloat = 200
    var termsofServiceHeight: CGFloat = 60
    
    var FAQYPos: CGFloat = 340
    var FAQWidth: CGFloat = 200
    var FAQHeight: CGFloat = 60
    
    var notificationsYPos: CGFloat = 420
    var notificationsWidth: CGFloat = 200
    var notificationsHeight: CGFloat = 60
    
    var doneYPos: CGFloat = 500
    var doneWidth: CGFloat = 200
    var doneHeight: CGFloat = 50
    
    var logoutYPos: CGFloat = 580
    var logoutWidth: CGFloat = 200
    var logoutHeight: CGFloat = 50
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    var doneString: String = "Done"
    var supportString: String = "Support"
    var privacyPolicyString: String = "Privacy Policy"
    var termsofServiceString: String = "Terms of Service"
    var FAQString: String = "FAQ"
    var notificationsString: String = "Notifications"
    var logoutString: String = "Logout"
    
    var logoImg: String = "logo.png"
    var loginBoxImg: String = "login_box.png"
    var signUpBoxImg: String = "signup_box.png"
    
    // Do any additional setup after loading the view.
    
    var settingsLabel: UILabel!
    var doneButton: UIButton!
    var supportButton: UIButton!
    var privacyPolicyButton: UIButton!
    var termsofServiceButton: UIButton!
    var FAQButton: UIButton!
    var notificationsButton: UIButton!
    var logoutButton: UIButton!
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        // quickly just for testing, will delete later
        
        self.settingsLabel = UILabel(frame: CGRect(x: self.view.center.x - 200/2, y: 20, width: 200, height: 80))
        self.settingsLabel.attributedText = NSAttributedString(string: "settings", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 50)!])
        self.settingsLabel.textAlignment = .Center
        self.settingsLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(settingsLabel)
        
        /////
        
        
        _addDoneButton()
        _addSupportButton()
        _addPrivacyPolicyButton()
        _addTermsofServiceButton()
        _addFAQButton()
        _addNotificationsButton()
        _addLogoutButton()
        
    }
    
    // MARK: - Internal methods
    
    func donePressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func supportPressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func privacyPolicyPressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func termsofServicePressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func FAQPressed(sender: UIButton!)
    {
        let vc = FAQViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func notificationsPressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logoutPressed(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func _addSupportButton()
    {
        self.supportButton = UIButton()
        self.supportButton.setTitle(supportString, forState: .Normal)
        self.supportButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.supportButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.supportButton.frame = CGRectMake(self.view.center.x - supportWidth/2, supportYPos, supportWidth, supportHeight)
        self.supportButton.addTarget(self, action: "supportPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.supportButton)
    }
    
    private func _addPrivacyPolicyButton()
    {
        self.privacyPolicyButton = UIButton()
        self.privacyPolicyButton.setTitle(privacyPolicyString, forState: .Normal)
        self.privacyPolicyButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.privacyPolicyButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.privacyPolicyButton.frame = CGRectMake(self.view.center.x - privacyPolicyWidth/2, privacyPolicyYPos, privacyPolicyWidth, privacyPolicyHeight)
        self.privacyPolicyButton.addTarget(self, action: "privacyPolicyPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.privacyPolicyButton)
    }
    
    private func _addTermsofServiceButton()
    {
        self.termsofServiceButton = UIButton()
        self.termsofServiceButton.setTitle(termsofServiceString, forState: .Normal)
        self.termsofServiceButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.termsofServiceButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.termsofServiceButton.frame = CGRectMake(self.view.center.x - termsofServiceWidth/2, termsofServiceYPos, termsofServiceWidth, termsofServiceHeight)
        self.termsofServiceButton.addTarget(self, action: "termsofServicePressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.termsofServiceButton)
    }
    
    private func _addFAQButton()
    {
        self.FAQButton = UIButton()
        self.FAQButton.setTitle(FAQString, forState: .Normal)
        self.FAQButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.FAQButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.FAQButton.frame = CGRectMake(self.view.center.x - FAQWidth/2, FAQYPos, FAQWidth, FAQHeight)
        self.FAQButton.addTarget(self, action: "FAQPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.FAQButton)
    }
    
    private func _addNotificationsButton()
    {
        self.notificationsButton = UIButton()
        self.notificationsButton.setTitle(notificationsString, forState: .Normal)
        self.notificationsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.notificationsButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.notificationsButton.frame = CGRectMake(self.view.center.x - notificationsWidth/2, notificationsYPos, notificationsWidth, notificationsHeight)
        self.notificationsButton.addTarget(self, action: "notificationsPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.notificationsButton)
    }
    
    private func _addLogoutButton()
    {
        self.logoutButton = UIButton()
        self.logoutButton.setTitle(logoutString, forState: .Normal)
        self.logoutButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.logoutButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.logoutButton.frame = CGRectMake(self.view.center.x - logoutWidth/2, logoutYPos, logoutWidth, logoutHeight)
        self.logoutButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        self.logoutButton.addTarget(self, action: "logoutPressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.logoutButton)
    }
    
    private func _addDoneButton()
    {
        self.doneButton = UIButton()
        self.doneButton.setTitle(doneString, forState: .Normal)
        self.doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.doneButton.titleLabel?.font = UIFont(name: quicksandReg, size: 20)
        self.doneButton.frame = CGRectMake(self.view.center.x - doneWidth/2, doneYPos, doneWidth, doneHeight)
        self.doneButton.backgroundColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        self.doneButton.addTarget(self, action: "donePressed:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.doneButton)
    }
    
}
