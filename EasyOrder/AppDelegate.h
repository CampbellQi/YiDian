//
//  AppDelegate.h
//  EasyOrder
//
//  Created by 冯万琦 on 16/5/25.
//  Copyright © 2016年 yidian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *mainNavigationController;
@property (strong, nonatomic) LeftSlideViewController *leftSlideVC;

@end

