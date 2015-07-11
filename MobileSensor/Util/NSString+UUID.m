//
// Created by Saurabh Gupta on 11/23/13.
// Copyright (c) 2013 Saurabh Gupta. All rights reserved.
//


#import "NSString+UUID.h"


@implementation NSString (UUID)
+ (NSString *)uuid
{
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(nil);
    if (uuid) {
        uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuid);
        CFRelease(uuid);
    }
    return uuidString;
}

@end