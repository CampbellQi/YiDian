//
//  NSString+LSAdditional.m
//
//
//  Created by Bob on 14-5-5.
//  Copyright (c) 2014年 Bob. All rights reserved.
//

#import "NSString+Additional.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+Base64.h"

@implementation NSString (Additional)

+ (NSString*) unescapeUnicodeString:(NSString*)string
{
    Byte val[] = {
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,
        
        0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F,0x3F};
    NSMutableString *out = [NSMutableString string];
    if(string && ![string isEqualToString:@""]){
        int i = 0;
        NSInteger len = [string length];
        while (i < len) {
            unichar ch = [string characterAtIndex:i];
            if (ch == '+') {
                [out appendString:@"' '"];
            } else if ('A' <= ch && ch <= 'Z') {
                [out appendString:[NSString stringWithFormat:@"%C",ch]];
            } else if ('a' <= ch && ch <= 'z') {
                [out appendString:[NSString stringWithFormat:@"%C",ch]];
            } else if ('0' <= ch && ch <= '9') {
                [out appendString:[NSString stringWithFormat:@"%C",ch]];
            } else if (ch == '-' || ch == '_'
                       || ch == '.' || ch == '!'
                       || ch == '~' || ch == '*'
                       || ch == '\'' || ch == '('
                       || ch == ')') {
                [out appendString:[NSString stringWithFormat:@"%C",ch]];
            } else if (ch == '%') {
                unichar cint = 0;
                if ('u' != [string characterAtIndex:i+1]) {
                    cint = (cint << 4) | val[[string characterAtIndex:i+1]];
                    cint = (cint << 4) | val[[string characterAtIndex:i+2]];
                    i+=2;
                } else {
                    cint = (cint << 4) | val[[string characterAtIndex:i+2]];
                    cint = (cint << 4) | val[[string characterAtIndex:i+3]];
                    cint = (cint << 4) | val[[string characterAtIndex:i+4]];
                    cint = (cint << 4) | val[[string characterAtIndex:i+5]];
                    i+=5;
                }
                [out appendString:[NSString stringWithFormat:@"%C",cint]];
            }
            i++;
        }
    }
    return [NSString stringWithString:out];
}

//去掉字符串开头的0 ，并返回整形
+(NSInteger)convertToInterger:(NSString*)string
{
    if (!string || string.length == 0) {
        return 0;
    }
    for (int i=0; i<string.length; i++) {
        short c = [string characterAtIndex:i];
        if (c != 0) {
            return [[string substringFromIndex:i]intValue];
        }
    }
    return 0;
}

