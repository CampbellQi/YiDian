//
//  CustomBarButtonItem.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/6/2.
//  Copyright © 2016年 sss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomBarButtonItem : NSObject
+(UIBarButtonItem *)backBarButtonItemTarget:(id)target Action:(SEL)action;
+(UIBarButtonItem *)rightWithBgBarButtonItemTitle:(NSString *)title Target:(id)target Action:(SEL)action;
+(UIBarButtonItem *)rightBarButtonItemTitle:(NSString *)title Target:(id)target Action:(SEL)action;
@end
