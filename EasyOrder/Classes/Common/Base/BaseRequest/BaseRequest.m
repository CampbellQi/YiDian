
//  LSBaseRequest.m
//
//
//  Created by Bob on 14-5-23.
//  Copyright (c) 2014年 Bob. All rights reserved.
//
/**
 *  网络请求失败的显示信息
 */
#define wqNetError @"网络连接失败，请稍后重试"
/**
 *  服务器返回状态码名称
 */
#define resultCodeName @"retCode"
#define successCode 200


#import <objc/objc.h>
#import <objc/runtime.h>
#import "BaseRequest.h"
//#import "AFHTTPRequestOperation.h"
#import "AFAppDotNetAPIClient.h"
//#import "FileUtils.h"

#define LSBASEREQUEST_METHODNAME_KEY @"LSBASEREQUEST_METHODNAME_KEY"

@interface BaseRequest ()
{
    NSURLSessionDataTask *_currentTask;
    /**
     *  上传文件
     */
    NSMutableDictionary *_uploadDataDictionary;
}

@end

@implementation BaseRequest
-(void)dealloc
{
    _requestSuccBlock = nil;
    _requestFailBlock = nil;
    _requestProgressBlock = nil;
    _requestFinalBlock = nil;
}
-(id)init
{
    self = [super init];
    if (self){
        _parametersDic = [[NSMutableDictionary alloc] init];
        _uploadDataDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%zd", value] forKey:key];
}
- (void)setDoubleValue:(double)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%f", value] forKey:key];
}
- (void)setLongLongValue:(long long)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%lld", value] forKey:key];
}
- (void)setBOOLValue:(BOOL)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%d", value] forKey:key];
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    if(!value){
        value = @"";
    }
    [_parametersDic setValue:value forKey:key];
}
- (void)setDataObject:(NSData *)object withKey:(NSString *)key {
    [_uploadDataDictionary setValue:object forKey:key];
}
-(instancetype)initWithUrl:(NSString*)requestUrl params:(NSDictionary*)params
{
    self = [super init];
    if (self) {
        _requestUrl = requestUrl;
        _requestMethod = LSREQUESTMETHODPOST;
        _parametersDic = [NSMutableDictionary dictionaryWithDictionary:params];
        _uploadDataDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
        _isCache = NO;
    }
    return self;
}

/**
 *  网络请求
 */
-(void)sendRequest
{
    self.result = nil;
    if ([self respondsToSelector:@selector(getRequestMethod)]) {
        _requestMethod = [self getRequestMethod];
    }
    if([self respondsToSelector:@selector(isCache)]){
        _isCache = [self isCache];
    }
    if (_isCache) {
        [self readCacheDisk];
    }
    if (_requestMethod == LSREQUESTMETHODGET) {
        [self doGetRequest];
    }else if(_requestMethod == LSREQUESTMETHODPOST){
        [self doPostRequest];
    }
}
-(void)sendUploadFileRequest
{
    self.result = nil;
    if ([self respondsToSelector:@selector(getRequestMethod)]) {
        _requestMethod = [self getRequestMethod];
    }
    if([self respondsToSelector:@selector(isCache)]){
        _isCache = [self isCache];
    }
    if (_isCache) {
        [self readCacheDisk];
    }
    if (_requestMethod == LSREQUESTMETHODGET) {
        [self doPostFileRequest];
    }else if(_requestMethod == LSREQUESTMETHODPOST){
        [self doPostFileRequest];
    }
}
/**
 *  @brief 发起Get请求
 */
-(void)doGetRequest
{
    NSString* url = [self getRequestUrl];
    [AFAppDotNetAPIClient sharedClient].urlDict[NSStringFromClass([self class])] = url;
    _currentTask = [[AFAppDotNetAPIClient sharedClient]GET:url parameters:_parametersDic progress:^(NSProgress * _Nonnull downloadProgress) {
        if (_requestProgressBlock) {
            _requestProgressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self handleResponse:responseObject isReadCache:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_requestFailBlock)
        {
            _requestFailBlock(wqNetError);
        }
        if (_requestFinalBlock) {
            _requestFinalBlock(self);
        }
    }];
}
/**
 *  @brief 发起Post请求
 */
-(void)doPostRequest
{
    NSString* url = [self getRequestUrl];
    [AFAppDotNetAPIClient sharedClient].urlDict[NSStringFromClass([self class])] = url;
    _currentTask = [[AFAppDotNetAPIClient sharedClient] POST:[self getRequestUrl] parameters:_parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        if (_requestProgressBlock) {
            _requestProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject isReadCache:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_requestFailBlock)
        {
            DLog(@"url:%@ \n, params:%@\n", _requestUrl, _parametersDic);
            DLog(@"error = %@", error);
            _requestFailBlock(wqNetError);
        }
        if (_requestFinalBlock) {
            _requestFinalBlock(self);
        }
    }];
}

