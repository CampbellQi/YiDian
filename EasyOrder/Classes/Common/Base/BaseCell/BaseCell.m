//
//  BaseCell.m
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/26.
//  Copyright © 2016年 sss. All rights reserved.
//
#pragma mark - 1像素宽度/高度
#define kOnePixelWidth  1.0f / [UIScreen mainScreen].scale
#define kSeparatorLineColor RGB(224.0f, 224.0f, 224.0f)

#import "BaseCell.h"
#import "UITableView+UINib.h"

@implementation BaseCell
+ (UINib *)loadNibFromXib
{
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

+ (instancetype)initCellFromNibWithTableView:(UITableView *)tableView
{
    [self registerNibWithTableview:tableView];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[self class] cellIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (void)registerNibWithTableview:(UITableView *)tableView
{
    if (![tableView registeredIdentifier:[self cellIdentifier]])
    {
        UINib *nib = [self loadNibFromXib];
        [tableView registerNib:nib forCellReuseIdentifier:[self cellIdentifier]];
    }
}
+ (id)loadFromCellStyle:(UITableViewCellStyle)cellStyle
{
    return [[self alloc] initWithStyle:cellStyle reuseIdentifier:NSStringFromClass(self)];
}


#pragma mark - other function
- (void)addBottomSeparatorView:(CGFloat)hMargin {
    self.bottomSeparatorView.frame = CGRectMake(hMargin, self.contentView.height - kOnePixelWidth, kMainBoundsWidth - 2*hMargin, kOnePixelWidth);
    [self.contentView addSubview:self.bottomSeparatorView];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    // 屏蔽iOS8.2下xib错误间距
    if (iOSVersion > 8.0)
    {
        self.preservesSuperviewLayoutMargins = NO;
    }
    //     self.contentView.backgroundColor = [UIColor whiteColor];
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, self.bounds.size.height)];
    bgView.backgroundColor = RGB(240, 240, 240);
    self.selectedBackgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

+(CGFloat)rowHeightForObject:(id)object
{
    return 0;
}

+ (NSString*)cellIdentifier
{
    return NSStringFromClass(self);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_isBottomLine) {
        //[Helper createBottomSeperatorLineView:self.contentView];
    }
}

- (void)fillCellWithObject:(id)object {
    
}

#pragma mark Getter & Setter
- (UIView *)bottomSeparatorView
{
    if (!_bottomSeparatorView)
    {
        _bottomSeparatorView = [[UIView alloc]init];
        _bottomSeparatorView.backgroundColor = kSeparatorLineColor;
        _bottomSeparatorView.tag = 19902;
    }
    return _bottomSeparatorView;
}
@end
