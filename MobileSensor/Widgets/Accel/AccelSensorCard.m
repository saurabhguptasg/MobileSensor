//
// Created by Saurabh Gupta on 6/1/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "AccelSensorCard.h"
#import "AccelSensorWidget.h"
#import "MSTimeLineGraph.h"


@implementation AccelSensorCard {
@private
    AccelSensorWidget *_widget;
    MSTimeLineGraph *xGraph;
    MSTimeLineGraph *yGraph;
    MSTimeLineGraph *zGraph;
}
- (instancetype)initWithWidget:(AccelSensorWidget *)widget {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AccelCard"];
    if (self) {
        _widget = widget;
        CGRect cardFrame = [self backingCard].frame;
        xGraph = [[MSTimeLineGraph alloc] initWithGraphFrame:CGRectMake(5.0f, 5.0f, cardFrame.size.width - 10.0f, 50.0f)
                                                        minY:-2.0f
                                                        maxY:2.0f
                                                  bufferSize:100];
        yGraph = [[MSTimeLineGraph alloc] initWithGraphFrame:CGRectMake(5.0f, 55.0f, cardFrame.size.width - 10.0f, 50.0f)
                                                        minY:-2.0f
                                                        maxY:2.0f
                                                  bufferSize:100];
        zGraph = [[MSTimeLineGraph alloc] initWithGraphFrame:CGRectMake(5.0f, 105.0f, cardFrame.size.width - 10.0f, 50.0f)
                                                        minY:-2.0f
                                                        maxY:2.0f
                                                  bufferSize:100];
        [self.backingCard addSubview:xGraph];
        [self.backingCard addSubview:yGraph];
        [self.backingCard addSubview:zGraph];
    }

    return self;
}

+ (instancetype)cardWithWidget:(AccelSensorWidget *)widget {
    return [[self alloc] initWithWidget:widget];
}

- (void)update:(CMDeviceMotion *)deviceMotion {
//    NSLog(@"deviceMotion.userAcceleration = %f,%f,%f", deviceMotion.userAcceleration.x, deviceMotion.userAcceleration.y, deviceMotion.userAcceleration.z);
    [xGraph addValue:deviceMotion.userAcceleration.x];
    [yGraph addValue:deviceMotion.userAcceleration.y];
    [zGraph addValue:deviceMotion.userAcceleration.z];
}


- (UIColor *)backingCardColor {
    return [[UIColor redColor] colorWithAlphaComponent:0.66];
}

@end