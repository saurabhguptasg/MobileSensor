//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>



@interface SensorWidgetCard : UITableViewCell
@property (nonatomic, readonly) UIView *backingCard;

- (UIColor *)backingCardColor;
@end
