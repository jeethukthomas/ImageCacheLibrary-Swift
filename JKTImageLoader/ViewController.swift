//
//  ViewController.swift
//  JKTImageLoader
//
//  Created by Jeethu on 10/06/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet var img : UIImageView = nil
    @IBOutlet var img2 : UIImageView = nil
    @IBOutlet var img3 : UIImageView = nil
    @IBOutlet var img4 : UIImageView = nil
    @IBOutlet var img5 : UIImageView = nil
    @IBOutlet var img6 : UIImageView = nil
    
    let obj=JKTImageCacheLibrary()
    @IBAction func clearCache(sender : AnyObject) {
        obj.clearJKTCache()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        obj.placeHolder=UIImage(named: "head.jpg")
    }
    
    override func viewDidAppear(animated: Bool)
    {
        obj.setImage(img, imgUrl: "http://p1.pichost.me/i/48/1711032.jpg");
        obj.setImage(img6, imgUrl: "http://www.youtubedownloaderhd.com/images/youtube-hd.jpg");
        obj.setImage(img2, imgUrl: "http://www.aiowallpaper.com/wp-content/uploads/2014/01/blue_abstract_1080p_hd_wallpapers.jpg");
        obj.setImage(img3, imgUrl: "http://www.hdwallpapers.in/walls/green_lime_hdtv_1080p-HD.jpg");
        obj.setImage(img4, imgUrl: "http://www.hdwallpapers.in/walls/race_driver_grid_2-HD.jpg");
        obj.setImage(img5, imgUrl: "http://www.hdwallpapers.in/walls/light_blaze_hd_1080p-HD.jpg");
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

