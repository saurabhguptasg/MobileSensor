//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SensorWidget;


@interface MSSensorSelectorCell : UITableViewCell
-(void)updateWithSensorWidget:(SensorWidget *)sensorWidget;
@end