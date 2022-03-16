//
//  AppLanguageViewController.m
//  A4xDemo_OC
//
//  Created by addx-wjin on 2022/2/18.
//

#import "AppLanguageViewController.h"
#import "UIColor+Extensions.h"
#import "ToastView.h"

#import <A4xBaseSDK/A4xBaseSDK-Swift.h>

#pragma mark ----- 语言模型 -----

@interface AppLanguageModel : NSObject

/// 语言
@property (nonatomic, strong)NSString * language;
/// 描述
@property (nonatomic, strong)NSString * des;

@end

@implementation AppLanguageModel
{
    
}
@end

#pragma mark ----- 语言控制器 -----

@interface AppLanguageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * languageTableView;

@property (nonatomic, strong)NSArray * dataArray;

@end

@implementation AppLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [self getAllLanguages];
    
    [self.view addSubview: self.languageTableView];//添加表格到视图
    
    //self.selectLanguage = A4xBaseAppLanguageType.language()
    //self.dataSources = A4xBaseAppLanguageType.allCases()
    //[self.dataArray addObject:m];
    
    [self.languageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCellID"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/// 获取所有的语言数组
- (NSArray *)getAllLanguages
{
    /// 英语
    AppLanguageModel * language_en = [[AppLanguageModel alloc]init];
    language_en.language = @"en";
    language_en.des = @"英语";
    /// 中文
    AppLanguageModel * language_zh = [[AppLanguageModel alloc]init];
    language_zh.language = @"zh";
    language_zh.des = @"中文";
    /// 日语
    AppLanguageModel * language_ja = [[AppLanguageModel alloc]init];
    language_ja.language = @"ja";
    language_ja.des = @"日语";
    /// 德语
    AppLanguageModel * language_de = [[AppLanguageModel alloc]init];
    language_de.language = @"de";
    language_de.des = @"德语";
    /// 俄语
    AppLanguageModel * language_ru = [[AppLanguageModel alloc]init];
    language_ru.language = @"ru";
    language_ru.des = @"俄语";
    /// 法语
    AppLanguageModel * language_fr = [[AppLanguageModel alloc]init];
    language_fr.language = @"fr";
    language_fr.des = @"法语";
    /// 意大利语
    AppLanguageModel * language_it = [[AppLanguageModel alloc]init];
    language_it.language = @"it";
    language_it.des = @"意大利语";
    /// 西班牙语
    AppLanguageModel * language_es = [[AppLanguageModel alloc]init];
    language_es.language = @"es";
    language_es.des = @"西班牙语";
    /// 芬兰语
    AppLanguageModel * language_fi = [[AppLanguageModel alloc]init];
    language_fi.language = @"fi";
    language_fi.des = @"芬兰语";
    /// 希伯来语
    AppLanguageModel * language_he = [[AppLanguageModel alloc]init];
    language_he.language = @"he";
    language_he.des = @"希伯来语";
    /// 阿拉伯语
    AppLanguageModel * language_ar = [[AppLanguageModel alloc]init];
    language_ar.language = @"ar";
    language_ar.des = @"阿拉伯语";
    /// 越南语
    AppLanguageModel * language_vi = [[AppLanguageModel alloc]init];
    language_vi.language = @"vi";
    language_vi.des = @"越南语";
    /// 葡萄牙语
    AppLanguageModel * language_pt = [[AppLanguageModel alloc]init];
    language_pt.language = @"pt";
    language_pt.des = @"葡萄牙语";
    
    NSArray * languagesArray = @[language_en,language_zh,language_ja,language_de,language_ru,language_fr,language_it,language_es,language_fi,language_he,language_ar,language_vi,language_pt];
    return languagesArray;
}

//懒加载
- (UITableView *)languageTableView {
    if (_languageTableView == nil) {
        _languageTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _languageTableView.delegate = self;//遵循协议
        _languageTableView.dataSource = self;//遵循数据源
    }
    return _languageTableView;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    AppLanguageModel * languageModel = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",languageModel.language,languageModel.des];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#65AEE5" alpha:1];
       
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppLanguageModel * languageModel = self.dataArray[indexPath.row];
    [[A4xBaseManager shared] objc_setLanguageWithLanguage:languageModel.language comple:^(NSInteger code, NSString * _Nonnull message) {
        if (code == 0) {
            NSLog(@"语言设置成功!");
            [ToastView showToast:@"语言设置成功!" withDuration:1.0];
            
            if ([languageModel.language isEqualToString:@"he"] || [languageModel.language isEqualToString:@"ar"])
            {
                /// 阿拉伯语/希伯来语 更新成功需要适配UI
                [self.navigationController.navigationBar setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
                [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
            } else {
                [self.navigationController.navigationBar setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
                [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }];
}

@end
