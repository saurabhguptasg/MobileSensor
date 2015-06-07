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

- (void)startWidget {
    [[WidgetManager instance] registerDeviceListener:self withKey:[self widgetId]];
}

- (void)stopWidget {
    [[WidgetManager instance] deregisterDeviceListenerForKey:[self widgetId]];
}

- (void)handleDeviceMotionUpdate:(CMDeviceMotion *)deviceMotion {
    [_sensorCard update:deviceMotion];
}

- (NSString *)widgetId {
    return @"motion";
}


@end