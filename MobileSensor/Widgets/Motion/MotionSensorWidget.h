//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorWidget.h"
#import "DeviceMotionUpdateHandler.h"


@interface MotionSensorWidget : SensorWidget <DeviceMotionUpdateHandler>
@end