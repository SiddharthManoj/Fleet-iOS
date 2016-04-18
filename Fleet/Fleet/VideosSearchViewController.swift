//
//  VideosViewController.swift
//  Fleet
//
//  Created by Spencer Congero on 2/4/16.
//  Copyright © 2016 fleet. All rights reserved.
//

import UIKit

class VideosSearchViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource
{
    var bgColorRed: CGFloat = 255/255
    var bgColorGreen: CGFloat = 255/255
    var bgColorBlue: CGFloat = 255/255
    
    var fleetColorRed: CGFloat = 77/255
    var fleetColorGreen: CGFloat = 206/255
    var fleetColorBlue: CGFloat = 177/255
    
    var scrollButtonWidth: CGFloat = 150
    
    var hotBool: Bool = true
    var newBool: Bool = false
    var followBool: Bool = false
    
    var searchActive: Bool = false
    
    var quicksandReg: String = "Quicksand-Regular"
    var quicksandBold: String = "Quicksand-Bold"
    var corbertReg: String = "Corbert-Regular"
    
    var fleetTitle: String = "fleet"
    
    var logoImg: String = "logo.png"
    var loginBoxImg: String = "login_box.png"
    var signUpBoxImg: String = "signup_box.png"
    
    // Do any additional setup after loading the view.
    
    //var videosLabel: UILabel!
    
    var videos: [Video] = []
    var filteredVideos: [Video] = []
    
    var searchBar: UISearchBar!
    var scrollView: UIScrollView!
    var tableView: UITableView!
    
    var hotButton: UIButton!
    var newButton: UIButton!
    var followButton: UIButton!
    
