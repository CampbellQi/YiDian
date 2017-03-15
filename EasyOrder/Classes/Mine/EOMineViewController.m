//
//  MineViewController.m
//  EasyOrder
//
//  Created by 冯万琦 on 16/5/25.
//  Copyright © 2016年 yidian. All rights reserved.
//

#import "EOMineViewController.h"
#import "EOMineView.h"
#import "EOMineCell.h"

@interface EOMineViewController ()
{
    NSArray *_dataArray;
    EOMineCell *_propertyCell;
    NSString *_identifyID;
}
@property (nonatomic, strong)UIView *headerView;
@end

@implementation EOMineViewController

#pragma mark Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _identifyID = NSStringFromClass([EOMineCell class]);
    UINib *nib = [UINib nibWithNibName:_identifyID bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:_identifyID];
    _propertyCell = [self.tableView dequeueReusableCellWithIdentifier:_identifyID];
}

- (void)setUpData {
    _dataArray = @[@"当前菜单", @"足迹", @"设置"];
}

- (void)setUpView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, CGRectGetHeight(self.headerView.frame))];
    headerView.backgroundColor = [UIColor purpleColor];
    headerView.clipsToBounds = YES;
    float width = CGRectGetWidth(self.headerView.frame);
    DLog(@"width = %f",width);
    self.headerView.frame = CGRectMake(0, 0, width, CGRectGetHeight(self.headerView.frame));
    [headerView addSubview:self.headerView];
    self.tableView.tableHeaderView = headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegate Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EOMineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:_identifyID];
    cell.contentLbl.text = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(_propertyCell.frame);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark Getter & Setter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EOMineView class]) owner:self options:nil][0];
    }
    return _headerView;
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
