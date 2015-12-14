//
//  ZLQRCodeDrawView.m
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLQRCodeDrawView.h"
#import "ZLQRCodeScanView.h"

@interface ZLQRCodeDrawView ()

@property (nonatomic, strong) CAShapeLayer *cropLayer;
@property (nonatomic, assign) CGSize       sharpSize;
@property (nonatomic, weak) ZLQRCodeScanView *scanView;

@end

@implementation ZLQRCodeDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig
{
    self.backgroundColor = [UIColor clearColor];
    self.cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat sharpWH = self.frame.size.width * 0.6;
    self.sharpSize = CGSizeMake(sharpWH, sharpWH);
    _sharpFrame = CGRectMake((self.bounds.size.width - self.sharpSize.width)/2.0,
                             (self.bounds.size.height - self.sharpSize.height)/2.0,
                             self.sharpSize.width,
                             self.sharpSize.height);
    CGPathAddRect(path, nil, self.sharpFrame);
    CGPathAddRect(path, nil, self.bounds);
    self.cropLayer.opacity = 0.3f;
    [self.cropLayer setFillRule:kCAFillRuleEvenOdd];
    [self.cropLayer setPath:path];
    [self.cropLayer setFillColor:[[UIColor blackColor] CGColor]];
    [self.cropLayer setNeedsDisplay];
    [self.layer addSublayer:self.cropLayer];
    ZLQRCodeScanView *scanView = [[ZLQRCodeScanView alloc] initWithFrame:_sharpFrame];
    [self addSubview:scanView];
    self.scanView = scanView;
    CGPathRelease(path);
}


- (void)stopScanAnimation
{
    [self.scanView stopScanAnimation];
}

@end
