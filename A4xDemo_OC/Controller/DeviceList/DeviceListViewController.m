//
//  DeviceListViewController.m
//  A4xDemo_OC
//
//  Created by 郭建恒 on 2022/3/7.
//

#import "DeviceListViewController.h"
#import <A4xBaseSDK/A4xBaseSDK-Swift.h>
#import <A4xLiveSDK/A4xLiveSDK-Swift.h>
#import "A4xLiveDemoController.h"
#import "A4xSDListController.h"

@interface DeviceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * deviceTableView;

@property (nonatomic, strong)NSArray * dataArray;

@end

@implementation DeviceListViewController

//懒加载
- (UITableView *)deviceTableView {
    if (_deviceTableView == nil) {
        _deviceTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _deviceTableView.delegate = self;//遵循协议
        _deviceTableView.dataSource = self;//遵循数据源
        [_deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"deviceTableViewCell"];
    }
    return _deviceTableView;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray array];//初始化数组
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"列表页展示的类型: %ld",self.liveType);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.deviceTableView];//添加表格到视图
    // Do any additional setup after loading the view.
    [self getAllData];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)getAllData
{
    [[A4xBaseObjcDeviceSettingInterface shared] objc_getDeviceListWithComple:^(NSInteger code, NSString * _Nonnull message, NSArray<A4xObjcDeviceModel *> * _Nonnull deviceModels) {
        if (code == 0) {
            self.dataArray = deviceModels;
            NSLog(@"self.dataArray :%@",self.dataArray);
            [self.deviceTableView reloadData];
        } else {
            /// 获取信息失败
        }
    }];
    
    //[[A4xBaseObjcDeviceSettingInterface shared] objc_getDeviceSettingConfigWithDeviceId:<#(NSString * _Nonnull)#> comple:<#^(NSInteger, NSString * _Nonnull, A4xObjcDeviceModel * _Nullable)comple#>];
}

/// 播放类型 SD卡 还是 直播
- (void) choosePlayTypeWithDeviceModel:(A4xObjcDeviceModel *)deviceModel {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Choose Play Type" preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"play" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ///
        A4xLiveDemoController * liveVC = [[A4xLiveDemoController alloc]init];
        liveVC.playType = @"play";
        liveVC.deviceId = deviceModel.deviceId;
        liveVC.deviceModel = deviceModel;
        [weakSelf.navigationController pushViewController:liveVC animated:YES];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"sd" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        A4xSDListController * sdVC = [[A4xSDListController alloc] init];
        sdVC.deviceModel = deviceModel;
        [weakSelf.navigationController pushViewController: sdVC animated: true];
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:action2];
    [alert addAction:cancle];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
//分区，组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//每个分区的行数
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return self.dataArray.count;
}

//每个单元格的内容
- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    A4xObjcDeviceModel * deviceModel = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"设备: %@",deviceModel.deviceId];
       
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    A4xObjcDeviceModel * deviceModel = self.dataArray[indexPath.row];
    NSString * deviceId = deviceModel.deviceId;
    
    if (self.liveType == DemoLiveTypeA4xLive) {
        /// 只展示当前的直播的话,需要传deviceId
        /// 如果需要展示全部的直播列表,deviceId传@""
        /// 需要标题传入需要的字符串
        UIViewController * liveVC = [[A4xLiveManager shared] getDeviceListVCWithNav:self.navigationController deviceId:deviceId liveTitle:@"XXX直播"];
        /// 跳转到直播页面,自动播放
        [self.navigationController pushViewController:liveVC animated:YES];
    } else {
        /// 选择类型
        [self choosePlayTypeWithDeviceModel:deviceModel];
    }
    
}



@end
