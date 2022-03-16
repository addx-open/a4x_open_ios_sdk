//
//  SDPlayViewController.h
//  A4xDeviceDemo_OC
//
//  Created by 郭建恒 on 2021/10/9.
//

#import <UIKit/UIKit.h>
#import <A4xBaseSDK/A4xBaseSDK-Swift.h>
#import <A4xLiveSDK/A4xLiveSDK-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface A4xSDListController : UIViewController

// 设备模型
@property (nonatomic,strong) A4xObjcDeviceModel * deviceModel;

@end



NS_ASSUME_NONNULL_END
