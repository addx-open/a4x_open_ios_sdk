//
//  SDPlayViewController.m
//  A4xDeviceDemo_OC
//
//  Created by 郭建恒 on 2021/10/9.
//

#import "A4xSDListController.h"
#import "A4xLiveDemoController.h"

@interface A4xSDListController ()<UITableViewDelegate,UITableViewDataSource>

// 展示一天内的SD直播数据列表
@property (nonatomic, strong) UITableView * sdContentTableView;

// 数据源
@property (nonatomic, strong) NSArray<A4xObjcVideoTimeModel *> * sdContentArray;

@end

@implementation A4xSDListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    // 获取数据源
    // 注册代理协议
    //[[A4xPlayerManager handle] objc_addStateProtocolWithTarget:self];
    // 获取SD卡列表播放数据源
    [self getSDDataSource];
}

- (void)setupUI
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.sdContentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64) style:UITableViewStylePlain];
    self.sdContentTableView.delegate = self;
    self.sdContentTableView.dataSource = self;
    [self.view addSubview:self.sdContentTableView];
}

- (void)getSDDataSource
{
    self.sdContentArray = [NSArray array];
    // 当前时间戳
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
    // 前一天
    NSDate * lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSTimeInterval lastTimeInterval = [lastDay timeIntervalSince1970];
    // 获取一天内的SD卡直播列表,获取列表需要
    
    [[A4xLiveManager shared] objc_getSDVideoListWithDevice:self.deviceModel startTime:lastTimeInterval stopTime:currentTimeInterval :^(A4xObjcVideoTimeModelResponse * timeModel, enum A4xSDVideoError error) {
        self.sdContentArray = timeModel.videoSlices;
        NSLog(@"timeModel 个数 : %ld",(unsigned long)timeModel.videoSlices.count);
        // 刷新列表
        [self.sdContentTableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger) section {
    
    return [self.sdContentArray count];
}

- (UITableViewCell*)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
    }
    
    A4xObjcVideoTimeModel * timeModel = self.sdContentArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%lld - %lld",timeModel.start,timeModel.end];
    
    return cell;
}


- (void)tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    // 1 设置sd播放模型
    A4xObjcVideoTimeModel * timeModel = self.sdContentArray[indexPath.row];
    A4xObjcSDPlayModel * sdPlayModel = [[A4xObjcSDPlayModel alloc] initWithTime:timeModel.start end:timeModel.end hasData:YES audio:NO];
    
    A4xLiveDemoController * vc = [[A4xLiveDemoController alloc] init];
    A4xObjcDeviceModel * model = self.deviceModel;
    vc.deviceId = model.deviceId;
    vc.deviceModel = model;
    // 2 设置类型和sd播放模型
    vc.playType = @"sd";
    vc.sdPlayModel = sdPlayModel;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
