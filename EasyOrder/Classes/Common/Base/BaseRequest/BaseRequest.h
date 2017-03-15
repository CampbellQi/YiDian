//
//  LSBaseRequest.h
//  
//
//  Created by Fengwanqi on 14-5-23.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  网络请求方式枚举(GET、POST)
 */
typedef enum{
    LSREQUESTMETHODPOST=0,
    LSREQUESTMETHODGET=1
}LSREQUESTMETHOD;

#define kCacheKey @"kCacheKey"

@class BaseRequest;



@interface BaseRequest : NSObject

typedef void (^RequestSuccBlock) (BaseRequest* _Nonnull baseRequest);
typedef void(^RequestFailBlock)(NSString*_Nonnull error);
typedef void(^RequestFinalBlock)(BaseRequest* _Nonnull baseRequest);
typedef void(^RequestProgressBlock)(NSProgress * _Nonnull downloadProgress);

@property(nonatomic)         LSREQUESTMETHOD              requestMethod;    //请求方式
//@property(nonatomic, copy) NSString                     *methodName;      //方法名
@property(nonatomic, assign) BOOL                         isCache;       //是否缓存
@property(nonatomic)         BOOL                         isGzip;           //是否压缩
@property (strong,nonatomic, nullable) id                           result;
@property (strong,nonatomic, nullable)NSMutableDictionary* parametersDic;   //参数字典     json
@property (strong,nonatomic, nullable) NSString* requestUrl;
/** 
 @brief 网络错误码，通过此错误码可以判断出是否是取消请求造成网络失败，从而不需要显示无数据，7.11加
 @note kCFURLErrorCancelled为取消请求
 */
@property (nonatomic, assign) NSInteger network_error_code;
/**
 *  回调block
 */
@property (nonatomic, copy)RequestSuccBlock requestSuccBlock;
@property (nonatomic, copy)RequestFailBlock requestFailBlock;
@property (nonatomic, copy)RequestFinalBlock requestFinalBlock;
@property (nonatomic, copy)RequestProgressBlock requestProgressBlock;

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key;
- (void)setDoubleValue:(double)value forKey:(NSString *)key;
- (void)setLongLongValue:(long long)value forKey:(NSString *)key;
- (void)setBOOLValue:(BOOL)value forKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;
- (void)setDataObject:(NSData *)object withKey:(NSString *)key;

-(instancetype)initWithUrl:(NSString*)requestUrl params:(NSDictionary*)params;
-(void)sendRequest;
-(void)sendUploadFileRequest;

- (void)cancel;
/*
 * @brief 服务器返回的数据解析成功后会调用
 */
-(void)processResult:(NSMutableDictionary *)resultDict;
/*
 *@brief 请使用此方法取消网络请求
 */
+(void)cancelRequest;

//请求的URL
//-(NSString*)getRequestUrl;
//请求的方式post or get
//-(LSREQUESTMETHOD)getRequestMethod;
//是否需要缓存
//-(BOOL)isCache;
//获取测试数据
//-(NSDictionary*)getTestData;
@end
