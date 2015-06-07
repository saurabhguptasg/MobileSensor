//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "SensorWidget.h"
#import "MSSensorSelectorCell.h"
#import "SensorWidgetCard.h"


@implementation SensorWidget {

}

@synthesize displayName = _displayName;
@synthesize sampleInterval = _sampleInterval;
@synthesize isActive = _isActive;

-(void)setDisplayName:(NSString *) name {
    _displayName = name;
}

/**
* override setSampleInterval in sub-classes (with call to super)
* to manage sample rate at the widget level
*/
- (void)setSampleInterval:(NSTimeInterval)sampleInterval {
    _sampleInterval = sampleInterval;
}

/**
* override getSensorWidgetCard in sub-classes (without call to super)
* to provide the dashboard with the relevant card for the widget
*/
- (SensorWidgetCard *)getSensorWidgetCard {
    return nil;
}

/**
* override in sub-classes to start the widget on listening for events
*/
- (void)startWidget {

}

/**
* override in sub-classes to stop the widget on listening for events
*/
- (void)stopWidget {

}


/**
* override setIsActive in sub-class (with call to super)
* to start/stop receiving events for a particular sensor
*/
-(void)setIsActive:(BOOL)isActive {
    _isActive = isActive;
    if(isActive) {
        [self startWidget];
    }
    else {
        [self stopWidget];
    }
}


@end
