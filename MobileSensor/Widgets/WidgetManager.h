//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeviceMotionUpdateHandler;

@interface WidgetManager : NSObject
- (void)loadWidgets;

- (void)registerDeviceListener:(NSObject <DeviceMotionUpdateHandler> *)handler withKey:(NSString *)key;

- (void)deregisterDeviceListenerForKey:(NSString *)key;

+ (WidgetManager *)instance;

@property (readonly) NSArray *widgets;
@property (nonatomic) NSTimeInterval sampleInterval;
@end