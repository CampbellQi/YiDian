//
//  LSGlobal.m
//  _6.0
//
//  Created by 刘 智平 on 13-10-22.
//  Copyright (c) 2013年 刘 智平. All rights reserved.
//
#define kGlobeVariablesArchiveFileName @"Global.dat"

#import "Global.h"
#import <objc/runtime.h>
static Global *_instance = nil;


@interface Global ()

@end
@implementation Global

#pragma mark singleton

+ (Global *)sharedGlobal {
    if(_instance == nil)
	{
		_instance = [Global readGlobeVariablesFromFile];
		if(_instance == nil){
            _instance = [[Global alloc] init];
        }
	}
    return _instance;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_lastUpdateDateStr forKey:@"lastUpdateDateStr"];
    [aCoder encodeObject:_currentUser forKey:@"user"];
    [aCoder encodeBool:_qqLogined forKey:@"qqLogined"];
    [aCoder encodeBool:_isCheckedUpdate forKey:@"isCheckedUpdate"];
    [aCoder encodeInteger:_msgRedNotification forKey:@"msgRedNotification"];
    [aCoder encodeObject:_registerId forKey:@"registerId"];
    [aCoder encodeBool:_isRemindedUploadHeader forKey:@"isRemindUploadHeader"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _lastUpdateDateStr = [aDecoder decodeObjectForKey:@"lastUpdateDateStr"];
        _currentUser = [aDecoder decodeObjectForKey:@"user"];
        _qqLogined = [aDecoder decodeBoolForKey:@"qqLogined"];
        _isCheckedUpdate = [aDecoder decodeBoolForKey:@"isCheckedUpdate"];
        _msgRedNotification = [aDecoder decodeIntegerForKey:@"msgRedNotification"];
        _registerId = [aDecoder decodeObjectForKey:@"registerId"];
        _isRemindedUploadHeader = [aDecoder decodeBoolForKey:@"isRemindUploadHeader"];
    }
    return self;
}
- (id)init {
	if(self = [super init]) {
	}
	return self;
}

+ (void)save
{
    NSString* filePath = [[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:kGlobeVariablesArchiveFileName];
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:_instance];
	if(archivedData){
		[archivedData writeToFile:filePath atomically:YES];
	}
}

+(Global *) readGlobeVariablesFromFile
{
	Global * object = nil;
    NSString* filePath = [[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:kGlobeVariablesArchiveFileName];

    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        return object;
    }
    NSData *archivedData = [[NSData alloc] initWithContentsOfFile:filePath];
    if(archivedData) {
		object = (Global *)[NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
	}
    return object;
}

+ (void)clear {
    NSString* filePath = [[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:kGlobeVariablesArchiveFileName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        _instance = nil;
//        //属性置空
//        unsigned int count;
//        objc_property_t *propertis = class_copyPropertyList([self class], &count);
//        for (NSInteger i=0; i<count; i++) {
//            const char *name = property_getName(propertis[i]);
//            [[Global sharedGlobal] setValue:nil forKey:[NSString stringWithUTF8String:name]];
//        }
    }
}
+(BOOL)isLogin
{
    if ([Global sharedGlobal].currentUser.userID) {
        return YES;
    }
    return NO;
}
+(NSString*)getUserId
{
    NSString* userId = [NSString stringWithFormat:@"%ld", (long)[Global sharedGlobal].currentUser.userID];
    if (!userId) {
        userId = @"";
    }
    return userId;
}
@end
