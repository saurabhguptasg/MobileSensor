//
// Created by Saurabh Gupta on 6/1/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "MotionSensorCard.h"
#import "MotionSensorWidget.h"
#import "MSSensorUtils.h"
#import "NSString+FontAwesome.h"


@implementation MotionSensorCard {
@private
    MotionSensorWidget *_widget;
    UILabel *xLabel;
    UILabel *yLabel;
    UILabel *zLabel;

    UILabel *xValue;
    UILabel *yValue;
    UILabel *zValue;

    UILabel *xDegrees;
    UILabel *yDegrees;
    UILabel *zDegrees;
}
- (instancetype)initWithWidget:(MotionSensorWidget *)widget {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MotionCard"];
    if (self) {
        CGRect cardFrame = [self backingCard].frame;
        _widget = widget;
        xLabel = [[UILabel alloc] init];
        xValue = [[UILabel alloc] init];
        xDegrees = [[UILabel alloc] init];

        yLabel = [[UILabel alloc] init];
        yValue = [[UILabel alloc] init];
        yDegrees = [[UILabel alloc] init];

        zLabel = [[UILabel alloc] init];
        zValue = [[UILabel alloc] init];
        zDegrees = [[UILabel alloc] init];

        xLabel.text = @"Pitch";
        yLabel.text = @"Roll";
        zLabel.text = @"Yaw";

        [self createTitleLabel:xLabel
                    valueLabel:xValue
                  degreesLabel:xDegrees
                       atIndex:0
                     withFrame:cardFrame];

        [self createTitleLabel:yLabel
                    valueLabel:yValue
                  degreesLabel:yDegrees
                       atIndex:1
                     withFrame:cardFrame];

        [self createTitleLabel:zLabel
                    valueLabel:zValue
                  degreesLabel:zDegrees
                       atIndex:2
                     withFrame:cardFrame];

        [[self backingCard] addSubview:xLabel];
        [[self backingCard] addSubview:xValue];
        [[self backingCard] addSubview:xDegrees];

        [[self backingCard] addSubview:yLabel];
        [[self backingCard] addSubview:yValue];
        [[self backingCard] addSubview:yDegrees];

        [[self backingCard] addSubview:zLabel];
        [[self backingCard] addSubview:zValue];
        [[self backingCard] addSubview:zDegrees];
    }

    return self;
}

- (void)createTitleLabel:(UILabel *)label
              valueLabel:(UILabel *)value
            degreesLabel:(UILabel *)degrees
                 atIndex:(NSInteger)index
               withFrame:(CGRect)frame {
    value.font = [UIFont fontWithName:kFontAwesomeFamilyName size:100];
    value.text = [NSString fontAwesomeIconStringForEnum:FAcircleONotch];

    CGFloat labelWidth = (frame.size.width - 10.0f)/3.0f;
    CGFloat x = 5.0f + (labelWidth * index);
    CGFloat y = 5.0f;
    label.frame = CGRectMake(x, y, labelWidth, 20);
    label.textAlignment = NSTextAlignmentCenter;

    CGFloat valueXPos = x + (labelWidth - 100)/2;
    value.frame = CGRectMake(valueXPos, y + 30, 100, 100);
    value.textAlignment = NSTextAlignmentCenter;

    degrees.frame = CGRectMake(x, y+30+40, labelWidth, 20);
    degrees.textAlignment = NSTextAlignmentCenter;
}

+ (instancetype)cardWithWidget:(MotionSensorWidget *)widget {
    return [[self alloc] initWithWidget:widget];
}

- (void)update:(CMDeviceMotion *)deviceMotion {
    dispatch_async(dispatch_get_main_queue(), ^{
        xValue.transform = CGAffineTransformMakeRotation(deviceMotion.attitude.pitch);
        xDegrees.text = [NSString stringWithFormat:@"%.f", deviceMotion.attitude.pitch * (180.0 / M_PI)];

        yValue.transform = CGAffineTransformMakeRotation(deviceMotion.attitude.roll);
        yDegrees.text = [NSString stringWithFormat:@"%.f", deviceMotion.attitude.roll * (180.0 / M_PI)];

        zValue.transform = CGAffineTransformMakeRotation(deviceMotion.attitude.yaw);
        zDegrees.text = [NSString stringWithFormat:@"%.f", deviceMotion.attitude.yaw * (180.0 / M_PI)];

    });
}

- (UIColor *)backingCardColor {
    return [[UIColor blueColor] colorWithAlphaComponent:0.50];
}

@end