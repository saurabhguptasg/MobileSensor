//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MSDataManager : NSObject
+ (MSDataManager *)instance;

- (void)setWidgetState:(BOOL)state forName:(NSString *)widgetName;

- (BOOL)getWidgetState:(NSString *)widgetName;

- (void)setEndpoint:(NSString *)endpoint;

- (NSString *)getEndpoint;

- (void)setTransmitMode:(NSString *)mode;

- (NSString *)getTransmitMode;

- (void)setBackgroundMode:(NSString *)mode;

- (NSString *)getBackgroundMode;

- (NSString *)getUUID;

@property(nonatomic, copy, readonly) NSString *sessionId;

@end