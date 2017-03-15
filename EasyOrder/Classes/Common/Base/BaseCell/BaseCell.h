//
//  BaseCell.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/26.
//  Copyright © 2016年 sss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (assign,nonatomic) NSInteger selectSection;
@property (assign,nonatomic) NSInteger selectIndex;
@property (assign,nonatomic) NSInteger totalCount;
@property (assign,nonatomic) CGFloat    cellHeight;
@property (assign,nonatomic) BOOL    isBottomLine;
@property (strong,nonatomic) UIView *bottomSeparatorView;
/**
 *  添加底部横线
 */
- (void)addBottomSeparatorView:(CGFloat)hMargin;
/**
 *  加载UINib文件
 *
 *  @return nib
 */
+ (UINib *)loadNibFromXib;
/**
 *  直接根据Cell注册UINib，并返回实例
 *
 *  @param tableView 需要注册当前Cell类型的TableView
 *
 *  @return 实例
 */
+ (instancetype)initCellFromNibWithTableView:(UITableView *)tableView;
/**
 *  注册UINib文件
 *
 *  @param tableView  需要注册当前Cell类型的TableView
 */
+ (void)registerNibWithTableview:(UITableView *)tableView;
/**
 *  用代码创建Cell时候设置的cellIdentifier
 *
 *  @return cellIdentifier;
 */
+(NSString*)cellIdentifier;
/**
 *  用代码创建Cell
 *
 *  @return self;
 */

+(id)loadFromCellStyle:(UITableViewCellStyle)cellStyle;

/**
 *  填充cell的对象
 *  子类去实现
 */

- (void)fillCellWithObject:(id)object;

/**
 *  计算cell高度
 *  子类去实现
 */

+ (CGFloat)rowHeightForObject:(id)object;
@end
