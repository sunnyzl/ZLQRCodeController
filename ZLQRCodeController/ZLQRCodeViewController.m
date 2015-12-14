//
//  ZLQRCodeViewController.m
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/12.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLQRCodeViewController.h"
#import "ZLQRCodeDrawView.h"
#import "UIView+ZLFrame.h"

@interface ZLQRCodeViewController () <UIAlertViewDelegate>

@property (nonatomic, copy) ZLQRCodeScanResultHandler scanResultHandler;

@end

@implementation ZLQRCodeViewController

- (instancetype)initWithScanResultHandler:(ZLQRCodeScanResultHandler)scanResultandler
{
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied ||
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusRestricted) {
        NSString *alertStr = [NSString stringWithFormat:@"请在 设置->隐私->相机 中允许 “%@“ 访问相机", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
            [self setupAlertViewWithMessage:alertStr];
        return nil;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self = [super init];
        if (self) {
            _scanResultHandler = [scanResultandler copy];
        }
        return self;
    } else {
        [self setupAlertViewWithMessage:@"由于您的设备暂不支持摄像头\n您无法使用该功能!"];
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ZLQRCodeCameraManager *manager = [[ZLQRCodeCameraManager alloc] init];
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.view insertSubview:bottomView atIndex:0];
    //绘制背景
    ZLQRCodeDrawView  *drawView = [[ZLQRCodeDrawView alloc] initWithFrame:bottomView.bounds];
    
    [self.view insertSubview:drawView aboveSubview:bottomView];
    [manager embedPreviewInView:bottomView];
    [manager setupScanRect:drawView.sharpFrame];
    [manager startRunning];
    manager.type = self.type;
    __weak typeof(self) weakSelf = self;
    [manager setupCameraHandler:^(AVCaptureOutput *captureOutput, NSArray *metadataObjects, AVCaptureConnection *connection) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [manager stopRunning];
        [drawView stopScanAnimation];
        if (strongSelf.scanResultHandler) {
            strongSelf.scanResultHandler(metadataObjects[0]);
        }
    }];
}
- (IBAction)back2preVC:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

//  仅起到提示作用，不做任何操作
- (void)setupAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
