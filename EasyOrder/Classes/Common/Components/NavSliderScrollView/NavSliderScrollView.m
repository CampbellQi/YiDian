//
//  WQNavSliderScrollView.m
//  DocumentaryChina
//
//  Created by fengwanqi on 14-7-24.
//  Copyright (c) 2014年 com.uwny. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BUTTON_FONT [UIFont systemFontOfSize:14]
#define BUTTON_BIG_FONT [UIFont systemFontOfSize:14]
#define kButtonTagStart 100
#define LINE_HIGHT 2
#define STATUS_LINE_HIGHT 1

#define TITLE_NAME @"name"
#define TITLE_STATUSCODE @"status"

#define MAINSCROLLCOLOR [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]

#define TITLEBTN_NORMAL_COLOR UIColorFromRGB(0x666666)
#define TITLEBTN_SELECTED_COLOR UIColorFromRGB(0x1DA7D6)

#define TITLESV_HEIGHT 44

#define LINEBG_COLOR TITLEBTN_SELECTED_COLOR

#define STATUS_LINE_BGCOLOR [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]

#import "NavSliderScrollView.h"
//#import "UIColor+Dice.h"
#import "NavSliderButton.h"

@implementation NavSliderScrollView
{
    UIScrollView *_titleSV;
    UIScrollView *_contentSV;
    NSArray *_titlesArray;
    
    NSMutableArray *_buttonArray;
    UILabel *_lineLbl;
    UIButton *_selectedTitleBtn;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame TitlesArray:(NSArray *)titlesArray FirstView:(UIView *)firstView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
        _titlesArray=titlesArray;
        _contentViewArray= [NSMutableArray arrayWithArray:titlesArray];
        
        _titleSV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, TITLESV_HEIGHT)];
        _titleSV.delegate = self;
        _titleSV.showsHorizontalScrollIndicator = NO;
        _titleSV.pagingEnabled = NO;
        _titleSV.backgroundColor=[UIColor clearColor];
        [self addSubview:_titleSV];
        //添加标题按钮
        float space = 10;
        //int width = frame.size.width / _titlesArray.count;
        _buttonArray = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < _titlesArray.count; i++)
        {
            NavSliderButton *button = [NavSliderButton buttonWithType:UIButtonTypeCustom];
            button.statusCode = [_titlesArray objectAtIndex:i][TITLE_STATUSCODE];
            //button.backgroundColor = [UIColor redColor];
            button.titleLabel.font = BUTTON_FONT;
            [button setTitleColor:TITLEBTN_NORMAL_COLOR forState:UIControlStateNormal];
            [button setTitleColor:TITLEBTN_SELECTED_COLOR forState:UIControlStateSelected];
            NSString *title = [_titlesArray objectAtIndex:i][TITLE_NAME];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = kButtonTagStart+i;
            
            float buttonHeight = CGRectGetHeight(_titleSV.frame);
            CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:BUTTON_BIG_FONT,NSPaperSizeDocumentAttribute:[NSValue valueWithCGSize:CGSizeMake(MAXFLOAT, buttonHeight)]}];
            //CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 25) lineBreakMode:NSLineBreakByWordWrapping];
            
            button.frame = CGRectMake(space, 0, size.width, buttonHeight);
            space += size.width;
            
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [_titleSV addSubview:button];
            [_buttonArray addObject:button];
            
            //状态栏下横线
            UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_titleSV.frame) - STATUS_LINE_HIGHT, CGRectGetWidth(_titleSV.frame), STATUS_LINE_HIGHT)];
            //lineView.image = [UIImage imageNamed:@"topic_detail_dividing_line"];
            lineView.backgroundColor = STATUS_LINE_BGCOLOR;
            [_titleSV addSubview:lineView];
            
            if (i==0) {
                _lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_titleSV.frame) - LINE_HIGHT - STATUS_LINE_HIGHT, size.width, LINE_HIGHT)];
                _lineLbl.backgroundColor=LINEBG_COLOR;
                _lineLbl.centerX = button.centerX;
                [_titleSV addSubview:_lineLbl];
                button.selected=YES;
                _lineLbl.tag=button.tag+100;
                _selectedTitleBtn=button;
                _selectedTitleBtn.titleLabel.font = BUTTON_BIG_FONT;
            }
        }
        _titleSV.contentSize = CGSizeMake(space + 10, 0.0);
        
        
        
        //添加内容
        _contentSV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, TITLESV_HEIGHT, frame.size.width, frame.size.height-TITLESV_HEIGHT)];
        _contentSV.delegate = self;
        _contentSV.contentSize = CGSizeMake(self.bounds.size.width * titlesArray.count, frame.size.height-TITLESV_HEIGHT);
        _contentSV.showsHorizontalScrollIndicator = NO;
        _contentSV.pagingEnabled = YES;
        [self addSubview:_contentSV];
        
        
        UIView *view=firstView;
        view.frame=CGRectMake(0, 0, _contentSV.frame.size.width, _contentSV.frame.size.height);
        [_contentSV addSubview:view];
        [_contentViewArray replaceObjectAtIndex:0 withObject:firstView];
    }
    return self;
}
#pragma mark- ScrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_contentSV) {
        int x = _contentSV.contentOffset.x/_contentSV.frame.size.width;
        UIButton *titleBtn=(UIButton *)[self viewWithTag:(x+kButtonTagStart)];
        
        if (![_contentViewArray[x] isKindOfClass:[UIView class]]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getShowItemViewWithIndex:)]) {
                UIView *view = [self.delegate getShowItemViewWithIndex:x];
                self.currentView = view;
                view.frame=CGRectMake(_contentSV.frame.size.width*x, 0, _contentSV.frame.size.width, _contentSV.frame.size.height);
                [_contentSV addSubview:view];
                [_contentViewArray replaceObjectAtIndex:x withObject:view];
            }
        }else {
            [self scrollAtIndex:x];
        }
        NSLog(@"tag=%ld",(long)titleBtn.tag);
        
        [self updateTitleBtnCenter:titleBtn];
        [UIView animateWithDuration:0.4 animations:^{
            //_lineLbl.frame=CGRectMake(titleBtn.frame.origin.x, _lineLbl.frame.origin.y, _lineLbl.frame.size.width, _lineLbl.frame.size.height);
            //_lineLbl.centerX = titleBtn.centerX;
            _lineLbl.tag=titleBtn.tag+100;
        } completion:^(BOOL finished) {
            _selectedTitleBtn.selected=NO;
            _selectedTitleBtn.titleLabel.font = BUTTON_FONT;
            _selectedTitleBtn=titleBtn;
            _selectedTitleBtn.titleLabel.font = BUTTON_BIG_FONT;
            titleBtn.selected=YES;
            
        }];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _lineLbl.transform =CGAffineTransformMakeTranslation(scrollView.contentOffset.x/_titlesArray.count, 0);
    
