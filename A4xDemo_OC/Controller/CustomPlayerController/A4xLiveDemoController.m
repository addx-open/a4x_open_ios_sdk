//
//  A4xLiveDemoObjcViewController.m
//  A4xDeviceDemo_OC
//
//  Created by 郭建恒 on 2021/9/16.
//

#import "A4xLiveDemoController.h"
#import "A4xLiveDemoView.h"
#import "Masonry.h"

@interface A4xLiveDemoController ()<A4xObjcPlayerStateChangeProtocol>

@property (nonatomic , strong) A4xLiveDemoView * videoView;

@property (nonatomic , assign) BOOL isFullScreen;

@end

@implementation A4xLiveDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFullScreen = NO;
    
    // 注册代理协议
    [[A4xLiveManager shared] objc_addStateProtocolWithTarget:self];
    // 获取SD卡列表播放数据源
    [self setupUI];
    
    /**
     * 摇头机P2P连接成功之后,调用如下方法
     * 最好是在获取视频之后,即connecting状态后,再显示摇头功能
     * 该方法只能给摇头机调用,CG6等不支持摇头的设备不能调用
     */
    /**
    A4xObjcUIRresetRotate * rotateModel = [[A4xObjcUIRresetRotate alloc] init];
    // 根据情况自己设置
    rotateModel.pitch = 0;
    rotateModel.yaw = -1;
    [[A4xLiveManager shared] objc_sendRotateCmdWithDeviceModel:self.deviceModel rotateModel:rotateModel comple:^(NSString * errorString) {
        
    }];
     */
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[A4xLiveManager shared] objc_stopLiveWithDevice:self.deviceModel playNumber:1 reason:A4xPlayerStopReasonChangePage];
}

- (void)setupUI
{
    self.videoView = [[A4xLiveDemoView alloc]initWithFrame:CGRectMake(0, 100, 375, 200)];
    [self.view addSubview:self.videoView];
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_width).multipliedBy(9.0 / 16.0);
    }];
    
    NSArray * btnTitleArr = [NSArray arrayWithObjects:@"开始",@"暂停",@"重试",@"全屏",@"开启白光灯",@"关闭白光灯",@"开启声音",@"关闭声音",@"开启对讲",@"关闭对讲",@"高清",@"标清",@"流畅",@"自适应",@"截屏",@"判断预设",@"添加预设",@"删除预设",@"查询预设",@"设置位置",@"上",@"做",@"下",@"右" ,nil];
    CGFloat btnHeight = 50;
    CGFloat btnWidth = 80;
    CGFloat btnSpacing = 20;
    CGFloat btnWidthSum = 20;
    
    for (int i = 0; i < btnTitleArr.count ; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(20 + i * 80, 320, 60, 50);
        [button setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.videoView.mas_bottom).offset(20 + i/4 * 40);
            if (i <= 3)
            {
                make.left.mas_equalTo(5 + i * 85);
            }
            else if (i >=/* DISABLES CODE */ (4) && i <= 7)
            {
                make.left.mas_equalTo(5 + (i-4) * 85);
            }
            else if (i >=8 && i <= 11)
            {
                make.left.mas_equalTo(5 + (i-8) * 85);
            }
            
            else if (i >=12 && i <= 15)
            {
                make.left.mas_equalTo(5 + (i-12) * 85);
            }
            else if (i >=16 && i <= 19)
            {
                make.left.mas_equalTo(5 + (i-16) * 85);
            }
            else if (i >=20 && i <= 23)
            {
                make.left.mas_equalTo(5 + (i-20) * 85);
            }
            
            make.height.mas_equalTo(btnHeight);
            make.width.mas_equalTo(btnWidth);
        }];
    }
}

