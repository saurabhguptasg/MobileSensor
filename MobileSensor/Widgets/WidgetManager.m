//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "WidgetManager.h"
#import "LocationSensorWidget.h"
#import "MSSensorUtils.h"
#import "MotionSensorWidget.h"
#import "GyroSensorWidget.h"
#import "AccelSensorWidget.h"
#import "DeviceLocationUpdateHandler.h"
#import "MSDataManager.h"
#import "MSNetworkManager.h"


@implementation WidgetManager {

@private
    NSArray *_widgets;
    NSMutableDictionary *_deviceListeners;
    NSMutableDictionary *_locationListeners;
    NSMutableArray *_samples;
    CLLocation *_currentLocation;

    NSOperationQueue *_eventsQueue;
    NSTimer *_executionTimer;
}

@synthesize widgets = _widgets;


- (instancetype)init {
    self = [super init];
    if (self) {
        //create to make sure CMMotionManager is initialized before any of the widgets
        MSSensorUtils *sensorUtils = [MSSensorUtils instance];
        _deviceListeners = [[NSMutableDictionary alloc] init];
        _locationListeners = [[NSMutableDictionary alloc] init];
        _samples = [[NSMutableArray alloc] init];
        _currentLocation = nil;
        _eventsQueue = [[NSOperationQueue alloc] init];
        [_eventsQueue setMaxConcurrentOperationCount:1];
        _executionTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(enqueueTransmit:)
                                                         userInfo:nil
                                                          repeats:YES];
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

-(void)background {
    [[[MSSensorUtils instance] locationManager] stopUpdatingLocation];
    NSLog(@"stopped updating fine grained location");
}

-(void)foreground {
    [[[MSSensorUtils instance] locationManager] startUpdatingLocation];
    NSLog(@"restarted updating fine grained location");
}

/**
* app must be terminated for background processing to stop, else locations will continue to be transmitted
*/
- (void)terminate {
    [[[MSSensorUtils instance] locationManager] stopUpdatingLocation];
    [[[MSSensorUtils instance] locationManager] stopMonitoringSignificantLocationChanges];
    [[[MSSensorUtils instance] motionManager] stopDeviceMotionUpdates];
    [_eventsQueue cancelAllOperations];
}

- (void) registerDeviceMotionListener:(NSObject <DeviceMotionUpdateHandler> *)handler
                              withKey:(NSString *)key {
    _deviceListeners[key] = handler;
    if(_deviceListeners.count == 1) {
        CMMotionManager *motionManager = [[MSSensorUtils instance] motionManager];
        [motionManager startDeviceMotionUpdatesToQueue:[[MSSensorUtils instance] eventsQueue]
                                           withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                               for (NSObject<DeviceMotionUpdateHandler> *currHandler in _deviceListeners.allValues) {
                                                   [currHandler handleDeviceMotionUpdate:motion];
                                                   [self enqueueData:motion];
                                               }
                                           }];
    }
}

- (void) deregisterDeviceMotionListenerForKey:(NSString *)key {
    [_deviceListeners removeObjectForKey:key];
    if(_deviceListeners.count == 0) {
        CMMotionManager *motionManager = [[MSSensorUtils instance] motionManager];
        [motionManager stopDeviceMotionUpdates];
    }
}

- (void) registerDeviceLocationListener:(NSObject <DeviceLocationUpdateHandler> *) handler
                                withKey:(NSString *) key {
    _locationListeners[key] = handler;
    if(_locationListeners.count == 1) {
        CLLocationManager *locationManager = [[MSSensorUtils instance] locationManager];
        [locationManager setDelegate:self];

        [locationManager requestAlwaysAuthorization];
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
            [locationManager startUpdatingLocation];
            [locationManager startMonitoringSignificantLocationChanges];
        }
    }
}

- (void) deregisterDeviceLocationListenerForKey:(NSString *)key {
    [_locationListeners removeObjectForKey:key];
    if(_locationListeners.count == 0) {
        CLLocationManager *locationManager = [[MSSensorUtils instance] locationManager];
        [locationManager stopUpdatingLocation];
        [locationManager stopMonitoringSignificantLocationChanges];
    }
}

#pragma mark - queueing tasks

- (void) enqueueData:(CMDeviceMotion *)motion {
    __weak NSMutableArray *weakSamples = _samples;
    [_eventsQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        data[@"timestamp"] = @([[NSDate date] timeIntervalSince1970]);
        if(_currentLocation) {
            data[@"latitude"] = @(_currentLocation.coordinate.latitude);
            data[@"longitude"] = @(_currentLocation.coordinate.longitude);
        }

        data[@"pitch"] = @(motion.attitude.pitch);
        data[@"roll"] = @(motion.attitude.roll);
        data[@"yaw"] = @(motion.attitude.yaw);

        data[@"mag.x"] = @(motion.magneticField.field.x);
        data[@"mag.y"] = @(motion.magneticField.field.y);
        data[@"mag.z"] = @(motion.magneticField.field.z);

        data[@"accel.x"] = @(motion.userAcceleration.x);
        data[@"accel.y"] = @(motion.userAcceleration.y);
        data[@"accel.z"] = @(motion.userAcceleration.z);

        [weakSamples addObject:data];
    }]];
}

- (void) enqueueTransmit:(id)sender {
    __weak NSMutableArray *weakSamples = _samples;
    [_eventsQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
        if(weakSamples.count == 0) {
            return;
        }
        __block NSArray *tempSamples = [NSArray arrayWithArray:weakSamples];
        [weakSamples removeAllObjects];
        [_eventsQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            [[MSNetworkManager instance] transmitSamples:tempSamples
                                             forDeviceId:[[MSDataManager instance] getUUID]
                                           withSessionId:[[MSDataManager instance] sessionId]];
        }]];
    }]];
}

#pragma mark - location update messages

- (void)locationManager:(CLLocationManager *)locationManager
        didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestWhenInUseAuthorization];
    }
    else if(status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [locationManager startUpdatingLocation];
        [locationManager startMonitoringSignificantLocationChanges];
    }
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    if(locations.count > 0) {
        _currentLocation = locations[0];
        for (NSObject <DeviceLocationUpdateHandler> *locationListener in _locationListeners.objectEnumerator) {
            [locationListener handleDeviceLocationUpdate:_currentLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading {

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