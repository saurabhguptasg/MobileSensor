//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

@interface MSSensorUtils : NSObject
+ (MSSensorUtils *)instance;

@property (nonatomic, readonly) CMMotionManager *motionManager;
@property (nonatomic, readonly) CLLocationManager *locationManager;
@property (nonatomic, readonly) NSOperationQueue *eventsQueue;
@property (nonatomic, readonly) CGSize screenSize;
@end