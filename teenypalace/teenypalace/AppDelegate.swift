//
//  AppDelegate.swift
//  teenypalace
//
//  Created by 杨超 on 14/11/4.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        MobClick.startWithAppkey("54ace3b6fd98c5ad2f000edb", reportPolicy: BATCH, channelId:nil)
        
        MobClick.checkUpdate()
        
        UMSocialData.setAppKey("54ace3b6fd98c5ad2f000edb")
        
        UMSocialWechatHandler.setWXAppId("wx68c8d3985e6498c6", appSecret: "9f35d31c7880287d217d12e1f63e1440", url: "http://www.ycpwh.cn/")
        
        
       // var version = NSBundle.mainBundle().infoDictionary?.indexForKey("CFBundleShortVersionString")
        
        let info = NSBundle.mainBundle().infoDictionary as NSDictionary?
        
        let version = info?.objectForKey("CFBundleShortVersionString") as String
        
        
        print(version)
        
        
        MobClick.setAppVersion(version)
        
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "tabbar_bg"), forBarMetrics: UIBarMetrics.Default)
        
        
    
        
        return true
    }

    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