//    NSLog(@"%f", _beginOffX);
//    CGFloat offX = scrollView.contentOffset.x - _beginOffX;
//    _lineLbl.centerX += offX / 3;
}

- (void)scrollAtIndex:(int)aIndex {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollAtIndex:)]) {
        [self.delegate scrollAtIndex:aIndex];
    }
}
//标题按钮跟着移动
-(void)updateTitleBtnCenter:(UIButton *)titleBtn {
    return;
    //如果在两头，则不发生位移变化
    CGPoint point = [_titleSV convertPoint:titleBtn.center toView:_titleSV.superview];
    if (CGRectGetWidth(_titleSV.frame) / 2 > titleBtn.center.x) {
        [_titleSV setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if ((_titleSV.contentSize.width - titleBtn.center.x) < CGRectGetWidth(_titleSV.frame) /2){
        [_titleSV setContentOffset:CGPointMake(_titleSV.contentSize.width - CGRectGetWidth(_titleSV.frame), _titleSV.contentOffset.y) animated:YES];
    }else {
        
        float space = point.x - CGRectGetWidth(_titleSV.superview.frame)/2;
        //float space = CGRectGetMinX(titleBtn.frame) - CGRectGetMinX(_selectedTitleBtn.frame);
        [_titleSV setContentOffset:CGPointMake(_titleSV.contentOffset.x+space, _titleSV.contentOffset.y) animated:YES];
    }
}
-(void)scrollToIndex:(int)index {
    [self onClick:_buttonArray[index]];
    //[_contentSV setContentOffset:CGPointMake(_contentSV.frame.size.width*index, _contentSV.contentOffset.y) animated:YES];
}
-(void)onClick:(UIButton *)titleBtn
{
    if (titleBtn.tag==_lineLbl.tag-100) {
        //点击当前显示的
        return;
    }
    [self updateTitleBtnCenter:titleBtn];
//    if (_titleSV.contentOffset.x+_titleSV.frame.size.width<titleBtn.frame.origin.x+titleBtn.frame.size.width) {
//        [_titleSV setContentOffset:CGPointMake(_titleSV.contentOffset.x+titleBtn.frame.size.width, _titleSV.contentOffset.y) animated:YES];
//    }
//    else if (_titleSV.contentOffset.x>titleBtn.frame.origin.x)
//    {
//        [_titleSV setContentOffset:CGPointMake(titleBtn.frame.origin.x, _titleSV.contentOffset.y) animated:YES];
//    }
    
    
    [UIView animateWithDuration:0.4 animations:^{
        //_lineLbl.frame=CGRectMake(titleBtn.frame.origin.x, _lineLbl.frame.origin.y, _lineLbl.frame.size.width, _lineLbl.frame.size.height);
        //_lineLbl.centerX = titleBtn.centerX;
        _lineLbl.tag=titleBtn.tag+100;
    } completion:^(BOOL finished) {
        _selectedTitleBtn.selected=NO;
        _selectedTitleBtn.titleLabel.font = BUTTON_FONT;
        _selectedTitleBtn=titleBtn;
        _selectedTitleBtn.titleLabel.font = BUTTON_BIG_FONT;
        titleBtn.selected=YES;
    }];
    
    if (_contentSV) {
        //判断是否已经初始化过view
        long x = titleBtn.tag-kButtonTagStart;
        if (![_contentViewArray[x] isKindOfClass:[UIView class]]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getShowItemViewWithIndex:)]) {
                UIView *view = [self.delegate getShowItemViewWithIndex:(int)x];
                self.currentView = view;
                view.frame=CGRectMake(_contentSV.frame.size.width*x, 0, _contentSV.frame.size.width, _contentSV.frame.size.height);
                [_contentSV addSubview:view];
                [_contentViewArray replaceObjectAtIndex:x withObject:view];
            }
            
            [_contentSV setContentOffset:CGPointMake(_contentSV.frame.size.width*(titleBtn.tag-kButtonTagStart), _contentSV.contentOffset.y) animated:YES];
        }else {
            [UIView animateWithDuration:0.4 animations:^{
                [_contentSV setContentOffset:CGPointMake(_contentSV.frame.size.width*(titleBtn.tag-kButtonTagStart), _contentSV.contentOffset.y) animated:NO];
                _lineLbl.transform =CGAffineTransformMakeTranslation(_contentSV.contentOffset.x/_titlesArray.count, 0);
            } completion:^(BOOL finished) {
                [self scrollAtIndex:(int)x];
            }];
        }
        
        
    }
