//
// Created by Saurabh Gupta on 6/1/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "GyroSensorCard.h"
#import "GyroSensorWidget.h"


@implementation GyroSensorCard {
@private
    GyroSensorWidget *_widget;
}
- (instancetype)initWithWidget:(GyroSensorWidget *)widget {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GyroCard"];
    if (self) {
        _widget = widget;
        [self.textLabel setText:@"Gyro Card"];
    }

    return self;
}

+ (instancetype)cardWithWidget:(GyroSensorWidget *)widget {
    return [[self alloc] initWithWidget:widget];
}

- (UIColor *)backingCardColor {
    return [[UIColor grayColor] colorWithAlphaComponent:0.66];
}

- (void)update:(CMDeviceMotion *)deviceMotion {

}

@end