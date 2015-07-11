//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SensorWidgetCard.h"
#import "DeviceLocationUpdateHandler.h"

@class LocationSensorWidget;


@interface LocationSensorCard : SensorWidgetCard <MKMapViewDelegate,DeviceLocationUpdateHandler>
- (instancetype)initWithWidget:(LocationSensorWidget *)widget;

- (void)update:(NSArray *)locations;

+ (instancetype)cardWithWidget:(LocationSensorWidget *)widget;

@end