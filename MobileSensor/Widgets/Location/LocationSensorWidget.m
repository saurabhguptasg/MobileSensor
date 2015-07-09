//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "LocationSensorWidget.h"
#import "LocationSensorCard.h"
#import "SensorWidgetCard.h"
#import "MSSensorUtils.h"


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
        [_locationManager setDelegate:self];
    }

    return self;
}

- (SensorWidgetCard *)getSensorWidgetCard {
    return _sensorCard;
}

- (void)startWidget {
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];

    }
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        [_locationManager startUpdatingLocation];
        [_locationManager startMonitoringSignificantLocationChanges];
    }
}

- (void)stopWidget {
    [_locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    [_sensorCard update:locations];
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading {

}

- (NSString *)widgetId {
    return @"location";
}


@end