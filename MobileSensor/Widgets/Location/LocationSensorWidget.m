//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "LocationSensorWidget.h"
#import "LocationSensorCard.h"
#import "SensorWidgetCard.h"
#import "MSSensorUtils.h"
#import "WidgetManager.h"


@implementation LocationSensorWidget {
@private
    LocationSensorCard *_sensorCard;
    CLLocationManager *_locationManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _displayName = @"Location";
        _sensorCard = [LocationSensorCard cardWithWidget:self];
        _locationManager = [[MSSensorUtils instance] locationManager];
    }

    return self;
}

- (SensorWidgetCard *)getSensorWidgetCard {
    return _sensorCard;
}

- (void)startWidget {
    [[WidgetManager instance] registerDeviceLocationListener:self
                                                     withKey:[self widgetId]];
}

- (void)stopWidget {
    [[WidgetManager instance] deregisterDeviceLocationListenerForKey:[self widgetId]];
}

- (void)handleDeviceLocationUpdate:(CLLocation *)location {
    [_sensorCard handleDeviceLocationUpdate:location];
}

- (NSString *)widgetId {
    return @"location";
}


@end