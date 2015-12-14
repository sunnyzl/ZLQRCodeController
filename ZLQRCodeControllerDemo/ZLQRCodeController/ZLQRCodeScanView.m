//
//  ZLQRCodeScanView.m
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLQRCodeScanView.h"
#import "UIView+ZLFrame.h"

#define kZLQRCodeScanViewLineWidth 2.f
#define kZLQRCodeScanViewLineColor [UIColor colorWithRed:139.0/255.0 green:1.0 blue:0 alpha:1]

@interface ZLQRCodeScanView ()

@property (nonatomic, assign) CGFloat lineThickness;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) UIView *scanLine;

@end

@implementation ZLQRCodeScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.lineColor = [UIColor whiteColor];
        self.brokenLineColor = kZLQRCodeScanViewLineColor;
        self.brokenLineThickness = 2.f;
        self.brokenLineWH = 20;
        [self createLine];
        self.scanLineThickness = 1.f;
        [self showLine];
        self.timeInterval = 0.3f;
        self.durationTime = 2.f;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame durationTime:(NSTimeInterval)durationTime
{
    if (self = [self initWithFrame:frame]) {
        self.durationTime = durationTime;
    }
    return self;
}

- (void)setBrokenLineThickness:(CGFloat)brokenLineThickness
{
    _brokenLineThickness = brokenLineThickness;
    self.lineThickness = _brokenLineThickness / 2.f;
}

- (void)setDurationTime:(NSTimeInterval)durationTime
{
    _durationTime = durationTime;
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:durationTime + self.timeInterval target:self selector:@selector(startScanLine) userInfo:nil repeats:YES];
    [_timer fire];
}

- (NSMutableArray *)createLine
{
    CGRect frameReact[] = {
        CGRectMake(self.brokenLineWH, 0, self.zl_rectWidth - 2 * self.brokenLineWH, self.lineThickness),
        CGRectMake(0, self.brokenLineWH, self.lineThickness, self.zl_rectHeight - 2 * self.brokenLineWH),
        CGRectMake(self.brokenLineWH, self.zl_rectHeight - self.lineThickness, self.zl_rectWidth - 2 * self.brokenLineWH, self.lineThickness),
        CGRectMake(self.zl_rectWidth - self.lineThickness, self.brokenLineWH, self.lineThickness, self.zl_rectHeight - 2 * self.brokenLineWH)
    };
    
    for (int i = 0; i<4; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:frameReact[i]];
        lineView.backgroundColor = self.lineColor;
        [self addSubview:lineView];
    }
    return nil;
}

- (void)startScanLine
{
    [UIView animateWithDuration:self.durationTime animations:^{
        self.scanLine.hidden = NO;
        self.scanLine.transform = CGAffineTransformMakeTranslation(0, self.zl_rectHeight - 2 * self.brokenLineThickness);
    } completion:^(BOOL finished) {
        self.scanLine.hidden = YES;
        self.scanLine.transform = CGAffineTransformIdentity;
    }];
}

- (void)showLine
{
    CGRect frame = CGRectMake(self.brokenLineThickness, self.brokenLineThickness, self.zl_rectWidth - 2 * self.brokenLineThickness, self.scanLineThickness);
    UIView *scanLine = [[UIView alloc] initWithFrame:frame];
    scanLine.backgroundColor = kZLQRCodeScanViewLineColor;
    scanLine.hidden = YES;
    [self addSubview:scanLine];
    self.scanLine = scanLine;
    
    
}

- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext,[self.brokenLineColor CGColor]);
    
    CGContextSetLineWidth(currentContext, self.brokenLineThickness);
    
    CGFloat XY = self.brokenLineThickness / 2.f;
    CGPoint newPoints1[] = {
        CGPointMake(XY, self.brokenLineWH),
        CGPointMake(XY, XY),
        CGPointMake(self.brokenLineWH, XY)
    };
    CGContextAddLines(currentContext, newPoints1, 3);
    CGContextStrokePath(currentContext);
    
    
    
    CGPoint newPoints2[] = {
        CGPointMake(self.zl_rectWidth - XY, self.brokenLineWH),
        CGPointMake(self.zl_rectWidth - XY, XY),
        CGPointMake(self.zl_rectWidth - self.brokenLineWH, XY)
    };
    CGContextAddLines(currentContext, newPoints2, 3);
    CGContextStrokePath(currentContext);
    
    
    CGPoint newPoints3[] = {
        CGPointMake(XY, self.zl_rectHeight - self.brokenLineWH),
        CGPointMake(XY, self.zl_rectHeight - XY),
        CGPointMake(self.brokenLineWH,self.zl_rectHeight - XY)
    };
    CGContextAddLines(currentContext, newPoints3, 3);
    CGContextStrokePath(currentContext);
    
    CGPoint newPoints4[] = {
        CGPointMake(self.zl_rectWidth - self.brokenLineWH, self.zl_rectHeight - XY),
        CGPointMake(self.zl_rectWidth - XY,self.zl_rectHeight - XY),
        CGPointMake(self.zl_rectWidth - XY,self.zl_rectHeight - self.brokenLineWH)
    };
    CGContextAddLines(currentContext, newPoints4, 3);
    CGContextStrokePath(currentContext);
    
}

- (void)dealloc
{
    [self stopScanAnimation];
}

- (void)stopScanAnimation
{
    
    [_timer invalidate];
    self.scanLine.hidden = YES;
    _timer = nil;
}

@end
