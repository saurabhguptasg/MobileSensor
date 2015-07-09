//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSDataManager.h"

NSString * const kEndpointKey = @"endpoint";
NSString * const kTransmitModeKey = @"transmitMode";
NSString * const kBackgroundModeKey = @"backgroundMode";

NSString * const kTransmitModeHTTP = @"http";
NSString * const kTransmitModeSocket = @"socket";

@implementation MSDataManager {
@private
    NSUserDefaults *_userDefaults;
    NSMutableArray *_dataBuffer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        _dataBuffer = [[NSMutableArray alloc] init];
    }

    return self;
}


+ (MSDataManager *)instance {
    static MSDataManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (void)setWidgetState:(BOOL)state forName:(NSString *)widgetName {
    [_userDefaults setBool:state forKey:widgetName];
}

-(BOOL)getWidgetState:(NSString *)widgetName {
    return [_userDefaults boolForKey:widgetName];
}

- (void) setEndpoint:(NSString *) endpoint {
    [_userDefaults setObject:endpoint forKey:kEndpointKey];
}

- (NSString *) getEndpoint {
    return [_userDefaults objectForKey:kEndpointKey];
}

- (void) setTransmitMode:(NSString *)mode {
    [_userDefaults setObject:mode forKey:kTransmitModeKey];
}

- (NSString *) getTransmitMode {
    return [_userDefaults objectForKey:kTransmitModeKey];
}

-(void) setBackgroundMode:(NSString *)mode {
    [_userDefaults setObject:mode forKey:kBackgroundModeKey];
}

- (NSString *) getBackgroundMode {
    return [_userDefaults objectForKey:kBackgroundModeKey];
}

@end