+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (BOOL)isWhitespace {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isEmptyOrWhitespace {
    return !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

- (BOOL)containsString:(NSString*)string {
    return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString*)string options:(NSStringCompareOptions)options {
    return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

/*
 * We did not write the method below
 * It's all over Google and we're unable to find the original author
 * Please contact info@enormego.com with the original author and we'll
 * Update this comment to reflect credit
 */
- (NSString*)md5 {
    const char* string = [self UTF8String];
    unsigned char result[16];
    CC_MD5(string, (uint)strlen(string), result);
    NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
    return [hash lowercaseString];
}


- (NSString *)encodingURL {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}
- (NSString *)decodeingURL:(NSString *)str {
    // Obj-C's url decoder does everything except + to space conversion.
    NSString *result = [str stringByReplacingOccurrencesOfString:@"+"
                                                      withString:@" "];
    return [result stringByReplacingPercentEscapesUsingEncoding:
            NSUTF8StringEncoding];
}


- (NSString*)encodeAsURIComponent {
    const char* p = [self UTF8String];
    NSMutableString* result = [NSMutableString string];
    
    for (;*p ;p++) {
        unsigned char c = *p;
        if (('0' <= c && c <= '9') || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || c == '-' || c == '_') {
            [result appendFormat:@"%c", c];
        } else {
            [result appendFormat:@"%%%02X", c];
        }
    }
    return result;
}

/**
 * URL encodes a string
 */
- (CGFloat)widthWithFont:(UIFont *)font {
    CGSize size = [self sizeWithFont:font];
    return size.width;
}


+ (NSString*) encryptPassworToString:(NSString*)password {
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];
    char *dataPtr = (char *) [data bytes];
    
    NSString *randNum = [[NSString stringWithFormat:@"%d", [NSString getRandomNumber:0 to:32000]] md5];
    NSData *randStr = [randNum dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *resultData = [NSMutableData data];
    
    char *keyData = (char *) [randStr bytes];
    char *keyPtr = keyData;
    int keyIndex = 0;
    
    for (int x = 0; x < [data length]; x++)
    {
        if (keyIndex == [randNum length])
            keyIndex = 0;
        
        *(dataPtr+x) = *(dataPtr+x) ^ *(keyPtr+keyIndex);
        [resultData appendBytes:keyPtr+keyIndex length:1];
        [resultData appendBytes:dataPtr+x length:1];
        keyIndex++;
    }
    
    NSString *encryptStr = [[NSString keyEncrypt:resultData] base64EncodedString];
    return encryptStr;
}

+ (NSString *)decrytPasswordFromString:(NSString *)str{
    NSData *data = [NSData dataFromBase64String:str];
    NSData *decrytData = [NSString keyEncrypt:data];
    NSMutableData *resultData = [NSMutableData data];
    NSUInteger size = [decrytData length] / sizeof(unsigned char);
    char *encryptPtr = (char *) [decrytData bytes];
    char *keyPtr = encryptPtr;
    for (int x = 0; x < size; x++)
    {
        char value1 = *(encryptPtr+x);
        x++;
        char valu2 = *(keyPtr+x);
        *encryptPtr = valu2 ^ value1;
        [resultData appendBytes:encryptPtr length:1];
    }
    NSString *decrytStr = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    return decrytStr;
    
}



+ (NSData*)keyEncrypt:(NSData*)tmpStr {
    
    NSString *encrypt_key = [@"jukl;'eRT231*(145753YUJK.#%RC^&*(" md5];
    NSData *encryptData = [encrypt_key dataUsingEncoding:NSUTF8StringEncoding];
    
    char *encryptPtr = (char *) [encryptData bytes];
    char *dataPtr = (char *) [tmpStr bytes];
    int keyIndex = 0;
    char *keyPtr = encryptPtr;
    for (int x = 0; x < [tmpStr length]; x++)
    {
        if (keyIndex == [encryptData length])
            keyIndex = 0;
        
        *(dataPtr+x) = *(dataPtr+x) ^ *(keyPtr+keyIndex);
        keyIndex++;
    }
    return tmpStr;
}

- (NSString *)hideTelephoneNumber {
    if (self.length == 11) {
        NSMutableString *mutableSting = [NSMutableString stringWithString:self];
        [mutableSting replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return mutableSting;
    } else {
        return self;
    }
}

- (NSString *)hideUserName {
    NSMutableString *mutableSting = [NSMutableString stringWithString:self];
    [mutableSting replaceCharactersInRange:NSMakeRange(1, self.length-2) withString:@"****"];
    return mutableSting;
}

//
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary {
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

- (CGSize)getSizeWithFont:(UIFont *)font
{
    CGSize size;
    if (font == nil) {
        return size;
    }
    
    if (iOSVersion >= 7.0 && iOSVersion <= 8.0) {
        size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    } else {
        size = [self sizeWithFont:font];
    }
    
    return size;
}

// 移除字符串中间的空格
- (NSString *)removeWhiteSpace
{
    // Scanner
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [NSCharacterSet whitespaceCharacterSet];
    // Scan
    while (![scanner isAtEnd]) {
        
        // Get non new line or whitespace characters
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        
        // Replace with a space
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@" "];
        }
    }
    
    // Return
    return result;
}

-(NSString *)filterHTML
{
    NSScanner * scanner = [NSScanner scannerWithString:self];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        if ([self rangeOfString:@"</font>"].location != NSNotFound && [text rangeOfString:@"br"].location==NSNotFound) {
             return [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        }
    }
    return self;
}
- (NSString *)obfuscateWithKey:(NSString *)key
{
    if (!key) {
        key = @"duanjiajia";
    }
    // Create data object from the string
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get pointer to data to obfuscate
    char *dataPtr = (char *) [data bytes];
    
    // Get pointer to key data
    char *keyData = (char *) [[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    
    // Points to each char in sequence in the key
    char *keyPtr = keyData;
    int keyIndex = 0;
    
    //    for (int x = 0; x<string.length; x++) {
    //
    //    }
    
    // For each character in data, xor with current value in key
    for (int x = 0; x < [self length]; x++)
    {
        // Replace current character in data with
        // current character xor'd with current key value.
        // Bump each pointer to the next character
        *dataPtr = *dataPtr ^ *keyPtr;
        *dataPtr ++;
        *keyPtr ++;
        // If at end of key data, reset count and
        // set key pointer back to start of key value
        if (++keyIndex == [key length])
            keyIndex = 0, keyPtr = keyData;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
