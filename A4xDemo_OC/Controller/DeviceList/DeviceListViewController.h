//
//  DeviceListViewController.h
//  A4xDemo_OC
//
//  Created by 郭建恒 on 2022/3/7.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DemoLiveTypeCustom  = 0,
    DemoLiveTypeA4xLive = 1
} DemoLiveType;

NS_ASSUME_NONNULL_BEGIN

@interface DeviceListViewController : UIViewController

@property (nonatomic, assign)DemoLiveType liveType;

@end

NS_ASSUME_NONNULL_END
