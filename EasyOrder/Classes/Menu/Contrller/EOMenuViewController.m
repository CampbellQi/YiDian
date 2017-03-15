//
//  EOMenuViewController.m
//  EasyOrder
//
//  Created by fengwanqi on 16/6/9.
//  Copyright © 2016年 yidian. All rights reserved.
//

#import "EOMenuViewController.h"
#import "EOMenuCell.h"

@interface EOMenuViewController ()
{
    EOMenuCell *_propertyCell;
}
@end

@implementation EOMenuViewController
#pragma mark Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUpView {
    _propertyCell = [EOMenuCell initCellFromNibWithTableView:self.tableView];
}
#pragma mark TableView Delegate Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EOMenuCell *cell = [EOMenuCell initCellFromNibWithTableView:self.tableView];
    //cell.contentLbl.text = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(_propertyCell.frame);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    //    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
