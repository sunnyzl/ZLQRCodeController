//
//  ZLQRCodeCameraManager.m
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLQRCodeCameraManager.h"

@interface ZLQRCodeCameraManager ()

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, copy) ZLQRCodeCameraManagerHandler cameraHandler;
@property (nonatomic, weak) AVCaptureMetadataOutput *output;

@end

@implementation ZLQRCodeCameraManager

- (instancetype)init
{
    if (self = [super init]) {
        [self setupCaptureSession];
    }
    return self;
}

- (void)setupCameraHandler:(ZLQRCodeCameraManagerHandler)cameraHandler
{
    self.cameraHandler = [cameraHandler copy];
}

- (void)setupCaptureSession
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _session = [[AVCaptureSession alloc] init];
    [_session addInput:input];
    [_session addOutput:output];
    self.output = output;
    self.type = ZLQRCodeCameraManagerMetaDataTypeQR;
    
}

- (void)setupScanRect:(CGRect)scanRect
{
    CGFloat scanX = scanRect.origin.x / kDeviceWidth;
    CGFloat scanY = scanRect.origin.y / kDeviceHeight;
    CGFloat scanW = scanRect.size.width / kDeviceWidth;
    CGFloat scanH = scanRect.size.height/ kDeviceHeight;
    self.output.rectOfInterest = CGRectMake(scanY, scanX, scanH, scanW);
}

- (void)setType:(ZLQRCodeCameraManagerMetaDataType)type
{
    _type = type;
    switch (_type) {
        case ZLQRCodeCameraManagerMetaDataTypeQR:
            self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
            break;
        case ZLQRCodeCameraManagerMetaDataTypeBarCode:
            self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                                AVMetadataObjectTypeEAN8Code,
                                                AVMetadataObjectTypeCode128Code];
        case ZLQRCodeCameraManagerMetaDataTypeBoth:
            self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                                AVMetadataObjectTypeEAN8Code,
                                                AVMetadataObjectTypeCode128Code,
                                                AVMetadataObjectTypeQRCode];
            break;
    }
}

- (void)startRunning
{
    [self.session startRunning];
    
}

- (void)stopRunning
{
    [self.session stopRunning];
}

- (BOOL)isRunning
{
    return [self.session isRunning];
}

- (void) embedPreviewInView: (UIView *) aView {
    
    if (!self.session) {
        return;
    }
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
    }
    self.previewLayer.frame = aView.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [aView.layer addSublayer: self.previewLayer];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
        if (self.cameraHandler)
        if (metadataObjects.count > 0) {
            {
            self.cameraHandler(captureOutput, metadataObjects, connection);
        }
    }
    
}

@end
