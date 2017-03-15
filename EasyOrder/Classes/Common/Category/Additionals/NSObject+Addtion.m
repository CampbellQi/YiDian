

//
//  NSObject+Addtion.m
//  StudentStudyNew
//
//  Created by guobo on 15/8/7.
//  Copyright (c) 2015年 奥鹏教育. All rights reserved.
//

#import "NSObject+Addtion.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

@implementation NSObject (Addtion)

- (BaseViewController *)getCurrentVC:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[BaseViewController class]]) {
            break;
        }
    }
    return target;
}

- (NSArray *)getAllProperties
{
    return [self getAllPropertiesByClass:[self class]];
}

- (NSArray *)getAllPropertiesByClass:(Class)class
{
    u_int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    NSMutableArray *propertiesArr = [NSMutableArray arrayWithCapacity:count];
    while (count > 0) {
        count --;
        const char* propertyName = property_getName(properties[count]);
        [propertiesArr addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return propertiesArr;
}

- (NSArray *)getAllMethodsByClass:(Class)class
{
    u_int count;
    
    Method *methods = class_copyMethodList(class, &count);
    
    NSMutableArray *methodsArr = [NSMutableArray arrayWithCapacity:count];
    while (count > 0) {
        count --;
        SEL sel = method_getName(methods[count]);
        [methodsArr addObject:[NSString stringWithUTF8String:sel_getName(sel)]];
    }
    return methodsArr;
}


@end
