//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MSNetworkManager : NSObject

@property (nonatomic) NSString *transmitUrl;

+ (MSNetworkManager *)instance;

- (void)transmitSamples:(NSArray *)samples forDeviceId:(NSString *)deviceId withSessionId:(NSString *)sessionId;
@end