# ZLQRCodeController
二维码扫描控制器，可扫描二维码和条形码

##使用方法
    ZLQRCodeViewController *qr = [[ZLQRCodeViewController alloc] initWithScanResultHandler:^(AVMetadataMachineReadableCodeObject *metaObject) {
        NSLog(@"%@", metaObject.stringValue);
    }];
  
    qr.type = ZLQRCodeCameraManagerMetaDataTypeQR;
    if (qr) {
        [self presentViewController:qr animated:YES completion:nil];
    }
    默认的扫描模式为ZLQRCodeCameraManagerMetaDataTypeQR，可选择二维码、条形码或者同时扫描二维码和条形码
    在此需要判断二维码控制器是否为空，可以根据需要自己选择push或者modal，并输入相应代码.
##效果图
![](https://raw.githubusercontent.com/sunnyzl/ZLQRCodeController/master/demo1.jpg)
![](https://raw.githubusercontent.com/sunnyzl/ZLQRCodeController/master/demo2.jpg)