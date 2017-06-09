//
//  SmartSecondTableViewCell.m
//  PURENFORT_ios
//
//  Created by wall-e on 16/4/25.
//  Copyright © 2016年 wall-e. All rights reserved.
//

#import "SmartSecondTableViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation SmartSecondTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier smatrType:(NSInteger)smartType {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithRed:28.0/255.0 green:73.0/255.0 blue:161.0/255.0 alpha:0.60f];
        [self.contentView addSubview:lineView];
        
        _smartType = smartType;
        _smartImageView = [UIImageView new];
        _smartImageView.image = [UIImage imageNamed:@"smart_mini_1"];
        [self.contentView addSubview:_smartImageView];
        
        _smartLabel = [UILabel  new];
        _smartLabel.font = [UIFont systemFontOfSize:14];
        _smartLabel.textColor = [UIColor blackColor];
        _smartLabel.text = @"标题标题";
        [self.contentView addSubview:_smartLabel];
        
 
        _smartSwitch = [[SevenSwitch alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width - 70, 20, 60, 30)];

       
        [_smartSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        _smartSwitch.offImage = @"off";
        _smartSwitch.onImage = @"on";
        _smartSwitch.inactiveColor = [UIColor colorWithRed:198.0/255.0 green:200.0/255.0 blue:205.0/255.0 alpha:1.00f];
        _smartSwitch.onColor = [UIColor colorWithRed:21.0/255.0 green:60.0/255.0 blue:144.0/255.0 alpha:1.0];
        _smartSwitch.isRounded = NO;
        [self.contentView addSubview:_smartSwitch];
        [_smartSwitch setOn:NO animated:YES];
        
        _smartImageView.sd_layout
        .leftSpaceToView(self.contentView, 20)
        .topSpaceToView(self.contentView,20)
        .widthIs(40)
        .autoHeightRatio(1);
        
        _smartLabel.sd_layout
        .leftSpaceToView(_smartImageView,10)
        .topSpaceToView(self.contentView, 30)
        .widthIs(100)
        .heightIs(20);
        
        _smartSwitch.sd_layout
        .rightSpaceToView(self.contentView,20)
        .topSpaceToView(self.contentView, 30)
        .widthIs(40)
        .heightIs(20);
        
        lineView.sd_layout
        .bottomSpaceToView(self.contentView,1)
        .leftEqualToView(_smartLabel)
        .rightEqualToView(_smartSwitch)
        .heightIs(1);
        


            _smartImageView.sd_layout
            .topSpaceToView(self.contentView,25)
            .widthIs(50);
            _smartLabel.sd_layout
            .topSpaceToView(self.contentView, 40);
           
            lineView.sd_layout
            .rightSpaceToView(self.contentView, 20);
            
            _smartSwitch.sd_layout
            .rightSpaceToView(self.contentView,20)
            .topSpaceToView(self.contentView, 35)
            .widthIs(60)
            .heightIs(30);
            
            _smartLabel.font = [UIFont systemFontOfSize:16];
            _smartLabel.sd_layout
            .widthIs(120);


        switch (smartType) {
            case 4:
                break;
            case 3:
                [self createSliderView];//滑动条
                break;
            case 5:
                [self createthreeButton];//三个按钮
                break;
            case 1:
                
                [self createTwoButton];
                break;
                
            default:
                break;
        }
        
        
    }
