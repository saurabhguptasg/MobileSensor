//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MSDataManager : NSObject
+ (MSDataManager *)instance;

- (void)setWidgetState:(BOOL)state forName:(NSString *)widgetName;

- (BOOL)getWidgetState:(NSString *)widgetName;
@end