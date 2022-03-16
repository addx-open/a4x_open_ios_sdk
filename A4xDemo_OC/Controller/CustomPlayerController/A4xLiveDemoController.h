//
//  A4xLiveDemoObjcViewController.h
//  A4xDeviceDemo_OC
//
//  Created by 郭建恒 on 2021/9/16.
//

#import <UIKit/UIKit.h>
#import <A4xBaseSDK/A4xBaseSDK-Swift.h>
#import <A4xLiveSDK/A4xLiveSDK-Swift.h>

NS_ASSUME_NONNULL_BEGIN



@interface A4xLiveDemoController : UIViewController

// 设备id
@property (nonatomic,copy) NSString * deviceId;

// 设备模型
@property (nonatomic,strong) A4xObjcDeviceModel * deviceModel;

// 播放类型 一般/SD卡
// @"play" @"sd"
@property (nonatomic,copy) NSString * playType;
// SD卡播放需要这个模型
@property (nonatomic,strong) A4xObjcSDPlayModel * sdPlayModel;

@end

NS_ASSUME_NONNULL_END
