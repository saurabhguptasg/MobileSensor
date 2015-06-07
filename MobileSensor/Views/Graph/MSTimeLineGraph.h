//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MSTimeLineGraph : UIView
- (instancetype)initWithGraphFrame:(CGRect)aGraphFrame minY:(CGFloat)aMinY maxY:(CGFloat)aMaxY bufferSize:(NSInteger)aBufferSize;

- (void)addValue:(CGFloat)value;

+ (instancetype)graphWithGraphFrame:(CGRect)aGraphFrame minY:(CGFloat)aMinY maxY:(CGFloat)aMaxY bufferSize:(NSInteger)aBufferSize;

@end