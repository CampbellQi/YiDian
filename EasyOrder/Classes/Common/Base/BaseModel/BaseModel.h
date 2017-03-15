//
//  BaseModal.h
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/26.
//  Copyright © 2016年 sss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *objectId;
/**
 *  用来替换id
 */
@property (nonatomic, assign) NSInteger ID;
/**
 *  解析字典
 */
+ (id)objectFromDictionary:(NSDictionary*)dictionary;
/**
 *  解析数组
 */
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(NSArray *)array;
@end
