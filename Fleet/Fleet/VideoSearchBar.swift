//
//  VideoSearchBar.swift
//  Fleet
//
//  Created by Spencer Congero on 2/5/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class VideoSearchBar: UISearchBar
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
    
    // Do any additional setup after loading the view.
    
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    
    // MARK: - UISearchBar methods

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        if let index = indexOfSearchFieldInSubviews() {
            
            let searchField: UITextField = (subviews[0]).subviews[index] as! UITextField
            
            searchField.frame = CGRectMake(0,0,frame.size.width,42)
            
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            
            searchField.backgroundColor = UIColor(white: 1, alpha: 1)
            
        }
        
        indexOfMagInSubviews()
        
        let searchBackground: UIView = (subviews[0]).subviews[0]
        searchBackground.alpha = 0
        
        //let layer3Subviews: [UIView] = subviews[0].subviews[1].subviews
        //let magGlass = layer3Subviews[1]


        super.drawRect(rect)
    }
    
    init(frame: CGRect, font: String, textColor: UIColor) {
        super.init(frame:frame)
        
        self.frame = frame
        preferredFont = UIFont(name: font, size: 20)
        preferredTextColor = textColor
        
        self.tintColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1)
        
        searchBarStyle = UISearchBarStyle.Prominent
        translucent = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        //print(subviews[0].subviews)
        var index: Int!
        let searchBarView = subviews[0]
        
        for var i=0; i<searchBarView.subviews.count; ++i {
            if searchBarView.subviews[i].isKindOfClass(UITextField) {
                index = i
                break
            }
        }
        
        return index
    }
    
    func indexOfMagInSubviews() -> Int! {
        //print(subviews[0].subviews[1].subviews[1])
        var index: Int!
        let searchBarView = subviews[0]
        
        for var i=0; i<searchBarView.subviews.count; ++i {
            if searchBarView.subviews[i].isKindOfClass(UIImage) {
                index = i
                break
            }
        }
        //print(index)
        
        return index
    }


}
