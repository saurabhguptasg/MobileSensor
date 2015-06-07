//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "AccelSensorWidget.h"
#import "AccelSensorCard.h"
#import "WidgetManager.h"


@implementation AccelSensorWidget {
@private
    AccelSensorCard *_sensorCard;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _displayName = @"Accelerometer";
        _sensorCard = [AccelSensorCard cardWithWidget:self];
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
    return @"accel";
}


@end