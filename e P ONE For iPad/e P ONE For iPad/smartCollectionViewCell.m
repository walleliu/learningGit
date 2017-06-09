//
//  smartCollectionViewCell.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/24.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "smartCollectionViewCell.h"

@implementation smartCollectionViewCell
{
     AFHTTPSessionManager *manager;
    UIButton *addButton;
    UIButton *reduceButton;
    UIImageView *lineImageView;
    
    UILabel *twoButtonLabel;

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        _smartImageView = [UIImageView new];
        _smartImageView.image = [UIImage imageNamed:@"smart_mini_1"];
        [self.contentView addSubview:_smartImageView];
        
        _smartLabel = [UILabel  new];
        _smartLabel.font = [UIFont systemFontOfSize:14];
        _smartLabel.textColor = [UIColor blackColor];
        _smartLabel.text = @"标题标题标题的";
        [self.contentView addSubview:_smartLabel];
        
        
        
        _smartImageView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .centerYEqualToView(self.contentView)
        .widthIs(30)
        .autoHeightRatio(1);
        
        _smartLabel.sd_layout
        .leftSpaceToView(_smartImageView,10)
        .centerYEqualToView(self.contentView)
        .widthIs(115)
        .heightIs(20);
        
    }
    return self;
}
//两个按钮cell
-(void)createTwoButton{
    [self createSwitch];
    reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceButton setBackgroundImage:[UIImage imageNamed:@"action_left_btn1"] forState:UIControlStateNormal];
    [reduceButton addTarget:self action:@selector(TwoReduceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:reduceButton];
    if ([_oldValue integerValue]<= 0) {
        reduceButton.enabled = NO;
    }
    reduceButton.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(_smartLabel,5)
    .widthIs(25)
    .autoHeightRatio(1);
    
    twoButtonLabel = [[UILabel alloc] init];
    twoButtonLabel.text = [NSString stringWithFormat:@"%@%%",_oldValue];
    twoButtonLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:twoButtonLabel];
    
    twoButtonLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(reduceButton, 5)
    .widthIs(40)
    .heightIs(20);
    
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setBackgroundImage:[UIImage imageNamed:@"action_right_btn1"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(TwoAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addButton];
    if ([_oldValue integerValue] >= 100) {
        addButton.enabled = NO;
    }
    addButton.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(_smartSwitch,20)
    .widthIs(25)
    .autoHeightRatio(1);
    
    
    

    
}
//创建switchcell
-(void)createSwitch{
    _smartSwitch = [[SevenSwitch alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width - 50, 16.5, 50, 25)];
    
    
    [_smartSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    _smartSwitch.offImage = @"off";
    _smartSwitch.onImage = @"on";
    _smartSwitch.inactiveColor = [UIColor colorWithRed:198.0/255.0 green:200.0/255.0 blue:205.0/255.0 alpha:1.00f];
    _smartSwitch.onColor = [UIColor colorWithRed:21.0/255.0 green:60.0/255.0 blue:144.0/255.0 alpha:1.0];
    _smartSwitch.isRounded = NO;
    [self.contentView addSubview:_smartSwitch];
    [_smartSwitch setOn:NO animated:YES];
}
//滑动条控件cell
-(void)createSliderView{
    //初始化slider
    
    
    NSMutableArray *mut = [NSMutableArray array];
    for (NSInteger i = 0; i<101; i++) {
        NSString *str =[NSString stringWithFormat:@"%ld%%",(long)i];
        [mut addObject:str];
    }
    NSArray *myArray = [mut copy];
    
    _slider=[[LiuXSlider alloc] initWithFrame:CGRectMake(160, 10, 200 , 25) titles:myArray firstAndLastTitles:nil defaultIndex:0 sliderImage:[UIImage imageNamed:@"action_slider_bg"]];
    _slider.defaultIndx = 0;
    [self.contentView addSubview:_slider];
    __block smartCollectionViewCell *cell = self;
    
    _slider.block=^(int index){
        NSLog(@"当前index==%d",index);
        _value = [NSString stringWithFormat:@"%d",index];

        [cell getSmartCellData];
    };
    
    
    
}
//创建三个按钮的cell
-(void)createthreeButton{
    [self createSwitch];
    UIView *threeView = [UIView new];
    threeView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:threeView];
    
//    lineImageView = [UIImageView new];
//    lineImageView.image = [UIImage imageNamed:@"action_slider_1_bg"];
//    [threeView addSubview:lineImageView];
    _lineButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_lineButton setBackgroundImage:[UIImage imageNamed:@"action_slider_1_bg"] forState:UIControlStateNormal];
    [threeView addSubview:_lineButton];
    _lineButton1 = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_lineButton1 setBackgroundImage:[UIImage imageNamed:@"action_slider_1_bg"] forState:UIControlStateNormal];
    [threeView addSubview:_lineButton1];
    
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
    .leftSpaceToView(_smartLabel,0)
    .rightSpaceToView(_smartSwitch,0);
    
    
    
    _leftButton.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(threeView,10)
    .widthIs(25)
    .autoHeightRatio(1);
    
    _lineButton.sd_layout
    .leftSpaceToView(_leftButton,0)
    .rightSpaceToView(_centerButton,0)
    .heightIs(2)
    .centerYEqualToView(self.contentView);
    
    _centerButton.sd_layout
    .centerYEqualToView(self.contentView)
    .centerXEqualToView(threeView)
    .widthIs(25)
    .autoHeightRatio(1);
    
    _lineButton1.sd_layout
    .leftSpaceToView(_centerButton,0)
    .rightSpaceToView(_rightButton,-0.5)
    .heightIs(2)
    .centerYEqualToView(self.contentView);
    
    _rightButton.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(threeView,10)
    .widthIs(25)
    .autoHeightRatio(1);
    
    
    


    
}
- (void)changeSelectedObject:(UIButton *)sender{
    _tempButton.selected = NO;
    _tempButton = sender;
    _tempButton.selected = YES;
    //    _moneyLabel.text = _tempButton.currentTitle;
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
//两个按钮的左边按钮方法
-(void)TwoReduceButtonAction:(UIButton *)button{
    NSLog(@"向左移");
    _value = [NSString stringWithFormat:@"%d",[_oldValue integerValue] - 10];
    if ([_value integerValue] < 100) {
        addButton.enabled = YES;
    }
    
    if ([_value integerValue] < 0) {
        _oldValue = @"0";
        _value = @"0";
        reduceButton.enabled = NO;
        [self.smartSwitch setOn:NO];
        
    }else if([_value integerValue] == 0){
        reduceButton.enabled = NO;
        [self.smartSwitch setOn:NO];
        
    }
    [self getSmartCellData];

    
}
//两个按钮的右边按钮方法
-(void)TwoAddButtonAction:(UIButton *)button{
    NSLog(@"向右移");
    _value = [NSString stringWithFormat:@"%d",[_oldValue integerValue] + 10];
    if ([_value integerValue] > 0) {
        reduceButton.enabled = YES;
        [self.smartSwitch setOn:YES];
    }
    if ([_value integerValue] > 100) {
        _oldValue = @"100";
        _value = @"100";
        addButton.enabled = NO;
    }else
    if ([_value integerValue] == 100) {
        addButton.enabled = NO;
        [self getSmartCellData];
    }else{
        [self getSmartCellData];
    }
    
    
}
//switch 开关方法
- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
    if (_cellType == 2){
        //两个按钮
        if (sender.on) {
            _value = @"100";
            reduceButton.enabled = YES;
        }else{
            _value = @"0";
            reduceButton.enabled = NO;
        }
    }else if (_cellType == 4){
        //只有switch
        if (sender.on) {
            _value = @"1";
        }else{
            _value = @"0";
        }
    }else if(_cellType == 5){
        //三个按钮
        if (sender.on) {
            _value = @"34";
            _centerButton.selected = YES;
            _leftButton.selected = NO;
            _rightButton.selected = NO;
            
            _centerButton.enabled = YES;
            _leftButton.enabled = YES;
            _rightButton.enabled = YES;
            _lineButton1.enabled = YES;
            _lineButton.enabled = YES;
        }else{
            _value = @"68";
            _centerButton.selected = NO;
            _leftButton.selected = NO;
            _rightButton.selected = NO;
            
            
            _centerButton.enabled = NO;
            _leftButton.enabled = NO;
            _rightButton.enabled = NO;
            _lineButton1.enabled = NO;
            _lineButton.enabled = NO;
        }
    }
    [self getSmartCellData];
    
}
-(void)allButtonEnabledWith:(BOOL)buttonBoll{
    switch (_cellType) {
        case 2:
            //reduceButton.enabled = buttonBoll;
            //addButton.enabled = buttonBoll;
            _smartSwitch.enabled = buttonBoll;
            break;
        case 3:
            _slider.enabled = buttonBoll;
            break;
        case 4:
            _smartSwitch.enabled = buttonBoll;
            break;
        case 5:
//            _leftButton.enabled = buttonBoll;
//            _centerButton.enabled = buttonBoll;
//            _rightButton.enabled = buttonBoll;
//            _smartSwitch.enabled = buttonBoll;
//            _lineButton.enabled = buttonBoll;
//            _lineButton1.enabled = buttonBoll;
            break;
            
        default:
            break;
    }
    
}
#pragma mark  getData
-(void)getSmartCellData{
    [self allButtonEnabledWith:NO];
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    
    if ([projectIP isEqualToString:@"http://(null)"]|| projectIP.length < 8) {
       // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入ip地址" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        //[alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        //[alert show];
    }else{
        NSString *urlStr =
        [projectIP stringByAppendingString:@":8000/api/control"];
        //        [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_deviceID forKey:@"device"];
        [params setObject:_value forKey:@"value"];
        manager = [DNSRequestData requestURL:urlStr httpMethod:@"GET" params:params file:nil progress:^(NSProgress *loadProgress) {
            NSLog(@"/api/controlProgress:%@",loadProgress);
        } success:^(id data) {
            [self allButtonEnabledWith:YES];
            NSLog(@"/api/controlSuccess:%@",data);
            
            if ([data allKeys].count == 1) {
                NSLog(@"控制失败");
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"远程控制失败" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"取消", nil]show];
            }else{
                _oldValue = _value;
                if (_cellType == 2) {
                    twoButtonLabel.text = [NSString stringWithFormat:@"%@%%",_oldValue];
                }
            }
            
            
        } fail:^(NSError *error) {
            [self allButtonEnabledWith:YES];
            NSLog(@"/api/controlFail:%@",error);
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"远程控制失败" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"取消", nil]show];
        }];
    }

    
    
    
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
    if (_cellType == 2) {
        //两个按钮
//        _slider.defaultIndx = [_value integerValue];
        if ([_value integerValue]<=0) {
            reduceButton.enabled = NO;
        }else if([_value integerValue] > 0 && [_value integerValue] < 100){
            reduceButton.enabled = YES;
            addButton.enabled = YES;
        }else if([_value integerValue] >= 100){
            addButton.enabled = NO;
        }
        if ([_value integerValue] == 0) {
            [self.smartSwitch setOn:NO];
        }else{
            [self.smartSwitch setOn:YES];
        }
        twoButtonLabel.text = [NSString stringWithFormat:@"%@%%",_oldValue];
    }else if (_cellType == 3) {
        //滑动条
        _slider.defaultIndx = [_value integerValue];
        if ([_value integerValue] == 0) {
            [self.smartSwitch setOn:NO];
        }else{
            [self.smartSwitch setOn:YES];
        }
    }else if(_cellType == 5){
        //三个按钮
        if ([_value integerValue] == 17) {
            _leftButton.selected = YES;
            _centerButton.selected = NO;
            _rightButton.selected = NO;
            [self.smartSwitch setOn:YES];
            
            _centerButton.enabled = YES;
            _leftButton.enabled = YES;
            _rightButton.enabled = YES;
            _lineButton1.enabled = YES;
            _lineButton.enabled = YES;
        }else if([_value integerValue] == 34){
            _leftButton.selected = NO;
            _centerButton.selected = YES;
            _rightButton.selected = NO;
            [self.smartSwitch setOn:YES];
            
            _centerButton.enabled = YES;
            _leftButton.enabled = YES;
            _rightButton.enabled = YES;
            _lineButton1.enabled = YES;
            _lineButton.enabled = YES;
        }else if([_value integerValue] == 51){
            _leftButton.selected = NO;
            _centerButton.selected = NO;
            _rightButton.selected = YES;
            [self.smartSwitch setOn:YES];
            
            _centerButton.enabled = YES;
            _leftButton.enabled = YES;
            _rightButton.enabled = YES;
            _lineButton1.enabled = YES;
            _lineButton.enabled = YES;
        }
        else if([_value integerValue] == 68){
            
            _centerButton.enabled = NO;
            _leftButton.enabled = NO;
            _rightButton.enabled = NO;
            _lineButton1.enabled = NO;
            _lineButton.enabled = NO;
            
            _leftButton.selected = NO;
            _centerButton.selected = NO;
            _rightButton.selected = NO;
            _smartSwitch.on = NO;
            [self.smartSwitch setOn:NO];
        }
    }else if(_cellType == 4){
        //只有switch
        if ([_value integerValue] == 0) {
            _smartSwitch.on  = NO;
        }else{
            _smartSwitch.on = YES;
        }
    }
}
@end
