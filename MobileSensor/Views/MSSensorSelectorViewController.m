//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSensorSelectorViewController.h"
#import "WidgetManager.h"
#import "SensorWidget.h"
#import "MSSensorSelectorCell.h"


@implementation MSSensorSelectorViewController {

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

    self.navigationItem.title = @"Select Sensors";

    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _widgetManager.widgets.count;
}


- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSSensorSelectorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"selectorCell"];
    if(cell == Nil) {
        cell = [[MSSensorSelectorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectorCell"];
    }

    [cell updateWithSensorWidget:(SensorWidget *) _widgetManager.widgets[indexPath.item]];

    return cell;
}




@end