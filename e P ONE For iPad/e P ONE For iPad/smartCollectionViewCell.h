//
//  smartCollectionViewCell.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/24.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SevenSwitch.h"
#import "LiuXSlider.h"
#import "UIView+SDAutoLayout.h"
#import "DNSRequestData.h"
@interface smartCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *smartImageView;//图标
@property (nonatomic, strong) UILabel *smartLabel;//cell标题
@property (nonatomic, strong) SevenSwitch *smartSwitch;
@property (nonatomic,strong)LiuXSlider *slider;
@property (nonatomic, copy) NSString *value;

@property (nonatomic, strong)UIButton *lineButton;
@property (nonatomic, strong)UIButton *lineButton1;
@property (nonatomic, strong)UIButton *leftButton;
@property (nonatomic, strong)UIButton *centerButton;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, strong)UIButton *tempButton;

@property (nonatomic, assign) NSInteger cellType;

@property (nonatomic, copy) NSString *oldValue;

@property (nonatomic,strong) NSString *deviceID;




-(void)createSliderView;
-(void)createthreeButton;
-(void)createSwitch;
-(void)createTwoButton;
@end
