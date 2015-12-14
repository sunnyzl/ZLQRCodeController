//
//  ViewController.m
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ViewController.h"
#import "ZLQRCodeViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    ZLQRCodeViewController *qr = [[ZLQRCodeViewController alloc] initWithScanResultHandler:^(AVMetadataMachineReadableCodeObject *metaObject) {
        NSLog(@"%@", metaObject.stringValue);
    }];
    qr.type = ZLQRCodeCameraManagerMetaDataTypeQR;
    if (qr) {
        [self presentViewController:qr animated:YES completion:nil];
    }
}

@end
