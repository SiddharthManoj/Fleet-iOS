//
//  FAQViewController.swift
//  Fleet
//
//  Created by Derrick Choi on 12/2/2016.
//  Copyright © 2016 fleet. All rights reserved.
//

import Foundation
import UIKit

class FAQViewController: UIViewController, UITextFieldDelegate
{
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    var FAQString: String = "FAQ"
    
    // Do any additional setup after loading the view.
    
    var FAQLabel: UILabel!
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
        
        self.FAQLabel = UILabel(frame: CGRect(x: self.view.center.x - 200/2, y: 20, width: 200, height: 80))
        self.FAQLabel.attributedText = NSAttributedString(string: "FAQ", attributes: [NSForegroundColorAttributeName: UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), NSFontAttributeName: UIFont(name: corbertReg, size: 50)!])
        self.FAQLabel.textAlignment = .Center
        self.FAQLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.view.addSubview(FAQLabel)
        
        _addFAQ();
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "FAQ"
    }
    
    private func _addFAQ()
    {
        self.FAQLabel = UILabel(frame: CGRect(x: 186, y: 145, width: 100, height: 40))
        self.FAQLabel.attributedText = NSAttributedString(string: "Hello", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: quicksandReg, size: 20)!])
        self.FAQLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        self.FAQLabel.textAlignment = .Left
        
        self.view.addSubview(FAQLabel)
    }
}
