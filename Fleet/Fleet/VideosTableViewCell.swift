//
//  VideosTableViewCell.swift
//  Fleet
//
//  Created by Spencer Congero on 2/5/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class VideosTableViewCell: UITableViewCell
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
    
    // additional setup
    
    var thumbnail: UIImageView!
    var title: UILabel!
    var user: UILabel!
    var timer: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(white: 1, alpha: 1)
        
        _addThumbnail()
        _addInfo()
        _addTimer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - UITableViewCell methods
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private methods
    
    private func _addThumbnail()
    {
        self.thumbnail = UIImageView(frame: CGRect(x: 10, y: 10, width: 70, height: 70))
        self.thumbnail.backgroundColor = UIColor(white: 0.94, alpha: 1)
        
        self.addSubview(thumbnail)
    }
    
    private func _addInfo()
    {
        self.title = UILabel(frame: CGRect(x: 90, y: 20, width: 200, height:30))
        self.title.backgroundColor = UIColor(white: 1, alpha: 0)
        self.title.font = UIFont(name: quicksandReg, size: 21)!
        
        self.addSubview(title)
        
        self.user = UILabel(frame: CGRect(x: 90, y: 50, width: 200, height:30))
        self.user.backgroundColor = UIColor(white: 1, alpha: 0)
        self.user.font = UIFont(name: quicksandReg, size: 16)!
        
        self.addSubview(user)
    }
    
    private func _addTimer()
    {
        self.timer = UIImageView(frame: CGRect(x: 300, y: 17, width: 56, height: 56))
        
        self.addSubview(timer)
        
    }

}
