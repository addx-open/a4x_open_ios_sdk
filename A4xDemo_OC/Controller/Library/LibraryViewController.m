//
//  LiraryViewController.m
//  A4xDeviceDemo_OC
//
//  Created by 积加 on 2022/2/14.
//

#import "LibraryViewController.h"
#import <A4xBaseSDK/A4xBaseSDK-Swift.h>
#import "ToastView.h"

@interface LibraryViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation LibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 查询视频列表
        NSTimeInterval startTime = 0;
        NSTimeInterval endTime = 0;
        NSInteger mark = 0;
        NSInteger miss = 0;
        NSArray *array = @[@"deviceIDs"];
        NSInteger page = 1;
        NSInteger pageSize = 20;
        NSArray *tags = @[@"tags"];
        [[A4xBaseObjcLibraryInterface shared] getLibraryNormalVideoWithStart:startTime end:endTime mark:mark miss:miss deviceIds:array page:page pageSize:pageSize tags:tags comple:^(NSInteger code, NSArray<A4xObjcLibraryNormalVideoModel *> * _Nonnull, NSString * _Nullable msg) {
            if (code == 0)
            {
                [ToastView showToast:@"查询视频列表成功!" withDuration:1.0f];
            }
        }];
    } else if (indexPath.row == 1) {
        // 标记视频
        [[A4xBaseObjcLibraryInterface shared] markLibraryVideoWithVideoId:100000 enable:NO userid:1 comple:^(NSInteger code, NSString * _Nonnull msg) {
            if (code == 0)
            {
                [ToastView showToast:@"标记视频成功!" withDuration:1.0f];
            }
        }];
    } else if (indexPath.row == 2) {
        // 设置已浏览此视频
        [[A4xBaseObjcLibraryInterface shared] onReadLibraryVideoWithVideoId:100000 enable:NO userid:1 comple:^(NSInteger code, NSString * _Nonnull msg) {
            if (code == 0)
            {
                [ToastView showToast:@"设置已浏览此视频视频成功!" withDuration:1.0f];
            }
        }];
    } else if (indexPath.row == 3) {
        // 获取单条视频详细信息
        [[A4xBaseObjcLibraryInterface shared] getSingleLibraryInfoWithMsgId:100000 comple:^(NSInteger code, NSString * _Nonnull msg, A4xObjcLibraryNormalVideoModel * _Nullable model) {
            if (code == 0)
            {
                [ToastView showToast:@"获取单条视频详细信息成功!" withDuration:1.0f];
            }
        }];
    } else if (indexPath.row == 4) {
        // 删除视频
        NSArray *deviceIDs = @[@10000,@20000];
        [[A4xBaseObjcLibraryInterface shared] deleteLibraryVideoWithVideoIds:deviceIDs comple:^(NSInteger code, A4xObjcLibraryDeleteModel * _Nonnull model, NSString * _Nonnull msg) {
            if (code == 0)
            {
                [ToastView showToast:@"删除视频成功!" withDuration:1.0f];
            }
        }];
    } else if (indexPath.row == 5) {
        // 相册日期
        [[A4xBaseObjcLibraryInterface shared] getHasResourcesTimesWithStart:1643644800 end:1646064000 mark:0 miss:0 tags:@[] deviceIDs:@[] result:^(NSInteger code, NSString * _Nonnull msg, NSArray<A4xObjcLibaryDateState *> * _Nonnull dataArray) {
            if (code == 0)
            {
                [ToastView showToast:@"相册日期!" withDuration:1.0f];
            }
        }];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (NSArray *)datas {
    return @[
        @"queryVodeoList", // 查询视频列表
        @"setVideoMarkInfo", // 标记视频
        @"setVideoViewedInfo", // 设置已浏览此视频
        @"getVideoDetailInfo", // 获取单条视频详细信息
        @"deleteVideoRecord", // 删除视频
        @"queryVideoStateWithTime" // 相册日期
//        @"todo - ", // 事件的增删改查
//        @"todo - ", // 通过事件获取视频列表
    ];
}



@end
