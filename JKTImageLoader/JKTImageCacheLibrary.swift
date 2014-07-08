//
//  JKTImageCacheLibrary.swift
//  JKTImageLoader
//
//  Created by Jeethu on 10/06/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//
/*Copyright © 2014 by Jeethu Thomas
All rights reserved. This file or any portion thereof
may not be reproduced or used in any manner whatsoever
without the express written permission of the owner.

http://iosdevelopersforum.blogspot.in
*/



import Foundation
import UIKit

class JKTImageCacheLibrary:NSObject
{
    var directoryPath=String()
    var placeHolder=UIImage()
    var TempDir:String="JKTemp"
    init()
    {
        super.init()
        self.createTempDirectory()
    }
    
    func createTempDirectory()
    {
        var error:NSError=NSError()
        var dirUrl:NSURL=NSURL(fileURLWithPath: NSTemporaryDirectory().stringByAppendingPathComponent(TempDir), isDirectory: true)
        directoryPath=dirUrl.path
        NSFileManager.defaultManager().createDirectoryAtURL(dirUrl, withIntermediateDirectories: true, attributes: nil, error:nil)
    }
    
    func startRotating(imgV:UIImageView)
    {
        var activity:UIActivityIndicatorView=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activity.color=UIColor.orangeColor()
        activity.center=CGPointMake(CGRectGetMidX(imgV.bounds), CGRectGetMidY(imgV.bounds))
        activity.hidesWhenStopped=true
        imgV.addSubview(activity)
        activity.startAnimating()
    }
    func stopRotating(imgV:UIImageView)
    {
        for view : AnyObject in imgV.subviews
        {
            
            view.stopAnimating()
        }
    }
    
    func setImage(imgView:UIImageView,imgUrl:String)
    {
        self.startRotating(imgView)
        if !placeHolder.isEqual(nil)
        {
            imgView.image=UIImage(named: "head.jpg")
        }
        var fileName:String=imgUrl.lastPathComponent.stringByDeletingPathExtension
        var uniquePath:String=directoryPath.stringByAppendingPathComponent(fileName)
        
        if NSFileManager.defaultManager().fileExistsAtPath(uniquePath)
        {
            imgView.image=UIImage(contentsOfFile: uniquePath)
            self.stopRotating(imgView)
        }
        else
        {
            getImage(imgUrl, completion: {(message: String?, error: NSError?) in
                if message=="success"
                {
                    imgView.image=UIImage(contentsOfFile: uniquePath)
                }
                self.stopRotating(imgView)
                });
        }
    }
    
    func getImage(imgUrl:String, completion:(message:String?, error:NSError?) -> Void)
    {        var fileName:String=imgUrl.lastPathComponent.stringByDeletingPathExtension
        var uniquePath:String=directoryPath.stringByAppendingPathComponent(fileName)
        var request:NSMutableURLRequest=NSMutableURLRequest(URL: NSURL(string: imgUrl));
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response, data, error) in
            if !error
            {
                var image:UIImage=UIImage(data: data)
                UIImageJPEGRepresentation(image, 100).writeToFile(uniquePath, atomically: true)
                completion(message: "success", error: nil);
            }
            else
            {
                completion(message: "failed", error: nil);
            }
            
            });
    }
    
    func clearJKTCache()
    {
        var tmpDirectoryArray:Array=NSFileManager.defaultManager().contentsOfDirectoryAtPath(directoryPath, error: nil)
        for file:AnyObject in tmpDirectoryArray
        {
            NSFileManager.defaultManager().removeItemAtPath(directoryPath.stringByAppendingString("/").stringByAppendingString(file as String), error: nil)
            println(directoryPath.stringByAppendingString(file as String))
        }
    }
    
}