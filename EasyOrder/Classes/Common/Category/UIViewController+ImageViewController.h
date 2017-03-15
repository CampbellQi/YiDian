//
//  UIViewController+ImageViewController.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/30.
//  Copyright © 2016年 sss. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CompletedBlock) (UIImage *image);

@interface UIViewController (ImageViewController)
@property (nonatomic, copy)CompletedBlock completedBlock;

/**
 * 系统原生actionsheet，方法进行拍照、选择照片
 */
-(void)showPhotoAlertSheet;
@end
