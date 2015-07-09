//
// Created by Saurabh Gupta on 6/26/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@protocol DeviceLocationUpdateHandler <NSObject>
- (void) handleDeviceLocationUpdate:(CLLocation *) location;
@end