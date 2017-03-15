//
//  AppDelegate+APJPush.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/6/5.
//  Copyright © 2016年 sss. All rights reserved.
//
#define DEVICE_TOKEN @"deviceToken"

#import "AppDelegate.h"

@interface AppDelegate (APJPush)
- (void) registerUMessage:(NSDictionary *)launchOptions;
- (void)receiveRemoteNotificationApplication:(UIApplication *)application UserInfo:(NSDictionary *)userInfo;
- (void)requestRegisterDeviceToken;
@end
