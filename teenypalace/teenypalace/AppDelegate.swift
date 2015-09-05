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
   
    var UserName: String = ""//账号
    var ParentId: String = ""//家长ID
    var LastloginTime: String = ""//最后登陆时间
    var Login: Bool = false//判断是否登陆
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        MobClick.startWithAppkey("54ace3b6fd98c5ad2f000edb", reportPolicy: BATCH, channelId:nil)
        
        MobClick.checkUpdate()
        
        UMSocialData.setAppKey("54ace3b6fd98c5ad2f000edb")
        
        UMSocialWechatHandler.setWXAppId("wx7f38e71156855bcc", appSecret: "d6898fad7cec6771feee6f6cc93dd3aa", url: "http://www.ycpwh.cn/")
        
        
       // var version = NSBundle.mainBundle().infoDictionary?.indexForKey("CFBundleShortVersionString")
        
        let info = NSBundle.mainBundle().infoDictionary as NSDictionary?
        
        let version = info?.objectForKey("CFBundleShortVersionString") as! String

        MobClick.setAppVersion(version)

        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "tabbar_bg"), forBarMetrics: UIBarMetrics.Default)

      
        /*
        UMessage.startWithAppkey("54ace3b6fd98c5ad2f000edb", launchOptions: launchOptions)
        
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
        if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0"))
            {
        
            }
        #else
            
            
        #endif
        UMessage.setLogEnabled(true)
        */
        return true
    }

    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        
        UMessage.registerDeviceToken(deviceToken)

        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        UMessage.didReceiveRemoteNotification(userInfo)
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

