//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>
#import "MSSensorUtils.h"


@implementation MSSensorUtils {

@private
    CMMotionManager *_motionManager;
    CLLocationManager *_locationManager;
    NSOperationQueue *_eventsQueue;
    CGSize _screenSize;
}

@synthesize motionManager = _motionManager;
@synthesize locationManager = _locationManager;
@synthesize eventsQueue = _eventsQueue;
@synthesize screenSize = _screenSize;

- (instancetype)init {
    self = [super init];
    if (self) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 0.1;
        _locationManager = [[CLLocationManager alloc] init];
        _eventsQueue = [[NSOperationQueue alloc] init];
        _screenSize = [[UIScreen mainScreen] bounds].size;
    }

    return self;
}


+ (MSSensorUtils *)instance {
    static MSSensorUtils *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

@end