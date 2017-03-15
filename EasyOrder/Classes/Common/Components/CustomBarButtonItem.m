//
//  CustomBarButtonItem.m
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/6/2.
//  Copyright © 2016年 sss. All rights reserved.
//

#import "CustomBarButtonItem.h"

@implementation CustomBarButtonItem
+(UIBarButtonItem *)backBarButtonItemTarget:(id)target Action:(SEL)action{
    //导航返回
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(15, 0, 12, 25);
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
+(UIBarButtonItem *)rightWithBgBarButtonItemTitle:(NSString *)title Target:(id)target Action:(SEL)action {
    //导航发送
    UIColor *pColor = [UIColor colorWithRed:227.0/255 green:95.0/255 blue:147.0/255 alpha:1];
    UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //publishBtn.layer.cornerRadius = 4.0f;
    [publishBtn setBackgroundColor:[UIColor whiteColor]];
    publishBtn.frame = CGRectMake(15, 0, 55, 25);
    publishBtn.layer.cornerRadius = CGRectGetHeight(publishBtn.frame) * 0.5;
    publishBtn.layer.masksToBounds = YES;
    [publishBtn setTitle:title forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [publishBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [publishBtn setTitleColor:pColor forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc]initWithCustomView:publishBtn];
}
+(UIBarButtonItem *)rightBarButtonItemTitle:(NSString *)title Target:(id)target Action:(SEL)action {
    //导航发送
    UIColor *pColor = [UIColor whiteColor];
    UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //publishBtn.layer.cornerRadius = 4.0f;
    publishBtn.layer.cornerRadius = CGRectGetHeight(publishBtn.frame) * 0.5;
    publishBtn.layer.masksToBounds = YES;
    [publishBtn setTitle:title forState:UIControlStateNormal];
    CGSize size = [publishBtn.titleLabel sizeThatFits:CGSizeMake(1000, 44)];
    publishBtn.frame = CGRectMake(0, 0, size.width, 44);
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [publishBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [publishBtn setTitleColor:pColor forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc]initWithCustomView:publishBtn];
}
@end
