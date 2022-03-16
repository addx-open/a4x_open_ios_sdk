//
//  SettingViewController.h
//  A4xDeviceDemo_OC
//
//  Created by 积加 on 2022/2/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingModel : NSObject

/// 标题
@property (nonatomic, strong)NSString * titie;
/// 开启状态
@property (nonatomic, assign)BOOL isOpen;

@end

@interface SettingViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
