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

- (void)startWidget {
    [[WidgetManager instance] registerDeviceMotionListener:self withKey:[self widgetId]];
}

- (void)stopWidget {
    [[WidgetManager instance] deregisterDeviceMotionListenerForKey:[self widgetId]];
}


- (void)handleDeviceMotionUpdate:(CMDeviceMotion *)deviceMotion {
    [_sensorCard update:deviceMotion];
}

- (NSString *)widgetId {
    return @"gyro";
}


@end