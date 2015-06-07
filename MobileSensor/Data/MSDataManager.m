//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSDataManager.h"


@implementation MSDataManager {

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
    [[NSUserDefaults standardUserDefaults] setBool:state forKey:widgetName];
}

-(BOOL)getWidgetState:(NSString *)widgetName {
    return [[NSUserDefaults standardUserDefaults] boolForKey:widgetName];
}

@end

