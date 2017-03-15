

//
//  NSArray+Additional.m
//  StudentStudy
//
//  Created by vernepung on 15/6/13.
//  Copyright (c) 2015年 vernepung. All rights reserved.
//

#import "NSArray+Additional.h"
#import <objc/runtime.h>

@implementation NSArray (Additional)
- (id)hook_vp_getObjectAtIndex:(NSInteger)index
{
    if ([self count] > index)
    {
        @try {
            return [self hook_vp_getObjectAtIndex:index];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            @throw exception;
#endif
        }
        @finally {
            
        }
    }
    else // 开发环境下，自动抛出异常
    {
#ifdef DEBUG
        //        NSAssert(!self, @"数组越界--数组下标:%zd,%s",index,__FUNCTION__);
        NSAssert(!self, @"Exception:数组越界\n\n越界下标:%zd,\n\n数组:%p",index,&self);
#endif
    }
    return nil;
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (iOSVersion < 8.f) return;
        //        NSClassFromString(@"__NSArray")
        //        __NSArrayM
        Class arrayClass =  NSClassFromString(@"__NSArrayI");
        // runtime 动态添加方法
        //        BOOL isAdded = class_addMethod(arrayClass, @selector(vp_getObjectAtIndex:), (IMP)hook_vp_getObjectAtIndex, "I@:");
        
        SEL originalSelector = @selector(objectAtIndex:);
        SEL swizzingSelector = @selector(hook_vp_getObjectAtIndex:);
        
        Method originalMethod = class_getInstanceMethod(arrayClass, originalSelector);
        Method swizzingMethod = class_getInstanceMethod(arrayClass, swizzingSelector);
        
        BOOL addedMethod = class_addMethod(arrayClass, originalSelector, method_getImplementation(swizzingMethod), method_getTypeEncoding(swizzingMethod));
        
        if (addedMethod)
        {
            class_replaceMethod(arrayClass, swizzingSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else
        {
            method_exchangeImplementations(originalMethod, swizzingMethod);
        }
    });
}
@end
