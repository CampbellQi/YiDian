//
//  ProgressHUD.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/30.
//  Copyright © 2016年 sss. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface WQProgressHUD : SVProgressHUD
+ (void)showWithStatus:(NSString *)status;
+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showProgress:(float)progress status:(NSString *)status;
+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showSuccessWithStatus:(NSString *)string;
@end
