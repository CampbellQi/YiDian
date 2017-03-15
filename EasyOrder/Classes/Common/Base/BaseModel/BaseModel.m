//
//  BaseModal.m
//  DoctorEasyMedical
//
//  Created by 冯万琦 on 16/5/26.
//  Copyright © 2016年 sss. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

static NSString *idPropertyName = @"id";
static NSString *idPropertyNameOnObject = @"objectId";

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}
/**
 *  解析字典
 */
+ (id)objectFromDictionary:(NSDictionary*)dictionary {
    return [[self class] mj_objectWithKeyValues:dictionary];
}
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(NSArray *)array {
    return [[self class] mj_objectArrayWithKeyValuesArray:array];
}
- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.mj_keyValues];
    if (self.objectId) {
        [dic setObject:self.objectId forKey:idPropertyName];
    }
    return dic;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.objectId forKey:idPropertyNameOnObject];
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(propertyList[i])];
        [encoder encodeObject:[self valueForKey:key] forKey:key];
    }
    //    for (NSString *key in [[self class] ignoredPropertyNames]) {
    //        [encoder encodeObject:[self valueForKey:key] forKey:key];
    //    }
}
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        [self setValue:[decoder decodeObjectForKey:idPropertyNameOnObject] forKey:idPropertyNameOnObject];
        
        unsigned int count;
        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
        for (unsigned int i=0; i<count; i++) {
            NSString *key = [NSString stringWithUTF8String:property_getName(propertyList[i])];
            if ([BaseModel isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
            id value = [decoder decodeObjectForKey:key];
            if (value != [NSNull null] && value != nil) {
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}

+ (BOOL)isPropertyReadOnly:(Class)klass propertyName:(NSString*)propertyName{
    const char * type = property_getAttributes(class_getProperty(klass, [propertyName UTF8String]));
    NSString * typeString = [NSString stringWithUTF8String:type];
    NSArray * attributes = [typeString componentsSeparatedByString:@","];
    NSString * typeAttribute = [attributes objectAtIndex:1];
    
    return [typeAttribute rangeOfString:@"R"].length > 0;
}
- (NSString *)description {
    NSMutableDictionary *dic = [self toDictionary];
    
    return [NSString stringWithFormat:@"#<%@: id = %@ %@>", [self class], self.objectId, [dic description]];
}

- (BOOL)isEqual:(id)object {
    if (object == nil || ![object isKindOfClass:[BaseModel class]]) return NO;
    
    BaseModel *model = (BaseModel *)object;
    
    return [self.objectId isEqualToString:model.objectId];
}
@end



