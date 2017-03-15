//
//  MJRefreshViewController.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/26.
//  Copyright © 2016年 sss. All rights reserved.
//

#import "BaseViewController.h"

@interface MJRefreshViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView* tableView;

-(void)initLoading;

- (void)loadData;

- (void)reloadTableViewData;

- (void)doneLoadingTableViewData;

-(void)loadMoreTableViewData;
@end
