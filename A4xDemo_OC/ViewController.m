//
//  ViewController.m
//  A4xDemo_OC
//
//  Created by 郭建恒 on 2022/2/17.
//

#import "ViewController.h"
// demo
#import "Masonry.h"
#import "UIColor+Extensions.h"
#import "ToastView.h"


#import <A4xBaseSDK/A4xBaseSDK-Swift.h>
#import <A4xBindSDK/A4xBindSDK-Swift.h>
#import <A4xLiveSDK/A4xLiveSDK-Swift.h>
#import <A4xDeviceSettingSDK/A4xDeviceSettingSDK-Swift.h>

#import "LibraryViewController.h"
#import "AppLanguageViewController.h"
#import "DeviceListViewController.h"
#import "SettingViewController.h"

@interface ViewController () <A4xAppRouterDelegate>

@property (nonatomic, strong) NSMutableArray *btnTitleAllMArr;

@property (nonatomic, strong) NSArray *btnTitleSubArr;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@property (nonatomic, assign) BOOL isUseSDKDeviceList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    
    self.btnTitleAllMArr = [[NSMutableArray alloc] initWithObjects:@"LOGIN", nil];
    self.btnTitleSubArr = @[@"SIGN OUT",@"APP LANGUAGE",@"DEVICE LIST",@"CUSTOM PLAYER LIST",@"ADD DEVICE",@"ADD FRIEND'S CAMERA", @"VIDEO LIST", @"CHECK SHARE REQUEST INFO"];
    
    //A4xAppRouter * router = [[A4xAppRouter alloc]init];
    A4xAppRouter.router.delegate = self;
    
    // 判断是否登陆
    if ([[A4xBaseManager shared] checkIsLogin]) {
        // 已经登陆
        [self.btnTitleAllMArr addObjectsFromArray:self.btnTitleSubArr];
    }
    
    [self reloadUIByLogin: 0];
    
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    self.loadingView.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
    [self.view addSubview: self.loadingView];
    self.loadingView.tag = 1001;
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).with.offset(0);
        make.centerY.equalTo(self.view).with.offset(0);
    }];
    
    self.loadingView.color = [UIColor colorWithHexString:@"#65AEE5" alpha:1.0];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /// 隐藏掉nav
    [self.navigationController setNavigationBarHidden:false];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /// 隐藏掉nav
    [self.navigationController setNavigationBarHidden:true];
}

- (void)rightItemDidClick
{
    SettingViewController * settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

// 重新加载UI
- (void) reloadUIByLogin: (int) state {
    
    for (int i = state; i < self.btnTitleAllMArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor colorWithHexString:@"#65AEE5" alpha:1];
        [btn setTitle: self.btnTitleAllMArr[i] forState: UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        btn.tag = i;
        btn.clipsToBounds = 5;
        [btn addTarget:self action: @selector(bindClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview: btn];
        int height = 40;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).with.offset(0);
            make.top.equalTo(self.view).with.offset(100 + (height + 15) * i);
            make.width.equalTo(self.view).multipliedBy(1);
            make.height.mas_equalTo(height);
        }];
    }
}

