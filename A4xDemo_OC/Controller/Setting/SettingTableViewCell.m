//
//  TestTableViewCell.m
//  A4xDemo_OC
//
//  Created by 郭建恒 on 2022/3/4.
//

#import "SettingTableViewCell.h"
#import "Masonry.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self layoutAllSubViews];
    return self;
}

- (void)layoutAllSubViews
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"111";
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.contentView).offset(20);
    }];
    
    self.contentSwitch = [[UISwitch alloc]init];
    [self.contentSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.contentSwitch];
    [self.contentSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentView).offset(-20);
    }];

}

- (void)setSettingCell:(SettingModel *)model
{
    self.titleLabel.text = model.titie;
    self.contentSwitch.on = model.isOpen;
}

- (void)switchValueChanged:(UISwitch *)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingTableViewCellSwitchValueChanged:isOpen:)]) {
        [self.delegate settingTableViewCellSwitchValueChanged:self.indexPath isOpen:sender.isOn];
    }
}

@end
