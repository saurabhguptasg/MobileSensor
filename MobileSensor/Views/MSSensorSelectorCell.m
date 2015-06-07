//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSSensorSelectorCell.h"
#import "SensorWidget.h"


@implementation MSSensorSelectorCell {

@private
    UISwitch *isSelectedSwitch;
    SensorWidget *_sensorWidget;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        isSelectedSwitch = [[UISwitch alloc] init];
        [isSelectedSwitch addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
        [self setAccessoryView:isSelectedSwitch];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }

    return self;
}

-(void)updateWithSensorWidget:(SensorWidget *)sensorWidget {
    _sensorWidget = sensorWidget;
    self.textLabel.text = _sensorWidget.displayName;
    isSelectedSwitch.on = _sensorWidget.isActive;
}

/*
- (void)updateWithDisplayName:(NSString *)displayName isSelected:(BOOL)isSelected forIndex:(NSInteger)itemIndex {
    [self.textLabel setText:displayName];
    index = itemIndex;
    [isSelectedSwitch setOn:isSelected];
}
*/

-(void)selected:(id)sender{
    _sensorWidget.isActive = isSelectedSwitch.isOn;
    NSLog(@"changed for index %@ to value %i", _sensorWidget.displayName, _sensorWidget.isActive);
}

@end