// 按钮点击
- (void) bindClick: (UIButton *) btn {
    switch (btn.tag) {
        case 0: { // @"LOGIN"
            if ([[A4xBaseManager shared] checkIsLogin]) {
                [ToastView showToast:@"已登录" withDuration:3.0];
            } else {
                [self chooseTester];
            }
        }
            break;
        case 1:{ // @"SIGN OUT"
            [[A4xBaseManager shared] loginOut];
            [ToastView showToast:@"退出登录成功" withDuration:3.0];
            [self.btnTitleAllMArr removeAllObjects];
            for (UIView *view in [self.view subviews]) {
                if (view.tag != 1001) {
                    [view removeFromSuperview];
                }
            }
            [self.btnTitleAllMArr addObject:@"LOGIN"];
            [self reloadUIByLogin:0];
        }
            break;
        case 2: { // @"APP LANGUAGE"
            AppLanguageViewController *languageVC = [AppLanguageViewController new];
            [self.navigationController pushViewController:languageVC animated:YES];
        }
            break;
        case 3: { // @"DEVICE LIST"
            if (self.isUseSDKDeviceList == YES) {
                /// 使用Vico UI
                UIViewController * listVC = [[A4xLiveManager shared] getDeviceListVCWithNav:self.navigationController deviceId:@"" liveTitle:@""];
                [self.navigationController setNavigationBarHidden:false];
                [self.navigationController pushViewController:listVC animated: YES];
            } else {
                /// 使用一个UI
                DeviceListViewController * listVC = [[DeviceListViewController alloc]init];
                listVC.liveType = DemoLiveTypeA4xLive;
                [self.navigationController setNavigationBarHidden:false];
                [self.navigationController pushViewController:listVC animated: YES];
            }
            
        }
            break;
        case 4: { // @"CUSTOM PLAYER LIST"
           /// 自定义UI播放器
            /// 使用一个UI
            DeviceListViewController * listVC = [[DeviceListViewController alloc]init];
            listVC.liveType = DemoLiveTypeCustom;
            [self.navigationController setNavigationBarHidden:false];
            [self.navigationController pushViewController:listVC animated: YES];
        }
            break;
        case 5: { // @"ADD DEVICE"
            /// 进入SDK绑定页面
            UIViewController * bindVC = [[A4xBindManager shared] getBindVC];
            [self.navigationController pushViewController:bindVC animated: YES];
        }
            break;
        case 6: { // @"ADD FRIEND'S CAMERA"
            UIViewController * bindVC = [[A4xBindManager shared] addFriendDeviceVC];
            [self.navigationController pushViewController:bindVC animated: YES];
        }
            break;
        case 7: { // @"VIDEO LIST"
            LibraryViewController * libraryVC = [[LibraryViewController alloc]init];
            [self.navigationController pushViewController:libraryVC animated: YES];
        }
            break;
        case 8: { // @"CHECK SHARE REQUEST INFO"
            [[A4xBaseManager shared] showReceivedBindSharedDeviceAlert];
        }
            break;
        default:
            break;
    }
}

