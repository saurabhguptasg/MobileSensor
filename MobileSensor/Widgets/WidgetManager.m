//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WidgetManager.h"
#import "LocationSensorWidget.h"
#import "MSSensorUtils.h"
#import "MotionSensorWidget.h"
#import "DeviceMotionUpdateHandler.h"
#import "GyroSensorWidget.h"
#import "AccelSensorWidget.h"


@implementation WidgetManager {

@private
    NSArray *_widgets;
    NSMutableDictionary *_deviceListeners;
}

@synthesize widgets = _widgets;


- (instancetype)init {
    self = [super init];
    if (self) {
        //create to make sure CMMotionManager is initialized before any of the widgets
        MSSensorUtils *sensorUtils = [MSSensorUtils instance];
        _deviceListeners = [[NSMutableDictionary alloc] init];
        _widgets = @[
                [[LocationSensorWidget alloc] init],
                [[MotionSensorWidget alloc] init],
                [[AccelSensorWidget alloc] init],
                [[GyroSensorWidget alloc] init],
        ];
    }

    return self;
}

- (void)loadWidgets {
    for (SensorWidget *widget in _widgets) {
        //this will load from user defaults and start the last state
        [widget loadWidget];
    }
}

- (void) registerDeviceListener:(NSObject<DeviceMotionUpdateHandler> *)handler withKey:(NSString *)key {
    _deviceListeners[key] = handler;
    if(_deviceListeners.count == 1) {
        CMMotionManager *motionManager = [[MSSensorUtils instance] motionManager];
        [motionManager startDeviceMotionUpdatesToQueue:[[MSSensorUtils instance] eventsQueue]
                                           withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                               for (NSObject<DeviceMotionUpdateHandler> *currHandler in _deviceListeners.allValues) {
                                                   [currHandler handleDeviceMotionUpdate:motion];
                                               }
                                           }];
    }
}

- (void) deregisterDeviceListenerForKey:(NSString *)key {
    [_deviceListeners removeObjectForKey:key];
}




+ (WidgetManager *)instance {
    static WidgetManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}
@end