    var scrollBorderTop = CALayer()
    var scrollBorderBottom = CALayer()
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: bgColorRed, green: bgColorGreen, blue: bgColorBlue, alpha: 1)
        self.view.backgroundColor = bgColor
                
        _generateVideos()
        
        _addSearch()
        _addScrollView()
        _addTableView()
        
        _setAlphas()
    }
    
    override func viewWillAppear(animated: Bool) {
        _getVideos()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
        super.touchesBegan(touches, withEvent: event)
    }
    
    // MARK: - UITextField methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.searchBar.resignFirstResponder()
        return true
    }
    
    // MARK: - UISearchBar methods
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        searchActive = false
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchActive = false
        self.searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.filteredVideos = self.videos.filter({ (video) -> Bool in
            let tmpVideo: Video = video
            let tmpTitle = tmpVideo.title
            let range = tmpTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range != nil
        })
        if searchText.isEmpty {
            self.searchActive = false
        }
        else {
            self.searchActive = true
        }
        self.tableView.reloadData()
    }
    
    // MARK: - UITableView methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.searchActive {
            return self.filteredVideos.count
        }
        return self.videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! VideosTableViewCell
        
        cell.backgroundColor = UIColor(white: 1, alpha: 1)
        
        if (indexPath.row % 2 != 0) {
            cell.backgroundColor = UIColor(white: 0.98, alpha: 1)
        }
        
        if self.searchActive {
            if !self.filteredVideos.isEmpty {
                cell.title.text = self.filteredVideos[indexPath.row].title
                cell.user.text = self.filteredVideos[indexPath.row].user
                _addTimers(self.filteredVideos, cell: cell, indexPath: indexPath)
            }
        }
        else {
            cell.title.text = self.videos[indexPath.row].title
            cell.user.text = self.videos[indexPath.row].user
            _addTimers(self.videos, cell: cell, indexPath: indexPath)
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = VideoViewController()
        vc.videoTitle = self.videos[indexPath.row].title
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Internal methods
    
    func hotPressed(sender: UIButton!)
    {
        self.hotBool = true
        self.newBool = false
        self.followBool = false
        
        _setAlphas()
        _sortVideos()
    }
    
    func newPressed(sender: UIButton!)
    {
        self.hotBool = false
        self.newBool = true
        self.followBool = false
        
        _setAlphas()
        _sortVideos()
    }
    
    func followPressed(sender: UIButton!)
    {
        self.hotBool = false
        self.newBool = false
        self.followBool = true
        
        _setAlphas()
        _sortVideos()
    }
    
    // MARK: - Private methods
    
    private func _generateVideos()
    {
        var sampleVideos = [Video]()
            
        let currentDate = NSDate()
            
        for index in 1...20 {
            let randomRating: NSInteger = Int(arc4random_uniform(10)) + 1
                
            sampleVideos.append(Video.init(newTitle: "Live Video \(index)", newUser: "sample user \(index)", newDatePosted: currentDate))
            
            sampleVideos[index-1].rating = randomRating
        }
        self.videos = sampleVideos
    }
    
    private func _sortVideos()
    {
        //self.videos.removeAll()
        
        if hotBool {
            /*
            for video in self.videos {
                //sort by hot
            }
            */
        }
        else if newBool {
            /*
            for video in self.videos {
                //sort by new
            }
            */
        }
        else if followBool {
            //get videos followed
        }
        
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    private func _setAlphas()
    {
        if hotBool {
            self.hotButton.alpha = 1
            self.newButton.alpha = 0.4
            self.followButton.alpha = 0.4
        }
        else if newBool {
            self.hotButton.alpha = 0.4
            self.newButton.alpha = 1
            self.followButton.alpha = 0.4
        }
        else if followBool {
            self.hotButton.alpha = 0.4
            self.newButton.alpha = 0.4
            self.followButton.alpha = 1
        }
    }
    
    private func _addTimers(vids: [Video], cell: VideosTableViewCell, indexPath: NSIndexPath) {
        if NSDate.init().timeIntervalSince1970 - vids[indexPath.row].datePosted.timeIntervalSince1970 < 10 {
            cell.timer.image = UIImage(named: "red_timer.png")
        }
        else if NSDate.init().timeIntervalSince1970 - vids[indexPath.row].datePosted.timeIntervalSince1970 < 20 {
            cell.timer.image = UIImage(named: "orange_timer.png")
        }
        else if NSDate.init().timeIntervalSince1970 - vids[indexPath.row].datePosted.timeIntervalSince1970 < 30 {
            cell.timer.image = UIImage(named: "yellow_timer.png")
        }
        else {
            cell.timer.image = UIImage(named: "green_timer.png")
        }
    }
    
    private func _addSearch()
    {
        self.searchBar = VideoSearchBar(frame: CGRectMake(0,22,self.view.frame.size.width,40), font: quicksandReg, textColor: UIColor.blackColor())
        self.searchBar.placeholder = "SEARCH"
        
        self.searchBar.delegate = self
        
        self.view.addSubview(searchBar)
    }
    
    private func _addScrollView()
    {
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 62, width: self.view.frame.width, height: 60))
        
        self.scrollView.bounces = false
        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.hotButton = UIButton(frame: CGRect(x: 0, y: 0, width: 130, height: 60))
        self.hotButton.setTitle("HOT", forState: .Normal)
        self.hotButton.setTitleColor(UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), forState: .Normal)
        self.hotButton.contentHorizontalAlignment = .Center
        self.hotButton.titleLabel?.font = UIFont(name: quicksandReg, size: 25)
        
        self.hotButton.addTarget(self, action: "hotPressed:", forControlEvents: .TouchUpInside)
//        self.hotButton.addTarget(self, action: #selector(VideosSearchViewController.hotPressed(_:)), forControlEvents: .TouchUpInside)
        
        self.scrollView.addSubview(hotButton)
        
        self.newButton = UIButton(frame: CGRect(x:0, y: 0, width: 130, height: 60))
        self.newButton.setTitle("NEW", forState: .Normal)
        self.newButton.setTitleColor(UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), forState: .Normal)
        self.newButton.contentHorizontalAlignment = .Center
        self.newButton.titleLabel?.font = UIFont(name: quicksandReg, size: 25)
        
        self.newButton.addTarget(self, action: "newPressed:", forControlEvents: .TouchUpInside)
//        self.newButton.addTarget(self, action: #selector(VideosSearchViewController.newPressed(_:)), forControlEvents: .TouchUpInside)
        
        var newFrame = self.newButton.frame
        newFrame.origin.x = self.hotButton.frame.width
        self.newButton.frame = newFrame
        
        self.scrollView.addSubview(newButton)
        
        self.followButton = UIButton(frame: CGRect(x:0, y: 0, width: 250, height: 60))
        self.followButton.setTitle("FOLLOWING", forState: .Normal)
        self.followButton.setTitleColor(UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1), forState: .Normal)
        self.followButton.contentHorizontalAlignment = .Center
        self.followButton.titleLabel?.font = UIFont(name: quicksandReg, size: 25)
        
        self.followButton.addTarget(self, action: "followPressed:", forControlEvents: .TouchUpInside)
