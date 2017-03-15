//
//  EOMenuSliderViewController.m
//  EasyOrder
//
//  Created by fengwanqi on 16/6/9.
//  Copyright © 2016年 yidian. All rights reserved.
//

#import "EOMenuSliderViewController.h"
#import "EOMenuViewController.h"
#import "EOShopViewController.h"
#import "NavSliderScrollView.h"

@interface EOMenuSliderViewController ()<NavSliderScrollViewDelegate>
{
    NavSliderScrollView *_sliderView;
}
@end

@implementation EOMenuSliderViewController
#pragma mark Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUpView {
    self.title = @"雅座（01）";
    _sliderView = [[NavSliderScrollView alloc] initWithFrame:self.view.bounds TitlesArray:@[@{@"name": @"点餐"}, @{@"name": @"商家信息"}] FirstView:[self getShowItemViewWithIndex:0]];
    _sliderView.delegate = self;
    [self.view addSubview:_sliderView];
}
#pragma mark NavSliderScrollView Delegate
- (UIView *)getShowItemViewWithIndex:(int)index {
    switch (index) {
        case 0:
        {
            EOMenuViewController *menuVC = [[EOMenuViewController alloc] init];
            [self addChildViewController:menuVC];
            return menuVC.view;
            break;
        }
            case 1:
        {
            EOShopViewController *shopVC = [[EOShopViewController alloc] init];
            [self addChildViewController:shopVC];
            return shopVC.view;
            break;
            
        }
            default:
            return [UIView new];
    }
}
- (void)scrollAtIndex:(int)index {

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
