//
//  BaseViewController.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/26.
//  Copyright © 2016年 sss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)(id);
@interface BaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *keyBoardSuperSV;
@property (copy, nonatomic)BackBlock backBlock;
- (void)setUpView;
- (void)setUpData;

- (void)backBtnClicked;

-(void)listenKeyboard;
- (void)hideKeyboard;
@end
