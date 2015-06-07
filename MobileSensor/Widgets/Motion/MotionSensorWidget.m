//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "MotionSensorWidget.h"
#import "MotionSensorCard.h"
#import "MSSensorUtils.h"
#import "WidgetManager.h"


@implementation MotionSensorWidget {
@private
    MotionSensorCard *_sensorCard;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _displayName = @"Motion";
        _sensorCard = [MotionSensorCard cardWithWidget:self];
    }

    return self;
}

- (SensorWidgetCard *)getSensorWidgetCard {
    return _sensorCard;
}

- (void)setIsActive:(BOOL)isActive {
    [super setIsActive:isActive];
//    CMMotionManager *motionManager = [[MSSensorUtils instance] motionManager];
    if(isActive) {
        [[WidgetManager instance] registerDeviceListener:self withKey:@"motion"];
//        __weak MotionSensorCard *weakSensorCard = _sensorCard;
//        [motionManager setDeviceMotionUpdateInterval:.1];
//        [motionManager startDeviceMotionUpdatesToQueue:[[MSSensorUtils instance] eventsQueue]
//                                           withHandler:^(CMDeviceMotion *motion, NSError *error) {
//                                               [weakSensorCard update:motion];
//                                           }];
    }
    else {
        [[WidgetManager instance] deregisterDeviceListenerForKey:@"motion"];
//        [motionManager stopDeviceMotionUpdates];
    }
}

- (void)handleDeviceMotionUpdate:(CMDeviceMotion *)deviceMotion {
    [_sensorCard update:deviceMotion];
}


@end