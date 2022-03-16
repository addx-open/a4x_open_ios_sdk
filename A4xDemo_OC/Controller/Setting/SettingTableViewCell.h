//
//  TestTableViewCell.h
//  A4xDemo_OC
//
//  Created by 郭建恒 on 2022/3/4.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SettingTableViewCellDelegate <NSObject>

- (void)settingTableViewCellSwitchValueChanged:(NSIndexPath *)indexPath isOpen:(BOOL)isOpen;

@end


@interface SettingTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UISwitch * contentSwitch;

@property (nonatomic, weak)id<SettingTableViewCellDelegate> delegate;

/// indexPath
@property (nonatomic, strong)NSIndexPath * indexPath;

- (void)setSettingCell:(SettingModel *)model;

@end

NS_ASSUME_NONNULL_END