- (void)buttonDidClicked:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (tag == 0) {
        if ([self.playType isEqualToString:@"play"])
        {
            // 普通播放
            [[A4xLiveManager shared] objc_playLiveWithPlayType:A4xObjcPlayerDisplayTypeVertical device:self.deviceModel objcSDPlayModel:nil voiceEnable:NO shouldSpeak:NO];
        }
        else if ([self.playType isEqualToString:@"sd"])
        {
            // sd卡播放,需要sd卡播放模型
            [[A4xLiveManager shared] objc_playLiveWithPlayType:A4xObjcPlayerDisplayTypeSd device:self.deviceModel objcSDPlayModel:self.sdPlayModel voiceEnable:NO shouldSpeak:NO];
        }
    }
    else if (tag == 1)
    {
        [[A4xLiveManager shared] objc_stopLiveWithDevice:self.deviceModel playNumber:1 reason:A4xPlayerStopReasonChangePage];
    }
    else if (tag == 3)
    {
        // 1 更新frame
        self.isFullScreen = YES;
        [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.centerX.equalTo(self.view);
            make.height.mas_equalTo(375);
            make.width.mas_equalTo(667);
        }];
        
        [self.videoView layoutIfNeeded];
        NSLog(@"点击了全屏直播 -0 ,当前frame: %@",NSStringFromCGRect(self.videoView.bounds));
        // 2.更新全屏
        NSNumber * value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        // 3.更新设备出图
        [[A4xLiveManager shared] objc_updateWithDevice:self.deviceModel];
    }
    else if (tag == 4)
    {
        [[A4xLiveManager shared] objc_setWhiteLightWithDevice:self.deviceModel enable:YES];
    }
    else if (tag == 5)
    {
        [[A4xLiveManager shared] objc_setWhiteLightWithDevice:self.deviceModel enable:NO];
    }
    else if (tag == 6)
    {
        [[A4xLiveManager shared] objc_setAudioEnableWithDevice:self.deviceModel enable:YES];
    }
    else if (tag == 7)
    {
        [[A4xLiveManager shared] objc_setAudioEnableWithDevice:self.deviceModel enable:NO];
        
    }
    else if (tag == 8)
    {
        [[A4xLiveManager shared] objc_setAudioEnableWithDevice:self.deviceModel enable:YES];
        [[A4xLiveManager shared] objc_setSpeakEnableWithDevice:self.deviceModel enable:YES];
    }
    else if (tag == 9)
    {
        [[A4xLiveManager shared] objc_setAudioEnableWithDevice:self.deviceModel enable:NO];
        [[A4xLiveManager shared] objc_setSpeakEnableWithDevice:self.deviceModel enable:NO];
    }
    else if (tag == 10)
    {
        // 高清
        A4xObjcVideoSharpType sharpType = A4xObjcVideoSharpTypeHb;
        [[A4xLiveManager shared] objc_setResolutionTypeWithDevice:self.deviceModel objcSharpType:sharpType completionCallback:^(BOOL isComplete) {
            if (isComplete == YES)
            {
                // TODO
                NSLog(@"高清分辨率设置成功!");
            }
        }];
    }
    else if (tag == 11)
    {
        // 标清
        A4xObjcVideoSharpType sharpType = A4xObjcVideoSharpTypeStandard;
        [[A4xLiveManager shared] objc_setResolutionTypeWithDevice:self.deviceModel objcSharpType:sharpType completionCallback:^(BOOL isComplete) {
            if (isComplete == YES)
            {
                // TODO
                NSLog(@"标清分辨率设置成功!");
            }
        }];
        
    }
    else if (tag == 12)
    {
        // 流畅
        A4xObjcVideoSharpType sharpType = A4xObjcVideoSharpTypeSmooth;
        [[A4xLiveManager shared] objc_setResolutionTypeWithDevice:self.deviceModel objcSharpType:sharpType completionCallback:^(BOOL isComplete) {
            if (isComplete == YES)
            {
                // TODO
                NSLog(@"流畅分辨率设置成功!");
            }
        }];
    }
    else if (tag == 13)
    {
        // 自动
        A4xObjcVideoSharpType sharpType = A4xObjcVideoSharpTypeAuto;
        [[A4xLiveManager shared] objc_setResolutionTypeWithDevice:self.deviceModel objcSharpType:sharpType completionCallback:^(BOOL isComplete) {
            if (isComplete == YES)
            {
                // TODO
                NSLog(@"自动分辨率设置成功!");
            }
        }];
    }
    
    else if (tag == 14)
    {
        // 截屏功能
        [[A4xLiveManager shared] objc_getCurrentImageWithDevice:self.deviceModel completionCallback:^(UIImage * currentImage) {
            NSLog(@"截图: %@",currentImage);
        }];
    }
    else if (tag == 15)
    {
        // 判断能否添加预设位置
        A4xPresetDataModel *presetModel =  [[A4xPresetDataModel alloc]initWithFllowInfos:@{} followTypes:@{}];
        BOOL canAdd = [presetModel canAddLocationWithDeviceId:self.deviceModel.deviceId];
        NSLog(@"能否添加: %d",canAdd);
    }
    else if (tag == 16)
    {
        // 添加预设位置 name:预设位置名称
        [[A4xLiveManager shared] objc_getCurrentImageWithDevice:self.deviceModel completionCallback:^(UIImage * currentImage) {
            
            A4xPresetDataModel *presetModel =  [[A4xPresetDataModel alloc]initWithFllowInfos:@{} followTypes:@{}];
            [presetModel addWithDeviceId:self.deviceModel.deviceId image:currentImage name:@"2222" comple:^(BOOL isSuccess, NSString * msg) {
                NSLog(@"添加预设位置结果: %d",isSuccess);
            }];
        }];
        
        
    }
    else if (tag == 17)
    {
        // 删除预设位置
        A4xPresetDataModel *presetModel =  [[A4xPresetDataModel alloc]initWithFllowInfos:@{} followTypes:@{}];
        // 这里参数pointId是列表获取的A4xObjcPresetModel对应的locationId字符串
        A4xObjcPresetModel * model = [[A4xObjcPresetModel alloc]init];
        NSString * locationId = [NSString stringWithFormat:@"%ld",model.locationId];
        [presetModel removeWithDeviceId:self.deviceModel.deviceId pointId:locationId comple:^(BOOL complete, NSString * msg) {
        
        }];
    }
    else if (tag == 18)
    {
        // 获取所有的预设位置
        A4xPresetDataModel *presetModel =  [[A4xPresetDataModel alloc]initWithFllowInfos:@{} followTypes:@{}];
        [presetModel selectLocationsWithDeviceId:self.deviceModel.deviceId comple:^(NSInteger code, NSArray<A4xObjcPresetModel *> * list, NSString * msg) {
            NSLog(@"全部预设位置列表:%@",list);
        }];
    }
    else if (tag == 19)
    {
        // 使用预设位置
        A4xPresetDataModel *presetModel =  [[A4xPresetDataModel alloc]initWithFllowInfos:@{} followTypes:@{}];
        // 从列表中获取的
        //[presetModel setCurrentLocationWithDeviceId:self.deviceModel.deviceId preset:<#(A4xObjcPresetModel * _Nullable)#> comple:<#^(NSString * _Nullable)comple#>];
    }
    
    else if (tag == 20)
    {
        // 上
        A4xObjcUIRresetRotate * rotateModel =  [[A4xObjcUIRresetRotate alloc]init];
        rotateModel.pitch = 1;
        rotateModel.yaw = 0;
        [[A4xLiveManager shared] objc_sendRotateCmdWithDeviceModel:self.deviceModel rotateModel:rotateModel comple:^(NSString * msg) {
            NSLog(@"摇头 - 上 - %@",msg);
        }];
        
        
    }
    else if (tag == 21)
    {
        // 左
        A4xObjcUIRresetRotate * rotateModel =  [[A4xObjcUIRresetRotate alloc]init];
        rotateModel.pitch = 0;
        rotateModel.yaw = -1;
        [[A4xLiveManager shared] objc_sendRotateCmdWithDeviceModel:self.deviceModel rotateModel:rotateModel comple:^(NSString * msg) {
            NSLog(@"摇头 - 左 - %@",msg);
        }];
    }
    else if (tag == 22)
    {
        // 下
        A4xObjcUIRresetRotate * rotateModel =  [[A4xObjcUIRresetRotate alloc]init];
        rotateModel.pitch = -1;
        rotateModel.yaw = 0;
        [[A4xLiveManager shared] objc_sendRotateCmdWithDeviceModel:self.deviceModel rotateModel:rotateModel comple:^(NSString * msg) {
            NSLog(@"摇头 - 下 - %@",msg);
        }];
    }
    else if (tag == 23)
    {
        // 右
        A4xObjcUIRresetRotate * rotateModel =  [[A4xObjcUIRresetRotate alloc]init];
        rotateModel.pitch = 0;
        rotateModel.yaw = 1;
        [[A4xLiveManager shared] objc_sendRotateCmdWithDeviceModel:self.deviceModel rotateModel:rotateModel comple:^(NSString * msg) {
            NSLog(@"摇头 - 右 - %@",msg);
        }];
    }
    
    
}


