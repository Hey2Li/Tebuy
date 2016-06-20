//
//  AppDelegate.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/13.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <KeyboardManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [BaseTabBarViewController new];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString *resultStatus =
            [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
            if ([resultStatus isEqualToString:@"9000"]) {
                [self.window makeToast:@"已付款成功"];
            }else if ([resultStatus isEqualToString:@"8000"]){
                [self.window makeToast:@"正在处理中"];
            }else if ([resultStatus isEqualToString:@"4000"]){
                [self.window makeToast:@"订单支付失败"];
            }else if ([resultStatus isEqualToString:@"6001"]){
                [self.window makeToast:@"用户中途取消"];
            }else if ([resultStatus isEqualToString:@"6002"]){
                [self.window makeToast:@"网络连接出错"];
            }
        }];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
