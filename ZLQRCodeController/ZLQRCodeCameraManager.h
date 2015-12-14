//
//  ZLQRCodeCameraManager.h
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define kDeviceWidth [[UIScreen mainScreen] bounds].size.width
#define kDeviceHeight [[UIScreen mainScreen] bounds].size.height

typedef NS_ENUM(NSInteger, ZLQRCodeCameraManagerMetaDataType) {
    ZLQRCodeCameraManagerMetaDataTypeQR,
    ZLQRCodeCameraManagerMetaDataTypeBarCode,
    ZLQRCodeCameraManagerMetaDataTypeBoth
};

typedef void(^ZLQRCodeCameraManagerHandler)(AVCaptureOutput *captureOutput, NSArray *metadataObjects, AVCaptureConnection *connection);

@interface ZLQRCodeCameraManager : NSObject <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) ZLQRCodeCameraManagerMetaDataType type;

- (void)setupCameraHandler:(ZLQRCodeCameraManagerHandler)cameraHandler;

- (void)embedPreviewInView: (UIView *) aView;

- (void)setupScanRect:(CGRect)scanRect;

- (void)startRunning;

- (void)stopRunning;

- (BOOL)isRunning;

@end
