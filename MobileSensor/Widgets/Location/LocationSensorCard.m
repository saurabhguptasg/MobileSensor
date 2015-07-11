//
// Created by Saurabh Gupta on 5/31/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationSensorCard.h"
#import "LocationSensorWidget.h"


@implementation LocationSensorCard {
@private
    LocationSensorWidget *_widget;
    MKMapView *_mapView;
    MKPointAnnotation *_pointAnnotation;
    UILabel *_locationLabel;
}
- (instancetype)initWithWidget:(LocationSensorWidget *)widget {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationCard"];
    if (self) {
        _widget = widget;
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(
                5.0f,
                5.0f,
                [self backingCard].frame.size.width - 10.0f,
                [self backingCard].frame.size.height - 10.0f)];
        _mapView.layer.cornerRadius = 5.0f;
        _mapView.layer.masksToBounds = YES;
        _mapView.zoomEnabled = YES;
//        _mapView.delegate = self;

        _pointAnnotation = [[MKPointAnnotation alloc] init];
        [_mapView addAnnotation:_pointAnnotation];
        [_mapView selectAnnotation:_pointAnnotation animated:NO];

        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                5.0f,
                [self backingCard].frame.size.height - 15.0f,
                [self backingCard].frame.size.width - 10.0f,
                10.0f)];
        _locationLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.33f];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.font = [UIFont systemFontOfSize:10];
        _locationLabel.textColor = [UIColor darkGrayColor];
        _locationLabel.layer.cornerRadius = 5.0f;
        _locationLabel.layer.masksToBounds = YES;

        [self.textLabel setText:@"Location Sensor Card"];
        [[self backingCard] addSubview:_mapView];
        [[self backingCard] addSubview:_locationLabel];
    }

    return self;
}

+ (instancetype)cardWithWidget:(LocationSensorWidget *)widget {
    return [[self alloc] initWithWidget:widget];
}

- (UIColor *)backingCardColor {
    return [[UIColor brownColor] colorWithAlphaComponent:0.50];
}

- (void)handleDeviceLocationUpdate:(CLLocation *)location {
    dispatch_async(dispatch_get_main_queue(), ^{
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
        _mapView.region = region;

        _pointAnnotation.coordinate = location.coordinate;
        _locationLabel.text = [NSString stringWithFormat:@"%5f,%5f",location.coordinate.latitude, location.coordinate.longitude];
    });
}


- (void)update:(NSArray *)locations {
    if(locations.count == 0) {
        return;
    }
    CLLocation *location = locations[0];
    dispatch_async(dispatch_get_main_queue(), ^{
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
        _mapView.region = region;

        _pointAnnotation.coordinate = location.coordinate;
        _locationLabel.text = [NSString stringWithFormat:@"%5f,%5f",location.coordinate.latitude, location.coordinate.longitude];
    });
}



@end