//    _oldValue = _value;
    return self;
}
#pragma mark  getData
-(void)getSmartCellData{
    //    http://purenfort.wicp.net:8891/api/control/?device=20&value=1
    
//    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.window animated:YES];
//    hud.alpha = 0.8;
//    hud.mode=MBProgressHUDAnimationFade;//枚举类型不同的效果
////    _value = @"1";
////    _deviceID = @"23";
//    NSString *requestURL =[NSString stringWithFormat:@"%@/api/control",_ip];
//    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
//    [parmas setObject:_deviceID forKey:@"device"];
//    [parmas setObject:_value forKey:@"value"];
//
//    
//    //1.构造操作对象管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    //2.设置解析格式，不设置 --- 默认为json
//    //    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
//    
//    //简写 --- 类方法实现的就是上面的写法
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    
//    //3.如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
//    
//    [manager GET:requestURL
//      parameters:parmas
//        progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [MBProgressHUD hideHUDForView:self.window animated:YES];
//            NSLog(@"cell success %@",responseObject);
//            NSMutableDictionary *dic = responseObject;
//            if ([dic allKeys].count == 1) {
//                //失败
//                
//                
//                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"远程控制失败" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"取消", nil]show];
//                
//                
//            }else{
//                //成功
//                _oldValue = _value;
//                
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [MBProgressHUD hideHUDForView:self.window animated:YES];
//            NSLog(@"cell error %@",error);
////            _value = _oldValue;
//            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"远程控制失败" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"取消", nil]show];
//            
//        }];
    
    
    
    
}
//UIAlertView 方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //重试
        [self getSmartCellData];
    }else{
        //取消
        [self cancleController];
    }
}
//远程控制失败后的方法
-(void)cancleController{
    _value = _oldValue;
    if (_smartType == 3) {
        _slider.defaultIndx = [_value integerValue];
        if ([_value integerValue] == 0) {
            [self.smartSwitch setOn:NO];
        }else{
            [self.smartSwitch setOn:YES];
        }
    }else if(_smartType == 5){
        if ([_value integerValue] == 17) {
            _leftButton.selected = YES;
            _centerButton.selected = NO;
            _rightButton.selected = NO;
            [self.smartSwitch setOn:YES];
        }else if([_value integerValue] == 34){
            _leftButton.selected = NO;
            _centerButton.selected = YES;
            _rightButton.selected = NO;
            [self.smartSwitch setOn:YES];
        }else if([_value integerValue] == 51){
            _leftButton.selected = NO;
            _centerButton.selected = NO;
            _rightButton.selected = YES;
            [self.smartSwitch setOn:YES];
        }
        else if([_value integerValue] == 68){
            _leftButton.selected = NO;
            _centerButton.selected = NO;
            _rightButton.selected = NO;
            _smartSwitch.on = NO;
            [self.smartSwitch setOn:NO];
        }
    }else if(_smartType == 4){
        if ([_value integerValue] == 0) {
            _smartSwitch.on  = NO;
        }else{
            _smartSwitch.on = YES;
        }
    }
}
//滑动条空间
-(void)createSliderView{
    //初始化slider
    
    
    NSMutableArray *mut = [NSMutableArray array];
    for (NSInteger i = 0; i<101; i++) {
        NSString *str =[NSString stringWithFormat:@"%ld%%",(long)i];
        [mut addObject:str];
    }
    //    NSArray *arr = (NSArray *)mut;
    NSArray *myArray = [mut copy];

    _slider=[[LiuXSlider alloc] initWithFrame:CGRectMake(150, 23, 190 , 35) titles:myArray firstAndLastTitles:nil defaultIndex:0 sliderImage:[UIImage imageNamed:@"action_slider_bg"]];

    [self.contentView addSubview:_slider];
    __block SmartSecondTableViewCell *cell = self;
    
    _slider.block=^(int index){
        NSLog(@"当前index==%d",index);
        _value = [NSString stringWithFormat:@"%d",index];
        
        if (index == 0) {
            [cell.smartSwitch setOn:NO];
        }else{
            [cell.smartSwitch setOn:YES];
        }
        [cell getSmartCellData];
    };


    
}
//两个按钮（暂无）
-(void)createTwoButton{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"action_left_btn1"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(TwoLeftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftButton];
    
    leftButton.sd_layout
    .topSpaceToView(self.contentView, 30)
    .leftSpaceToView(_smartLabel,10)
    .widthIs(25)
    .autoHeightRatio(1);
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"action_right_btn1"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(TwoRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightButton];
    
    rightButton.sd_layout
    .topSpaceToView(self.contentView, 30)
    .rightSpaceToView(_smartSwitch,10)
//    .leftSpaceToView(_smartLabel,20)
    .widthIs(25)
    .autoHeightRatio(1);

    
  
        leftButton.sd_layout
        .topSpaceToView(self.contentView, 35)
        .widthIs(40);
        rightButton.sd_layout
        .topSpaceToView(self.contentView, 35)
        .widthIs(40);

}
//创建三个按钮的cell
-(void)createthreeButton{
    
    UIView *threeView = [UIView new];
    threeView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:threeView];
    
    UIImageView *lineImageView = [UIImageView new];
    lineImageView.image = [UIImage imageNamed:@"action_slider_1_bg-1"];
    [threeView addSubview:lineImageView];
    
    _leftButton = [UIButton  buttonWithType:UIButtonTypeCustom];
