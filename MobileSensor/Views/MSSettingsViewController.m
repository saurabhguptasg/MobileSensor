//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSSettingsViewController.h"
#import "WidgetManager.h"


@implementation MSSettingsViewController {

    WidgetManager *_widgetManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _widgetManager = [WidgetManager instance];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end