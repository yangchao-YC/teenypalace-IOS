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

      
        
        UMessage.startWithAppkey("54ace3b6fd98c5ad2f000edb", launchOptions: launchOptions)
        
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch)
        {
        case .OrderedSame, .OrderedDescending:
            
            //register remoteNotification types
            let action1 = UIMutableUserNotificationAction()
            action1.identifier = "action1_identifier"
            action1.title = "Accept"
            action1.activationMode = .Background;//当点击的时候启动程序
            
            let action2 = UIMutableUserNotificationAction()  //第二按钮
            action2.identifier = "action2_identifier"
            action2.title = "Reject"
            action2.activationMode = .Background //当点击的时候不启动程序，在后台处理
            action2.authenticationRequired = true //需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground则这个属性被忽略；
            action2.destructive = true
            
            let categorys = UIMutableUserNotificationCategory()
            categorys.identifier = "category1" //这组动作的唯一标示
            
            categorys.setActions([action1,action2], forContext: .Default)
            
            let category : NSSet = NSSet(object: categorys)
            let userSettings = UIUserNotificationSettings(forTypes: .Badge | .Sound | .Alert, categories:  category as Set<NSObject>)
            
            UMessage.registerRemoteNotificationAndUserNotificationSettings(userSettings)
            
        case .OrderedAscending:
            
            UMessage.registerForRemoteNotificationTypes(.Badge | .Sound | .Alert)
            
        }
        
        UMessage.setLogEnabled(true)
        
        return true
    }

    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        
        
        UMessage.registerDeviceToken(deviceToken)

        
     //   println("didRegisterForRemoteNotificationsWithDeviceToken success")
        
        
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        UMessage.setAutoAlert(false)
        UMessage.didReceiveRemoteNotification(userInfo)
    }
    
    
    /*
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
       // var error_str: String = error
        
        println(error)
        
    }
    */
    
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

