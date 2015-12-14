//
//  ZLQRCodeViewController.h
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/12.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZLQRCodeCameraManager.h"

typedef void(^ZLQRCodeScanResultHandler)(AVMetadataMachineReadableCodeObject *metaObject);

@interface ZLQRCodeViewController : UIViewController

@property (nonatomic, assign) ZLQRCodeCameraManagerMetaDataType type;

- (instancetype)initWithScanResultHandler:(ZLQRCodeScanResultHandler)scanResultandler;

@end
