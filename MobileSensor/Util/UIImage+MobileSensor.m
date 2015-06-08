//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "UIImage+MobileSensor.h"


@implementation UIImage (MobileSensor)

+(UIImage *)getImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0 );
    UIBezierPath *path = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, 0.0f, size.width, size.height)];
    [fillColor setFill];
    [path fill];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end