//    leftButton.backgroundColor = [UIColor redColor];
    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"0_L"] forState:UIControlStateSelected];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"1_L"] forState:UIControlStateNormal];
    [threeView addSubview:_leftButton];
    
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    centerButton.backgroundColor = [UIColor greenColor];
    [_centerButton addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_centerButton setBackgroundImage:[UIImage imageNamed:@"0_M"] forState:UIControlStateSelected];
    [_centerButton setBackgroundImage:[UIImage imageNamed:@"1_M"] forState:UIControlStateNormal];
    [threeView addSubview:_centerButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.backgroundColor = [UIColor yellowColor];
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"0_H"] forState:UIControlStateSelected];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"1_H"] forState:UIControlStateNormal];
    [threeView addSubview:_rightButton];
    
    threeView.sd_layout
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .leftSpaceToView(_smartLabel,10)
    .rightSpaceToView(_smartSwitch,10);
    
    lineImageView.sd_layout
    .leftSpaceToView(threeView,5)
    .rightSpaceToView(threeView,15)
    .heightIs(2)
    .topSpaceToView(threeView,40.5);

    _leftButton.sd_layout
    .topSpaceToView(threeView, 28)
    .leftSpaceToView(threeView,0)
    .widthIs(25)
    .autoHeightRatio(1);
    
    _centerButton.sd_layout
    .topSpaceToView(threeView, 28)
    .centerXEqualToView(threeView)
    .widthIs(25)
    .autoHeightRatio(1);
    
    _rightButton.sd_layout
    .topSpaceToView(threeView, 28)
    .rightSpaceToView(threeView,0)
    .widthIs(25)
    .autoHeightRatio(1);
    
    

    threeView.sd_layout
    .leftSpaceToView(_smartLabel,20)
    .rightSpaceToView(_smartSwitch,20);
    
    _leftButton.sd_layout
    .topSpaceToView(threeView, 35)
    .widthIs(30);
    _centerButton.sd_layout
    .topSpaceToView(threeView, 35)
    .widthIs(30);
    _rightButton.sd_layout
    .rightSpaceToView(threeView,0)
    .topSpaceToView(threeView, 35)
    .widthIs(30);
    
    lineImageView.sd_layout
    .heightIs(2)
    .topSpaceToView(threeView,50);

}
//L按钮方法
-(void)leftButtonAction:(UIButton*)button{
    [self changeSelectedObject:button];
    _centerButton.selected = NO;
    _rightButton.selected = NO;
    _value = @"17";
    [self.smartSwitch setOn:YES];
    [self getSmartCellData];
}
//M按钮方法
-(void)centerButtonAction:(UIButton*)button{
    [self changeSelectedObject:button];
    _value = @"34";
    _leftButton.selected = NO;
    _rightButton.selected = NO;
    [self.smartSwitch setOn:YES];
    [self getSmartCellData];
}
//H按钮方法
-(void)rightButtonAction:(UIButton*)button{
    [self changeSelectedObject:button];
    _value = @"51";
    _leftButton.selected = NO;
    _centerButton.selected = NO;
    [self.smartSwitch setOn:YES];
    [self getSmartCellData];
}

//两个按钮的左边按钮方法（暂无）
-(void)TwoLeftButtonAction:(UIButton *)button{
    NSLog(@"向左移");
}
//两个按钮的右边按钮方法（暂无）
-(void)TwoRightButtonAction:(UIButton *)button{
    NSLog(@"向右移");
    
}
- (void)changeSelectedObject:(UIButton *)sender{
    _tempButton.selected = NO;
    _tempButton = sender;
    _tempButton.selected = YES;
//    _moneyLabel.text = _tempButton.currentTitle;
}
- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
    if (_smartType == 3) {
        if (sender.on) {
            _slider.defaultIndx = 100;
            _value = @"100";
        }else{
            _slider.defaultIndx = 0;
            _value = @"0";
        }
    }else if (_smartType == 4){
        if (sender.on) {
            _value = @"1";
        }else{
            _value = @"0";
        }
    }else if(_smartType == 5){//三个按钮
        if (sender.on) {
            _value = @"34";
            _centerButton.selected = YES;
            _leftButton.selected = NO;
            _rightButton.selected = NO;
        }else{
            _value = @"68";
            _centerButton.selected = NO;
            _leftButton.selected = NO;
            _rightButton.selected = NO;
            
        }
    }
    [self getSmartCellData];
    
}

@end
