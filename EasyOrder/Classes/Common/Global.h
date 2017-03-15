//
//  LSGlobal.h
//  _6.0
//
//  Created by 刘 智平 on 13-10-22.
//  Copyright (c) 2013年 刘 智平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EOUserModel.h"

@interface Global : NSObject<NSCoding>

+ (Global *)sharedGlobal;
/**
 *  save方法由Appdelegate自动调用，禁止手动调用
 */
+ (void)save;
/**
 *  当前用户信息
 */
@property (strong,nonatomic) EOUserModel* currentUser;

/**
 *  是否是QQ登陆
 */
@property (assign,nonatomic) BOOL qqLogined;
/**
 *  是否已经提示过更新信息
 */
@property (assign,nonatomic) BOOL isCheckedUpdate;
/**
 *  上次检查的日期
 */
@property (copy,nonatomic) NSString *lastUpdateDateStr;
/**
 *  消息小红点
 */
@property (assign,nonatomic) NSInteger msgRedNotification;
/**
 *  极光推送的registerId
 */
@property (strong,nonatomic) NSString* registerId;;
/**
 *  是否提醒过上传头像
 */
@property (assign,nonatomic) BOOL isRemindedUploadHeader;

+(BOOL)isLogin;
+(NSString*)getUserId;

@property (nonatomic, assign)BOOL needWifiAlert;
+ (void)clear;
@end
