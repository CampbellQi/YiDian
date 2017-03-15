//
//  UITableView+UINib.m
//  TestUINib
//
//  Created by vernepung on 16/5/3.
//  Copyright © 2016年 vernepung. All rights reserved.
//

#import "UITableView+UINib.h"
#import <objc/runtime.h>
static const void *registerNibArrayKey = &registerNibArrayKey;
@implementation UITableView (UINib)
- (void)dealloc
{
    [self.registerNibArray removeAllObjects];
    objc_setAssociatedObject(self, registerNibArrayKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)initialize
{
    
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class tableViewClass = [UITableView class];
        SEL originalSEL = @selector(registerNib:forCellReuseIdentifier:);
        SEL swizzingSEL = @selector(vp_registerNib:forCellReuseIdentifier:);
        
        Method originalMethod = class_getInstanceMethod(tableViewClass, originalSEL);
        Method swizzingMethod = class_getInstanceMethod(tableViewClass, swizzingSEL);
        
        BOOL addSwizzingMethoded = class_addMethod(tableViewClass, originalSEL, method_getImplementation(swizzingMethod), method_getTypeEncoding(swizzingMethod));
        if (addSwizzingMethoded)
        {
            class_replaceMethod(tableViewClass, swizzingSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else
        {
            method_exchangeImplementations(originalMethod, swizzingMethod);
        }
    });
}


- (NSMutableArray *)registerNibArray
{
    NSMutableArray *array = objc_getAssociatedObject(self, registerNibArrayKey);
    if (!array)
    {
        array = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, registerNibArrayKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}

- (void)vp_registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier
{
    if (![self.registerNibArray containsObject:identifier])
    {
        [self.registerNibArray addObject:identifier];
    }
    [self vp_registerNib:nib forCellReuseIdentifier:identifier];
}

- (BOOL)registeredIdentifier:(NSString *)identifier
{
    return [self.registerNibArray containsObject:identifier];
}

@end
