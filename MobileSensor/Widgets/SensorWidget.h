//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SensorWidgetCard;


@interface SensorWidget : NSObject {
@protected
    NSString *_displayName;
}
@property (readonly) NSString *displayName;
@property (nonatomic) BOOL isActive;
@property (nonatomic) NSTimeInterval sampleInterval;

-(SensorWidgetCard *)getSensorWidgetCard;
-(void)startWidget;
-(void)stopWidget;

@end