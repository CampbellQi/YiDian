//
//  BaseNavigationController.m
//  EasyOrder
//
//  Created by fengwanqi on 16/6/9.
//  Copyright © 2016年 yidian. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置页面坐标起始位置是导航栏下边
    self.navigationBar.translucent = NO;
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:232/255.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationBar.titleTextAttributes = dict;
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    NSInteger count = self.childViewControllers.count;
    if (count >= 1) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        
        
    }
    [super pushViewController:viewController animated:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
