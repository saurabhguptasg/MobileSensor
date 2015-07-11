//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SensorWidget.h"
#import "DeviceLocationUpdateHandler.h"


@interface LocationSensorWidget : SensorWidget <DeviceLocationUpdateHandler>
@end