//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "GyroSensorWidget.h"
#import "GyroSensorCard.h"
#import "MSSensorUtils.h"
#import "WidgetManager.h"


@implementation GyroSensorWidget {
@private
    GyroSensorCard *_sensorCard;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _displayName = @"Gyroscope";
        _sensorCard = [GyroSensorCard cardWithWidget:self];
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
        [[WidgetManager instance] registerDeviceListener:self withKey:@"gyro"];

//        __weak GyroSensorCard *weakSensorCard = _sensorCard;
//        [motionManager startDeviceMotionUpdatesToQueue:[[MSSensorUtils instance] eventsQueue]
//                                           withHandler:^(CMDeviceMotion *motion, NSError *error) {
//                                               [weakSensorCard update:motion];
//                                           }];
    }
    else {
        [[WidgetManager instance] deregisterDeviceListenerForKey:@"gyro"];
//        [motionManager stopDeviceMotionUpdates];
    }
}

- (void)handleDeviceMotionUpdate:(CMDeviceMotion *)deviceMotion {
    [_sensorCard update:deviceMotion];
}

@end