//
//  ZLQRCodeScanView.h
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLQRCodeScanView : UIView

@property (nonatomic, assign) CGFloat brokenLineThickness;

@property (nonatomic, assign) CGFloat brokenLineWH;

@property (nonatomic, strong) UIColor *brokenLineColor;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat scanLineThickness;

@property (nonatomic, assign) NSTimeInterval durationTime;

@property (nonatomic, assign) NSTimeInterval timeInterval;


- (instancetype)initWithFrame:(CGRect)frame durationTime:(NSTimeInterval)durationTime;

- (void)stopScanAnimation;

@end
