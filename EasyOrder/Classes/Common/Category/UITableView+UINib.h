//
//  UITableView+UINib.h
//  TestUINib
//
//  Created by vernepung on 16/5/3.
//  Copyright © 2016年 vernepung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (UINib)
/**
 *  当前tableView已经注册的Nib,readonly 方便debug查看
 *  实际开发并不需要调用此属性
 */
@property (strong,nonatomic,readonly) NSMutableArray *registerNibArray;

- (BOOL)registeredIdentifier:(NSString *)identifier;

@end