#pragma mark ----- A4xObjcPlayerStateChangeProtocol -----

/// deviceId
- (NSString * _Nonnull)a4xObjcPlayerDeviceId SWIFT_WARN_UNUSED_RESULT
{
    return self.deviceModel.deviceId;
}
/// 播放器连接状态
- (void)a4xObjcPlayerConnectStateWithPlayerModel:(A4xObjcPlayerModel * _Nonnull)playerModel videoV:(UIView * _Nullable)videoV videoSize:(CGSize)videoSize
{
    NSLog(@"-----------> playerConnectState state: %ld videoV: %@ videoSize: %@",playerModel.playState,videoV,NSStringFromCGSize(videoSize));
    
    // 更新suvView状态
    [self.videoView updatePlayerModel:playerModel];
    // 更新suvView状态
    self.videoView.videoState = playerModel.playState;
    if (playerModel.playState == A4xObjcPlayerStateTypePlaying)
    {
        //self.view.backgroundColor = [UIColor whiteColor];
        
        if (self.isFullScreen == NO)
        {
            videoV.frame = self.videoView.bounds;
        }
        else
        {
            NSLog(@"点击了全屏直播,当前bounds: %@",NSStringFromCGRect(self.videoView.videoView.bounds));
            videoV.frame = self.videoView.bounds;
        }
        [self.videoView.videoView addSubview:videoV];
    }
}



