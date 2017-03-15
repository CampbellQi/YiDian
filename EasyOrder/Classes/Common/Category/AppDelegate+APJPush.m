//
//  AppDelegate+APJPush.m
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/6/5.
//  Copyright © 2016年 sss. All rights reserved.
//

#import "AppDelegate+APJPush.h"

@implementation AppDelegate (APJPush)

/*
- (void) registerUMessage:(NSDictionary *)launchOptions {
    //初始化友盟推送
    [UMessage startWithAppkey:kUmengMessage launchOptions:launchOptions];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    
    
    [UMessage setLogEnabled:YES];
}

- (void)receiveRemoteNotificationApplication:(UIApplication *)application UserInfo:(NSDictionary *)userInfo {
    QYTabBarController *tabarVC = self.mainTab;
    NSInteger pushType = [userInfo[@"pushtype"] intValue];
    if (application.applicationState == UIApplicationStateActive) {
        NSString *alertTitle = @"";
        switch (pushType) {
            case 1:
                alertTitle = @"您有一条可接诊订单，是否立即查看？";
                break;
            case 2:
                alertTitle = @"您有一条派单，是否立即查看？";
                break;
            default:
                break;
        }
        WQAlertView *alertView = [[WQAlertView alloc] init];
        [alertView showAlertWithCurrentViewController:tabarVC Title:alertTitle Message:nil ConfirmName:@"查看" CancelName:@"取消" ConfirmBlock:^{
            [self handleReceiveMessage:pushType];
        } CancelBlock:^{
            
        }];
        NSLog(@"%@",userInfo);
        
    } else if(application.applicationState == UIApplicationStateInactive)
    {
        [self handleReceiveMessage:pushType];
        NSLog(@"%@",userInfo);
    }
    
    
}

- (void)handleReceiveMessage:(NSInteger)pushType {
    QYTabBarController *tabarVC = self.mainTab;
    switch (pushType) {
        case 1:
        {
            [tabarVC viewControllers];
            [tabarVC setSelectedIndex:0];
            UINavigationController *vc = tabarVC.selectedViewController;
            [vc popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:ReloadReceiveListNF object:nil];
            break;
        }
        case 2:
        {
            [tabarVC viewControllers];
            [tabarVC setSelectedIndex:1];
            UINavigationController *vc = tabarVC.selectedViewController;
            [vc popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:ReloadOrderListNF object:nil];
            break;
        }
        default:
            break;
    }
}
//注册deviceToken
- (void)requestRegisterDeviceToken{
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_TOKEN];
    if (deviceToken && [Global isLogin]) {
        BaseRequest *request = [[BaseRequest alloc] initWithUrl:DoctorSetInfo_URL params:nil];
        [request setValue:[Global getUserId] forKey:@"doctorid"];
        [request setValue:deviceToken forKey:@"phone_id"];
        [request setValue:@"1" forKey:@"device_type"];
        
        request.requestSuccBlock = ^(BaseRequest *request) {
            
        };
        
        request.requestFailBlock = ^(NSString *error) {
            
        };
        request.requestFinalBlock = ^(BaseRequest *request) {
            
        };
        
        [request sendRequest];
    }
    
}
*/
@end
