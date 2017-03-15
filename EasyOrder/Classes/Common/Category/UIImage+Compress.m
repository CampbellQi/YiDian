//
//  UIImage+Compress.m
//  SRBApp
//
//  Created by fengwanqi on 15/10/15.
//  Copyright © 2015年 BJshurenbang. All rights reserved.
//
#define TARGET_WIDTH 1200.0
#define TARGET_FILESIZE 5.0
#define LIMIT_SIZE 10.0

#import "UIImage+Compress.h"

@implementation UIImage (Compress)

- (BOOL)isLimitExceeded
{
    float size = [UIImagePNGRepresentation(self) length] / (1024.0 * 1024.0);
    if (size > LIMIT_SIZE) {
        DLog(@"file size:%.f",size);
        [WQProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"文件大小请控制在%.fM以内", LIMIT_SIZE]];
        return YES;
    }
    return NO;
}
-(NSData *)compressAndResize {
    UIImage *newImage = [self imageCompressForWidth:self targetWidth:TARGET_WIDTH];
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(newImage, compression);
    while ([imageData length] / (1024 * 1024) > TARGET_FILESIZE && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    return imageData;
}

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