- (void)a4xObjcPlayerReceiveReplaySeekCommandWithDeviceID:(NSString *)deviceID objcReplaySeekModel:(A4xObjcReplaySeekModel *)objcReplaySeekModel action:(NSString *)action
{
    NSLog(@"SD卡播放Seek回调 当前deviceId:%@ action类型:%@ timeStamp:%lld seekTime:%lld",deviceID,objcReplaySeekModel.action,objcReplaySeekModel.timeStamp,objcReplaySeekModel.seekTime);
}

/// 播放器音量
- (void)a4xObjcPlayerSpackVoiceWithData:(NSArray<NSNumber *> * _Nonnull)data
{
    
}
/// 播放器截屏
- (void)a4xObjcPlayerSnapImageWithImage:(UIImage * _Nullable)image
{
    
}
/// 播放器视频速度
- (void)a4xObjcPlayerVideoSpeedWithSpeed:(NSString * _Nonnull)speed
{
    
}
/// 当前时间戳
- (void)a4xObjcPlayerVideoCurrentTimerWithDate:(NSTimeInterval)date
{
    
}
/// 白光灯
- (void)a4xObjcPlayerVideoWhiteLightWithEnable:(BOOL)enable error:(NSString * _Nullable)error
{
    
}
/// 是否旋转
- (void)a4xObjcPlayerDeviceEnableRotatingWithEnable:(BOOL)enable
{
    
}

/// 用于播放器收到消息上报页面做处理，接口待完善
- (void)a4xObjcPlayerAlertMessageWithMessage:(NSString * _Nullable)message
{
    
}

/// 播放器录制状态
- (void)a4xObjcPlayerRecoredStateWithState:(enum A4xObjcPlayerRecordState)state error:(NSInteger)errorCode videoPath:(NSString *)videoPath audioPath:(NSString *)audioPath
{
    
}

@end
