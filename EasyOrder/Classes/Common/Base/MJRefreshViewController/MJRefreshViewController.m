//
//  MJRefreshViewController.m
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/26.
//  Copyright © 2016年 sss. All rights reserved.
//

#define MJDuration 0.0

#import "MJRefreshViewController.h"
#import <MJRefresh.h>
#import "DMMJRefreshGifHeader.h"
#import "DMMJRefreshBackGifFooter.h"

@interface MJRefreshViewController ()

@end

@implementation MJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.mj_header = [DMMJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTableViewData)];
    self.tableView.mj_footer = [DMMJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableViewData)];
    
    [self setUpView];
    [self setUpData];
}

-(void)initLoading
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData {

}
-(void)loadMoreTableViewData
{
    
}

-(void)reloadTableViewData
{
    
}

- (void)doneLoadingTableViewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
    
    
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
