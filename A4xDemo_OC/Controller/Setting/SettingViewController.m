//
//  SettingViewController.m
//  A4xDeviceDemo_OC
//
//  Created by 积加 on 2022/2/15.
//

#import "SettingViewController.h"
#import "Masonry.h"
#import "SettingTableViewCell.h"
#import <A4xDeviceSettingSDK/A4xDeviceSettingSDK-Swift.h>

#pragma mark ----- 设置模型 -----



@implementation SettingModel

@end

#pragma mark ----- 设置的控制器 -----
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,SettingTableViewCellDelegate>

@property (nonatomic, strong)UITableView * settingTableView;

@property (nonatomic, strong)NSArray * dataArray;

@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.settingTableView = [[UITableView alloc] init];
    self.settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    [self.view addSubview:self.settingTableView];
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(self.view);
    }];
    
    self.dataArray = [self getAllData];
    [self.settingTableView reloadData];
    
}

/// 获取所有的语言数组
- (NSArray *)getAllData
{
    SettingModel * notiSetting =  [[SettingModel alloc]init];
    notiSetting.titie = @"通知设置等";
    notiSetting.isOpen = [A4xDeviceSettingConfig shared].isOpenNotificationSetting;
    
    SettingModel * installSetting =  [[SettingModel alloc]init];
    installSetting.titie = @"安装设置";
    installSetting.isOpen = [A4xDeviceSettingConfig shared].isOpenInstallSetting;
    
    SettingModel * moreSetting =  [[SettingModel alloc]init];
    moreSetting.titie = @"更多设置";
    moreSetting.isOpen = [A4xDeviceSettingConfig shared].isOpenMoreSetting;
    
    NSArray * languagesArray = @[notiSetting,installSetting,moreSetting];
    return languagesArray;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray array];//初始化数组
    }
    return _dataArray;
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
    static NSString * cellIdentifier = @"SettingTableViewCell";
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SettingTableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    SettingModel * model = self.dataArray[indexPath.row];
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell setSettingCell:model];
       
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark ----- SettingTableViewCellDelegate -----
- (void)settingTableViewCellSwitchValueChanged:(NSIndexPath *)indexPath isOpen:(BOOL)isOpen
{
    if (indexPath.row == 0) {
        ///
        [A4xDeviceSettingConfig shared].isOpenNotificationSetting = isOpen;
    } else if (indexPath.row == 1) {
        ///
        [A4xDeviceSettingConfig shared].isOpenInstallSetting = isOpen;
    } else {
        [A4xDeviceSettingConfig shared].isOpenMoreSetting = isOpen;
    }
}

@end
