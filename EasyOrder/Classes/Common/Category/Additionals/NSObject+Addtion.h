//
//  NSObject+Addtion.h
//  StudentStudyNew
//
//  Created by guobo on 15/8/7.
//  Copyright (c) 2015年 奥鹏教育. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (Addtion)




- (BaseViewController *)getCurrentVC:(UIView *)sourceView;

- (NSArray *)getAllProperties;
- (NSArray *)getAllPropertiesByClass:(Class)class;
- (NSArray *)getAllMethodsByClass:(Class)class;
@end
