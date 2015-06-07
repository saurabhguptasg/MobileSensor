//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "SensorWidgetCard.h"
#import "MSSensorUtils.h"


@implementation SensorWidgetCard {

@private
    UIView *_backingCard;
}

@synthesize backingCard = _backingCard;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize screenSize = [[MSSensorUtils instance] screenSize];
        self.backgroundColor = [UIColor whiteColor];
        _backingCard = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, screenSize.width-20.0f, 150.0f)];
        _backingCard.layer.cornerRadius = 5.0f;
        _backingCard.layer.masksToBounds = YES;
        _backingCard.backgroundColor = [self backingCardColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:_backingCard];
    }

    return self;
}

- (UIColor *)backingCardColor {
    return [[UIColor orangeColor] colorWithAlphaComponent:0.66];
}


@end