//    if (self.slideBtnClickedBlock) {
//        self.slideBtnClickedBlock([_titlesArray objectAtIndex:(int)titleBtn.tag-kButtonTagStart]);
//    }
}

-(void)reloadTitle:(NSDictionary *)titleDict {
    for (NavSliderButton *btn in _buttonArray) {
        NSString *title = [titleDict objectForKey:btn.statusCode];
        if (title && [title intValue] != 0) {
            btn.countLbl.text = [NSString stringWithFormat:@"%@", title];
            btn.countLbl.hidden = NO;
        }else {
            btn.countLbl.hidden = YES;
        }
    }
}
//-(UIButton *)getTitleButton:(NSDictionary *)dict Frame:(CGRect)frame {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor clearColor];
//    button.titleLabel.font = BUTTON_FONT;
//    [button setTitleColor:[UIColor diceColorWithRed:158 green:158 blue:158 alpha:1] forState:UIControlStateNormal];
//    [button setTitleColor:Font_COLOR forState:UIControlStateSelected];
//    NSString *title = dict[TITLE_NAME];
//    [button setTitle:title forState:UIControlStateNormal];
//    
//    //button.tag = kButtonTagStart+i;
//    
//    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:BUTTON_BIG_FONT,NSPaperSizeDocumentAttribute:[NSValue valueWithCGSize:CGSizeMake(MAXFLOAT, 25)]}];
//    //CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 25) lineBreakMode:NSLineBreakByWordWrapping];
//    button.frame = CGRectMake(width, 0, size.width, TITLESV_HEIGHT-LINE_HIGHT);
//    //button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
