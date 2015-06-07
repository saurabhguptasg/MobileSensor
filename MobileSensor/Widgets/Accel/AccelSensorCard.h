//
// Created by Saurabh Gupta on 6/1/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorWidgetCard.h"

@class AccelSensorWidget;


@interface AccelSensorCard : SensorWidgetCard
- (instancetype)initWithWidget:(AccelSensorWidget *)widget;

+ (instancetype)cardWithWidget:(AccelSensorWidget *)widget;

- (void) update:(CMDeviceMotion *)deviceMotion;

@end