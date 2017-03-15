//
//  ProgressHUD.m
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/30.
//  Copyright © 2016年 sss. All rights reserved.
//

#import "WQProgressHUD.h"

@implementation WQProgressHUD

+ (void)showWithStatus:(NSString *)status {
    [super showWithStatus:status maskType:SVProgressHUDMaskTypeBlack];
}

+ (void)showInfoWithStatus:(NSString *)string {
    [super showInfoWithStatus:string maskType:SVProgressHUDMaskTypeBlack];
}

+ (void)showProgress:(float)progress status:(NSString *)status {
    [super showProgress:progress status:status maskType:SVProgressHUDMaskTypeBlack];
}

+ (void)showErrorWithStatus:(NSString *)string {
    [super showErrorWithStatus:string maskType:SVProgressHUDMaskTypeBlack];
}

+ (void)showSuccessWithStatus:(NSString *)string {
    [super showSuccessWithStatus:string maskType:SVProgressHUDMaskTypeBlack];
}
@end
