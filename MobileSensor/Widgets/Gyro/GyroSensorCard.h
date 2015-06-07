//
// Created by Saurabh Gupta on 6/1/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorWidgetCard.h"

@class GyroSensorWidget;


@interface GyroSensorCard : SensorWidgetCard
- (instancetype)initWithWidget:(GyroSensorWidget *)widget;

- (void)update:(CMDeviceMotion *)deviceMotion;

+ (instancetype)cardWithWidget:(GyroSensorWidget *)widget;

@end