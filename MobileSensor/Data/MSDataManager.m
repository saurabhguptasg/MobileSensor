//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSDataManager.h"
#import "NSString+UUID.h"
#import "MSNetworkManager.h"

NSString * const kEndpointKey = @"endpoint";
NSString * const kTransmitModeKey = @"transmitMode";
NSString * const kBackgroundModeKey = @"backgroundMode";

NSString * const kTransmitModeHTTP = @"http";
NSString * const kTransmitModeSocket = @"socket";

@implementation MSDataManager {
@private
    NSUserDefaults *_userDefaults;
    NSMutableArray *_dataBuffer;
    MSNetworkManager *_networkManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        _dataBuffer = [[NSMutableArray alloc] init];
        [self getUUID];
        _networkManager = [MSNetworkManager instance];
        [_networkManager setTransmitUrl:[self getEndpoint]];
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
    [_networkManager setTransmitUrl:endpoint];
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

+ (BOOL) isSimulator {
    return [[[UIDevice currentDevice] model] hasSuffix:@"Simulator"]; //iPhone, iPad or iPod
}


- (NSString *) getUUID {
    static NSString *uuid;
    static dispatch_once_t tUid;
    dispatch_once(&tUid, ^{
        NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"UUID"];
        if(str == nil) {
            uuid = [MSDataManager isSimulator] ? @"SIMULATOR" : [NSString uuid];
            [[NSUserDefaults standardUserDefaults] setObject:uuid
                                                      forKey:@"UUID"];
        }
        else {
            uuid = str;
        }
    });
    return uuid;
}

@end

