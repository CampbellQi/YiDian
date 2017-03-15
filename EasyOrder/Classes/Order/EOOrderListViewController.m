//
//  EOOrderListViewController.m
//  EasyOrder
//
//  Created by 冯万琦 on 16/5/25.
//  Copyright © 2016年 yidian. All rights reserved.
//

#import "EOOrderListViewController.h"
#import "EOOrderCell.h"

@interface EOOrderListViewController ()
{
    NSArray *_dataArray;
    EOOrderCell *_propertyCell;
    NSString *_identifyID;
}
@end

@implementation EOOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _identifyID = NSStringFromClass([EOOrderCell class]);
    UINib *nib = [UINib nibWithNibName:_identifyID bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:_identifyID];
    _propertyCell = [self.tableView dequeueReusableCellWithIdentifier:_identifyID];
}
#pragma mark TableView Delegate Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EOOrderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:_identifyID];
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