/**
 *  发起post上传文件请求
 */

- (void)doPostFileRequest {
    NSString *url = [self getRequestUrl];
    [[AFAppDotNetAPIClient sharedClient] POST:url parameters:_parametersDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (_uploadDataDictionary) {
            /**
             在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
             要解决此问题，
             可以在上传时使用当前的系统事件作为文件名
             */
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            for (NSInteger i=0; i<_uploadDataDictionary.allKeys.count; i++) {
                NSString *fileName = [NSString stringWithFormat:@"%@_%ld.png", str, i];
                [formData appendPartWithFileData:_uploadDataDictionary.allValues[i] name:_uploadDataDictionary.allKeys[i] fileName:fileName mimeType:@"image/png"];
            }
            
        }else {
            DLog(@"请检查上传文件或文件名是否为空");
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (_requestProgressBlock) {
            _requestProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject isReadCache:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_requestFailBlock)
        {
            _requestFailBlock(wqNetError);
        }
        if (_requestFinalBlock) {
            _requestFinalBlock(self);
        }
    }];
}
/**
 *  @brief 处理返回的结果
 */
-(void)handleResponse:(id)responseObject isReadCache:(BOOL)isReadCache
{
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        if (!isReadCache) {
            [self writeCacheDisk:responseObject];
        }
        _result = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        if ([_result[resultCodeName]intValue]==successCode) {
            if (_requestSuccBlock)
            {
                _requestSuccBlock(self);
            }
        }else {
            if (_requestFailBlock) {
                _requestFailBlock(_result[@"data"][@"errMsg"]);
            }
        }
        if (isReadCache) {
            _result[kCacheKey] = @(YES);
        }else{
            _result[kCacheKey] = @(NO);
        }
        
        if(_requestFinalBlock){
            _requestFinalBlock(self);
        }
    }
}
/**
 *  @brief 读取文件缓存
 */
-(void)readCacheDisk
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableString *urlString;
        urlString = [self getUrlMulString];
        NSString *floderPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Caches/LSCacheFinder"];
        
        NSString* filePath = [floderPath stringByAppendingPathComponent:[urlString md5]];
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        if (!dict) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleResponse:dict isReadCache:YES];
        });
    });
}
/**
 *  @brief 获取缓存文件名
 */
- (NSMutableString *)getUrlMulString
{
    NSMutableString* urlString = [NSMutableString stringWithString:[self getRequestUrl]];
    for (NSString* key in _parametersDic.allKeys) {
        if (key && _parametersDic[key]) {
            [urlString appendString:key];
            [urlString appendString:@"_"];
            [urlString appendString:[NSString stringWithFormat:@"%@",_parametersDic[key]]];
        }
    }
    return urlString;
}

/**
 *  @brief 写文件
 */
-(void)writeCacheDisk:(NSMutableDictionary*)resultDict
{
    if(!resultDict[resultCodeName] || [resultDict[resultCodeName]intValue]!=successCode){
        NSLog(@"错误信息：信息异常，无法写入缓存");
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableString *urlString;
        urlString = [self getUrlMulString];
        NSString *floderPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Caches/LSCacheFinder"];
        BOOL isForder = NO;
        if (![[NSFileManager defaultManager]fileExistsAtPath:floderPath isDirectory:&isForder]) {
            if (!isForder) {
                [[NSFileManager defaultManager]createDirectoryAtPath:floderPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }
        NSString* filePath = [floderPath stringByAppendingPathComponent:[[NSString stringWithString:urlString] md5]];
        [resultDict writeToFile:filePath atomically:YES];
        //        DLog(@"缓存状态：%zd",isSucc);
    });
}

-(void)processResult:(NSMutableDictionary *)resultDict
{
    
}
+(void)cancelRequest
{
    NSArray* taskArray = [AFAppDotNetAPIClient sharedClient].tasks;
    NSString* key = NSStringFromClass([self class]);
    NSString* currentUrl = [AFAppDotNetAPIClient sharedClient].urlDict[key] ? [AFAppDotNetAPIClient sharedClient].urlDict[key] : @"";
    for (NSURLSessionDataTask *task in taskArray) {
        //NSLog(@"%zd",task.taskIdentifier);
        if ([[task.currentRequest.URL absoluteString] rangeOfString:currentUrl].location!=NSNotFound) {
            [task cancel];
            break;
        }
    }
}
-(LSREQUESTMETHOD)getRequestMethod
{
    return LSREQUESTMETHODPOST;
}
-(NSString *)getRequestUrl
{
    return _requestUrl;
}

- (void)cancel
{
    NSLog(@"%@ cancel %p",NSStringFromClass([self class]),&self);
    if (_currentTask)
    {
        [_currentTask cancel];
    }
    _requestProgressBlock = nil;
    _requestFinalBlock = nil;
    _requestFailBlock = nil;
    _requestSuccBlock = nil;
}
@end
