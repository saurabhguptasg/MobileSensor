//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol DeviceMotionUpdateHandler;
@protocol DeviceLocationUpdateHandler;

@interface WidgetManager : NSObject <CLLocationManagerDelegate>
- (void)loadWidgets;

- (void)registerDeviceMotionListener:(NSObject <DeviceMotionUpdateHandler> *)handler withKey:(NSString *)key;

- (void)deregisterDeviceMotionListenerForKey:(NSString *)key;

- (void)registerDeviceLocationListener:(NSObject <DeviceLocationUpdateHandler> *)handler withKey:(NSString *)key;

- (void)deregisterDeviceLocationListenerForKey:(NSString *)key;

+ (WidgetManager *)instance;

@property (readonly) NSArray *widgets;
@property (nonatomic) NSTimeInterval sampleInterval;
@end