//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSDashboardViewController.h"
#import "WidgetManager.h"
#import "SensorWidget.h"


@implementation MSDashboardViewController {

@private
    NSMutableArray *widgets;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        widgets = [[NSMutableArray alloc] init];
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Dashboard"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self updateModel];

}


- (void)updateModel {
    [widgets removeAllObjects];
    for (SensorWidget *widget in [[WidgetManager instance] widgets]) {
        if(widget.isActive) {
            [widgets addObject:widget];
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateModel];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return widgets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(SensorWidget *) widgets[indexPath.item] getSensorWidgetCard];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}


@end