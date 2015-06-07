//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMDeviceMotion;

@protocol DeviceMotionUpdateHandler <NSObject>
- (void) handleDeviceMotionUpdate:(CMDeviceMotion *) deviceMotion;
@end