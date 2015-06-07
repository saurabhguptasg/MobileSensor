//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSTimeLineGraph.h"


@implementation MSTimeLineGraph {
@private
    CGRect graphFrame;
    CGFloat minY;
    CGFloat maxY;
    NSInteger bufferSize;
    NSMutableArray *buffer;

    CGFloat centerValue;
}

- (instancetype)initWithGraphFrame:(CGRect)frame minY:(CGFloat)aMinY maxY:(CGFloat)aMaxY bufferSize:(NSInteger)aBufferSize {
    self = [super initWithFrame:frame];
    if (self) {
        graphFrame = frame;
        minY = aMinY;
        maxY = aMaxY;
        centerValue = (maxY + minY) / 2.0f;
        bufferSize = aBufferSize;
        buffer = [[NSMutableArray alloc] initWithCapacity:bufferSize];
        for (int i = 0; i < bufferSize; ++i) {
            buffer[i] = @0.0F;
        }
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

- (void)addValue:(CGFloat) value {
    [buffer addObject:[NSNumber numberWithFloat:value]];
    [buffer removeObjectAtIndex:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

-(void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);

/*
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
*/

    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);

    CGFloat stepWidth = rect.size.width / bufferSize;
    CGFloat unitHeight = rect.size.height / (maxY - minY);
    CGFloat centerY = rect.origin.y + rect.size.height/2;

    CGContextMoveToPoint(context, rect.origin.x, centerY);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, centerY);

    CGContextMoveToPoint(context, rect.origin.x, centerY);
    for (int i = 0; i < bufferSize; ++i) {
        CGContextAddLineToPoint(context, rect.origin.x + (i*stepWidth), centerY + ([buffer[i] floatValue] * unitHeight));
    }
    CGContextStrokePath(context);
}


+ (instancetype)graphWithGraphFrame:(CGRect)aGraphFrame minY:(CGFloat)aMinY maxY:(CGFloat)aMaxY bufferSize:(NSInteger)aBufferSize {
    return [[self alloc] initWithGraphFrame:aGraphFrame minY:aMinY maxY:aMaxY bufferSize:aBufferSize];
}

@end