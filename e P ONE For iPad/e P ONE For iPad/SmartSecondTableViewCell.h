//
//  SmartSecondTableViewCell.h
//  PURENFORT_ios
//
//  Created by wall-e on 16/4/25.
//  Copyright © 2016年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SevenSwitch.h"
#import "LiuXSlider.h"

@interface SmartSecondTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier smatrType:(NSInteger)smartType;
@property (nonatomic, assign) NSInteger smartType;//4 中间无控件  3 中间滑动条   5 中间3个按钮（17 低 34 中 51 高 68 关）  1 中间2个按钮(暂无)
@property (nonatomic, strong) UIImageView *smartImageView;//图标
@property (nonatomic, strong) UILabel *smartLabel;//cell标题
@property (nonatomic, strong) SevenSwitch *smartSwitch;
@property (nonatomic,strong)LiuXSlider *slider;
@property (nonatomic, strong)UIButton *tempButton;
@property (nonatomic, copy) NSString *deviceID;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, strong)UIButton *leftButton;
@property (nonatomic, strong)UIButton *centerButton;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *oldValue;
@end