- (void) chooseTester {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Choose User Id to login" preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"a4x-test1(vicoo)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.isUseSDKDeviceList = YES;
        [weakSelf initA4xBaseSdkWithTenantId:@"vicoo" appToken:@"BearereyJhbGciOiJIUzUxMiJ9.eyJzZWVkIjoiMjE3N2QwOGExOTlhNGQ1M2FkZTRiMGFhMTUzYzRiNjYiLCJleHAiOjI2NDU1MjQzNDgsInVzZXJJZCI6NzAwfQ.pwGKq3YN7vduebIfavB7jQVWi2fRwBI8GUC65jG7U9nwLB2N666YMRj67NVfKMiWyvmicLbLXxwEWt1OQwq7IA" userId:@"365" nodeType:A4xNodeTypeSTAGE_NODE_US];
        
    }];
    
    UIAlertAction * action_Longse_Staging_1 = [UIAlertAction actionWithTitle:@"a4x-test1(longse_staging_1)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.isUseSDKDeviceList = YES;
        [weakSelf initA4xBaseSdkWithTenantId:@"longse" appToken:@"Bearer eyJhbGciOiJIUzUxMiJ9.eyJ0aGlyZFVzZXJJZCI6Impmc2xmanNrbGZqc2xrZmpkc2xmajczNDk1NzM5c3VmaHM4OSIsImFjY291bnRJZCI6ImxvbmdzZSIsInNlZWQiOiI4MTJmOGExNTM1YjQ0YmYwYjlhOGM3NzQzOThhODgyMCIsImV4cCI6MjY0NjI3OTQyNywidXNlcklkIjoxMDAwODI0fQ.AK1rhAGCyyePBzLiO-lqAcMTTRq9OSHmtzEynolX9_H6SpjPckjSb2Ph3vfYg2UI3I6FvbjaLKtsPgzaZz947Q" userId:@"1000792" nodeType:A4xNodeTypeSTAGE_NODE_US];
    }];
    
    UIAlertAction *action_Longse_Staging_2 = [UIAlertAction actionWithTitle:@"a4x-test2(longse_staging_2)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.isUseSDKDeviceList = YES;
        [weakSelf initA4xBaseSdkWithTenantId:@"longse" appToken:@"Bearer eyJhbGciOiJIUzUxMiJ9.eyJ0aGlyZFVzZXJJZCI6Ijg0OGhmODRmMzhyN2U3Mzg0NzNoaHUiLCJhY2NvdW50SWQiOiJsb25nc2UiLCJzZWVkIjoiYWNjMmUwMDdkYTRjNDUyOTgyOGFjNzJkZDVlZjBiY2QiLCJleHAiOjI2NDYyOTc1ODQsInVzZXJJZCI6MTAwMDgyNn0.px4zJwwgZH8byuHP6Wy0Mr2R89XReQLk3hxbH7MuAjizINmxms93P2oNP8532LWGVz1tjsXn_MkfEs9riyobhQ" userId:@"1000793" nodeType:A4xNodeTypeSTAGE_NODE_US];
        
    }];
    
    UIAlertAction *action_Longse_Prod_1 = [UIAlertAction actionWithTitle:@"a4x-test3(longse_prod_1)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.isUseSDKDeviceList = YES;
        [weakSelf initA4xBaseSdkWithTenantId:@"longse" appToken:@"Bearer eyJhbGciOiJIUzUxMiJ9.eyJ0aGlyZFVzZXJJZCI6ImtISTI3WGZGbjhLUFpzN3BQbDdjbDYiLCJhY2NvdW50SWQiOiJjaGFuZ3NoaSIsInNlZWQiOiI4N2RmNzUxNjUxYzU0Yzk2OTA2NWMwZDk3NDY1YmJlZCIsImV4cCI6MjY0NzIyNTUxMSwidXNlcklkIjoxNDMyMjh9.AafPsnhSRw1zGZ0Qk_RWyRbgc2AVqL4-wOKbfwANESvFQ2dPHzk0O_NJGmM4GHSRE55kHSt-FDd9N0tVvOqnRA" userId:@"1000794" nodeType:A4xNodeTypePROD_NODE_US];
        
    }];
        
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:action_Longse_Staging_1];
    [alert addAction:action_Longse_Staging_2];
    [alert addAction:action_Longse_Prod_1];

    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) initA4xBaseSdkWithTenantId: (NSString *) tenantId appToken: (NSString *) token userId: (NSString *) userId nodeType:(A4xNodeType)nodeType {
    [self.loadingView startAnimating];
    A4xBaseConfig * baseConfig = [A4xBaseConfig shared];
    // 美国staging
    baseConfig.appToken = token;
    baseConfig.language = @"zh";
    baseConfig.nodeType = nodeType;
    baseConfig.countryNo = @"EN";
    baseConfig.tenantId = tenantId;
    
    // 1:开启debug 0:关闭
    baseConfig.enableDebug = 1;
    baseConfig.userId = userId;
    
    [[A4xBaseManager shared] initA4xSdkWithConfig:baseConfig comple:^(enum A4xSDKInitErrorType errorType, NSString * _Nonnull message) {
        if (errorType == A4xSDKInitErrorTypeSuccess)
        {
            NSLog(@"init A4x SDK Success!");
            [self.btnTitleAllMArr addObjectsFromArray:self.btnTitleSubArr];
            [self reloadUIByLogin: 1];
            ///
            UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemDidClick)];
            self.navigationItem.rightBarButtonItem = rightItem;
        } else {
            NSString * content = [NSString stringWithFormat:@"%ld  %@", (long)errorType, message];
            [ToastView showToast: content withDuration:3.0];
        }
        [self.loadingView stopAnimating];
    }];
    
}


