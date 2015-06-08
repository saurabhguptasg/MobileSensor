//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSNetworkManager.h"
#import "MSDataManager.h"


@implementation MSNetworkManager {
@private
    NSString *_transmitUrl;
}

@synthesize transmitUrl = _transmitUrl;

- (instancetype)init {
    self = [super init];
    if (self) {
        _transmitUrl = [[MSDataManager instance] getEndpoint];
    }

    return self;
}


+ (MSNetworkManager *)instance {
    static MSNetworkManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (void) transmitData:(NSDictionary *) data {

}
@end