//        self.followButton.addTarget(self, action: #selector(VideosSearchViewController.followPressed(_:)), forControlEvents: .TouchUpInside)
        
        var followFrame = self.followButton.frame
        followFrame.origin.x = self.hotButton.frame.width+self.newButton.frame.width
        self.followButton.frame = followFrame
        
        self.scrollView.addSubview(followButton)
        
        self.scrollView.contentSize = CGSizeMake(self.hotButton.frame.width+self.newButton.frame.width+self.followButton.frame.width, 60)
        
        let width = CGFloat(1.0)
        self.scrollBorderTop.borderColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1).CGColor
        self.scrollBorderTop.frame = CGRect(x: 0, y: width, width:  scrollView.contentSize.width, height: width)
        
        self.scrollBorderTop.borderWidth = width
        self.scrollView.layer.addSublayer(self.scrollBorderTop)
        self.scrollView.layer.masksToBounds = true

        self.scrollBorderBottom.borderColor = UIColor(red: fleetColorRed, green: fleetColorGreen, blue: fleetColorBlue, alpha: 1).CGColor
        self.scrollBorderBottom.frame = CGRect(x: 0, y: scrollView.frame.size.height - width, width:  scrollView.contentSize.width, height: scrollView.frame.size.height)
        
        self.scrollBorderBottom.borderWidth = width
        self.scrollView.layer.addSublayer(self.scrollBorderBottom)
        self.scrollView.layer.masksToBounds = true
        
        self.view.addSubview(scrollView)
    }
    
    private func _addTableView()
    {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 122, width: self.view.frame.width, height: self.view.frame.height - 122))
        
        self.tableView.registerClass(VideosTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorColor = UIColor(white: 1, alpha: 0)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(tableView)
    }
    
    private func _getVideos()
    {
        let manager = NetworkingManager.webSharedInstance.manager
        
        if (self.hotBool) {
            let parameters = ["order": "hot", "count": 10]
            manager.GET(Video.videoPath,
                parameters: parameters,
                progress: nil,
                success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                    if let jsonResult = responseObject as? Dictionary<String, AnyObject> {
                        let successful = jsonResult["success"] as? Bool
                        if (successful == false) {
                            print("Failed to get hot videos")
                        }
                        else if (successful == true) {
                            let resultVideos = jsonResult["videos"] as! [Dictionary<String, AnyObject>]
                            for resultVid in resultVideos {
                                let datePosted = NSDate.init(timeIntervalSince1970: resultVid["create-date"] as! NSTimeInterval)
                                self.videos.append(Video.init(newTitle: resultVid["title"]! as! String, newUser: resultVid["username"]! as! String, newDatePosted: datePosted))
                            }
                            
                            self.tableView.reloadData()
                        }
                    }
                    else {
                        print("Error: responseObject couldn't be converted to Dictionary")
                    }
                },
                failure: { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                    let errorMessage = "Error: " + error.localizedDescription
                    print(errorMessage)
                    
                    if let response = dataTask!.response as? NSHTTPURLResponse {
                        if (response.statusCode == 401) {
                            NetworkingManager.webSharedInstance.logout()
                        }
                    }
                }
            )
        }
        else if (self.newBool) {
            let parameters = ["order": "new", "count": 10]
            manager.GET(Video.videoPath,
                parameters: parameters,
                progress: nil,
                success: { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                    if let jsonResult = responseObject as? Dictionary<String, AnyObject> {
                        let successful = jsonResult["success"] as? Bool
                        if (successful == false) {
                            print("Failed to get new videos")
                        }
                        else if (successful == true) {
                            let resultVideos = jsonResult["videos"] as! [Dictionary<String, AnyObject>]
                            for resultVid in resultVideos {
                                let datePosted = NSDate.init(timeIntervalSince1970: resultVid["create-date"] as! NSTimeInterval)
                                self.videos.append(Video.init(newTitle: resultVid["title"]! as! String, newUser: resultVid["username"]! as! String, newDatePosted: datePosted))
                            }
                            
                            self.tableView.reloadData()
                        }
                    }
                    else {
                        print("Error: responseObject couldn't be converted to Dictionary")
                    }
                },
                failure: { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
                    let errorMessage = "Error: " + error.localizedDescription
                    print(errorMessage)
                    
                    if let response = dataTask!.response as? NSHTTPURLResponse {
                        if (response.statusCode == 401) {
                            NetworkingManager.webSharedInstance.logout()
                        }
                    }
                }
            )

        }
    }
    
}