#pragma mark ----- A4xAppRouterDelegate -----

/// 所有有关 `跳转` 或者 `数据回调` 的逻辑,都会在下面的代理回调中触发
- (void)a4xAppRouterCompletedWithRouterType:(A4xRouterBaseType *)routerType fromClassName:(NSString *)fromClassName :(NSDictionary<NSString *,id> *)params
{
    /// 跳转页面的类型
    A4xRouterPushType pushType = routerType.pushType;
    /// 从哪个模块过来的
    A4xRouterMoudleType moudleType = routerType.moudleType;
    /// 需要跳转的原因
    A4xRouterReasonType reason = routerType.funcType;
    
    if (moudleType == A4xRouterMoudleTypeBind)
    {
        /// 从绑定模块过来的
        switch (reason) {
            case A4xRouterReasonTypeBindPageBindSuccess:
            {
                /// 绑定完成的回调
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
            case A4xRouterReasonTypeBindPageBindCancle:
            {
                /// 绑定取消了
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
                
            case A4xRouterReasonTypeBindPageOTASkip:
            {
                /// 跳过OTA升级
                [ToastView showToast:@"跳过OTA升级" withDuration:1.0f];
                /// 跳过OTA升级的回调
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
                
            case A4xRouterReasonTypeBindPageOTAFinish:
            {
                /// OTA升级完成
                [ToastView showToast:@"OTA升级完成" withDuration:1.0f];
                /// OTA升级完成的回调
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
                
            default:
                break;
        }
    } else if (moudleType == A4xRouterMoudleTypeLive) {
        /// 从直播模块过来的回调
        switch (reason) {
            case A4xRouterReasonTypeLivePageToDeviceSetting:
            {
                NSString * deviceId = params[@"deviceId"];
                NSLog(@"跳转到设置页面数据 param:%@ deviceId:%@",params,deviceId);
                /// 去设置
                UIViewController * settingVC = [[A4xDeviceSettingManager shared]getA4xDeviceSetViewControllerWithViewControllerType:A4xViewControllerTypeDeviceSet deviceId:deviceId];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
            case A4xRouterReasonTypeLivePageToLibrary:
            {
                /// 去相册
                [ToastView showToast:@"去相册" withDuration:1.0];
                //[self.navigationController popViewControllerAnimated:YES];
            }
                break;
                
            case A4xRouterReasonTypeLivePageToSoundSetting:
            {
                NSString * deviceId = params[@"deviceId"];
                NSLog(@"跳转到声音设置页面数据 param:%@ deviceId:%@",params,deviceId);
                /// 去声音设置
                UIViewController * settingVC = [[A4xDeviceSettingManager shared]getA4xDeviceSetViewControllerWithViewControllerType:A4xViewControllerTypeDeviceSound deviceId:deviceId];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
                
            case A4xRouterReasonTypeLivePageToSharePage:
            {
                /// 去分享页面
                NSString * deviceId = params[@"deviceId"];
                NSLog(@"跳转到分享页面数据 param:%@ deviceId:%@",params,deviceId);
                /// 去分享
                UIViewController * shareVC = [[A4xDeviceSettingManager shared]getA4xDeviceSetViewControllerWithViewControllerType:A4xViewControllerTypeDeviceShare deviceId:deviceId];
                [self.navigationController pushViewController:shareVC animated:YES];
            }
                break;
                
            case A4xRouterReasonTypeLivePageToFirmwareUpdatePage:
            {
                /// 需要升级按钮点击,去固件升级页面
                NSString * deviceId = params[@"deviceId"];
                NSString * content = [NSString stringWithFormat:@"去分享:%@",deviceId];
                [ToastView showToast:content withDuration:1.0];
                
                NSLog(@"跳转到固件升级页面 param:%@ deviceId:%@",params,deviceId);
                /// 去固件升级页面
                UIViewController * firmwareVC = [[A4xDeviceSettingManager shared]getA4xDeviceSetViewControllerWithViewControllerType:A4xViewControllerTypeFirmwareUpdate deviceId:deviceId];
                [self.navigationController pushViewController:firmwareVC animated:YES];
            }
                break;
                
            case A4xRouterReasonTypeLivePageRecordCompleted:
            {
                ///
                NSString * videoUrl = params[@"videoUrl"];
                NSString * audioUrl = params[@"audioUrl"];
                NSInteger videoFirstFrameTime = [params[@"videoFirstFrameTime"] integerValue];
                NSInteger audioFirstFrameTime = [params[@"audioFirstFrameTime"] integerValue];
                NSString * recordContent = [NSString stringWithFormat:@"%@ - %ld - %@ - %ld",videoUrl,videoFirstFrameTime,audioUrl,audioFirstFrameTime];
                [ToastView showToast:recordContent withDuration:2.0f];
            }
                break;
                
            case A4xRouterReasonTypeLivePageToMotionTrackingPage:
            {
                /// 去运动轨迹页面
                NSString * deviceId = params[@"deviceId"];
                UIViewController * motionTrackingVC = [[A4xDeviceSettingManager shared]getA4xDeviceSetViewControllerWithViewControllerType:A4xViewControllerTypeMotionTrack deviceId:deviceId];
                [self.navigationController pushViewController:motionTrackingVC animated:YES];
            }
                break;
               
            case A4xRouterReasonTypeLivePageToMotionDetection:
            {
                /// 去运动检测页面
                NSString * deviceId = params[@"deviceId"];
                UIViewController * motionDetectionVC = [[A4xDeviceSettingManager shared]getA4xDeviceSetViewControllerWithViewControllerType:A4xViewControllerTypeMotionDetection deviceId:deviceId];
                [self.navigationController pushViewController:motionDetectionVC animated:YES];
            }
                break;
            
            default:
                break;
        }
    } else if (moudleType == A4xRouterMoudleTypeDeviceSetting) {
        /// 从设备设置模块过来的回调
        switch (reason) {
            case A4xRouterReasonTypeDevicePageToMorePage:
            {
                [ToastView showToast:@"点击了更多按钮,前往更多页面" withDuration:1.0];
            }
                break;
            case A4xRouterReasonTypeDeviceShareCompleted:
            {
                NSInteger status = [params[@"status"] integerValue];
                NSString * statusString = @"";
                if (status == 0) {
                    statusString = @"接受";
                } else if (status == -1) {
                    statusString = @"拒绝";
                }
                NSString * content = [NSString stringWithFormat:@"点击了%@按钮,去主页",statusString];
                [ToastView showToast:content withDuration:1.0];
            }
                break;
                
            case A4xRouterReasonTypeDeviceShareScanQrcodeRequest:
            {
 
                NSString * content = [NSString stringWithFormat:@"点击了完成按钮,去主页"];
                [ToastView showToast:content withDuration:1.0];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
                
            case A4xRouterReasonTypeDeletingDevice:
            {
                NSString * content = [NSString stringWithFormat:@"点击了删除设备按钮,去列表"];
                [ToastView showToast:content withDuration:1.0];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
                
            case A4xRouterReasonTypeDevicePageQRCodeLongPress:
            {
                UIImage * image = params[@"image"];
                NSString * content = [NSString stringWithFormat:@"长按二维码 图片:(%f * %f)",image.size.width,image.size.height];
                [ToastView showToast:content withDuration:1.0];
                //[self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
                
            /// 后续可能还会有其他模块的回调,向下拓展
            default:
                break;
        }
    }
}


@end
