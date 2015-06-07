//
// Created by Saurabh Gupta on 6/1/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorWidgetCard.h"

@class MotionSensorWidget;
@class CMDeviceMotion;


@interface MotionSensorCard : SensorWidgetCard
- (instancetype)initWithWidget:(MotionSensorWidget *)widget;

+ (instancetype)cardWithWidget:(MotionSensorWidget *)widget;

- (void)update:(CMDeviceMotion *)deviceMotion;

@end