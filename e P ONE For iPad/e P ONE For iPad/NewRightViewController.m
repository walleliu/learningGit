//
//  NewRightViewController.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/22.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "NewRightViewController.h"
#import "UIView+SDAutoLayout.h"
@interface NewRightViewController ()
{
    NSMutableArray *historyModelArr;//model 数组
    NSInteger initArrCount;
    
    NSMutableArray *valueArr;//数值
}
@end

@implementation NewRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [_customLab setTextColor:[UIColor blackColor]];
    [_customLab setText:@"区域名称"];
    _customLab.textAlignment = NSTextAlignmentCenter;
    _customLab.font = [UIFont boldSystemFontOfSize:19];
    self.navigationItem.titleView = _customLab;
    self.navigationController.navigationBar.translucent = NO;
    self.type = 3;
    [self createScrollView];
    [self createSevenView];
    [self createBarView];
    [self createSmartTableView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(sendNSNotification)];
    self.navigationItem.rightBarButtonItem = item;
    // Do any additional setup after loading the view from its nib.
}
-(void)sendNSNotification{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"getListData" object:_cellIndexpathRow userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}
//创建UIScrollView
-(void)createScrollView{
    //    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    //    naView.backgroundColor = BACK_BLUE_COLOR;
    // 1.创建UIScrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    // 隐藏水平滚动条
//    _scrollView.contentSize.height = 0;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    //    [self.view addSubview:naView];
    _scrollView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
}

//创建7个进度条
-(void)createSevenView{
    _headView = [[UIView alloc] init];
    _headView.backgroundColor = [UIColor clearColor];
    _headView.tag = 789;
    [_scrollView addSubview:_headView];
    _headView.sd_layout
    .topSpaceToView(_scrollView, 0)
    .leftSpaceToView(_scrollView, 0)
    .rightSpaceToView(_scrollView, 0)
    .heightIs(120);
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = [UIColor grayColor];
//    [_headView addSubview:lineView];
//    lineView.sd_layout
//    .leftSpaceToView(_headView, 20)
//    .rightSpaceToView(_headView, 0)
//    .bottomSpaceToView(_headView, 0)
//    .heightIs(1);
    
    UIColor *tempColor= [self getColorWithType:3 Value:[_areaModel.temp integerValue]];
    UIColor *humiColor= [self getColorWithType:4 Value:[_areaModel.humi integerValue]];
    UIColor *hchoColor= [self getColorWithType:5 Value:[_areaModel.hcho integerValue]];
    UIColor *co2Color= [self getColorWithType:6 Value:[_areaModel.co2 integerValue]];
    UIColor *vocColor= [self getColorWithType:7 Value:[_areaModel.voc integerValue]];
    UIColor *pm25Color= [self getColorWithType:1 Value:[_areaModel.pm25 integerValue]];
    UIColor *pm10Color= [self getColorWithType:2 Value:[_areaModel.pm10 integerValue]];
    
    
    self.tempPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:_areaModel.tempPercent andColor:tempColor andTitle:@"TEMP" andNumStr:[NSString stringWithFormat:@"%@ ℃",_areaModel.temp] andTextColor:[UIColor blackColor] ];
    [_headView addSubview:self.tempPieView];
    UITapGestureRecognizer *tempPieViewTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tempPieViewAction)];
    [self.tempPieView addGestureRecognizer:tempPieViewTap];
    
    self.humiPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:_areaModel.humiPercent andColor:humiColor andTitle:@"HUMI" andNumStr:[NSString stringWithFormat:@"%@ %%RH",_areaModel.humi ]andTextColor:[UIColor blackColor]];
    [_headView addSubview:self.humiPieView];
    UITapGestureRecognizer *humiPieViewTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(humiPieViewAction)];
    [self.humiPieView addGestureRecognizer:humiPieViewTap];
    
    self.hchoPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:_areaModel.hchoPercent andColor:hchoColor andTitle:@"HCHO" andNumStr:[NSString stringWithFormat:@"%@ ppb",_areaModel.hcho]andTextColor:[UIColor blackColor]];
    [_headView addSubview:self.hchoPieView];
    UITapGestureRecognizer *hchoPieViewTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hchoPieViewAction)];
    [self.hchoPieView addGestureRecognizer:hchoPieViewTap];
    
    self.co2PieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:_areaModel.co2Percent andColor:co2Color andTitle:@"CO₂" andNumStr:[NSString stringWithFormat:@"%@ ppm",_areaModel.co2]andTextColor:[UIColor blackColor]];
    [_headView  addSubview:self.co2PieView];
    UITapGestureRecognizer *co2PieViewTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(co2PieViewAction)];
    [self.co2PieView addGestureRecognizer:co2PieViewTap];
    
    self.vocPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:_areaModel.vocPercent andColor:vocColor andTitle:@"VOC" andNumStr:[NSString stringWithFormat:@"%@ level",_areaModel.voc]andTextColor:[UIColor blackColor]];
    [_headView addSubview:self.vocPieView];
    UITapGestureRecognizer *vocPieViewTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vocPieViewAction)];
    [self.vocPieView addGestureRecognizer:vocPieViewTap];
    
    self.pm25PieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:_areaModel.pm25Percent andColor:pm25Color andTitle:@"PM2.5" andNumStr:[NSString stringWithFormat:@"%@ ug/m³",_areaModel.pm25]andTextColor:[UIColor blackColor]];
    [_headView addSubview:self.pm25PieView];
    UITapGestureRecognizer *pm25PieViewTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pm25PieViewAction)];
    [self.pm25PieView addGestureRecognizer:pm25PieViewTap];
    
    self.pm10PieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:_areaModel.pm10Percent  andColor:pm10Color andTitle:@"PM10" andNumStr:[NSString stringWithFormat:@"%@ ug/m³",_areaModel.pm10]andTextColor:[UIColor blackColor]];
    [_headView addSubview:self.pm10PieView];
    UITapGestureRecognizer *pm10PieViewTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pm10PieViewAction)];
    [self.pm10PieView addGestureRecognizer:pm10PieViewTap];
    
    
    _headView.sd_equalWidthSubviews = @[self.tempPieView, self.humiPieView,self.hchoPieView,self.co2PieView,self.vocPieView,self.pm25PieView,self.pm10PieView];
    
    self.tempPieView.sd_layout
    .leftSpaceToView(_headView, 20)
    .topSpaceToView(_headView, 20)
    .autoHeightRatio(1);
    
    self.humiPieView.sd_layout
    .leftSpaceToView(self.tempPieView, 20)
    .topEqualToView(self.tempPieView)
    .heightRatioToView(self.tempPieView, 1);
    
    self.hchoPieView.sd_layout
    .leftSpaceToView(self.humiPieView, 20)
    .topEqualToView(self.tempPieView)
    .heightRatioToView(self.tempPieView, 1);
    
    self.co2PieView.sd_layout
    .leftSpaceToView(self.hchoPieView, 20)
    .topEqualToView(self.tempPieView)
    .heightRatioToView(self.tempPieView, 1);
    
    self.vocPieView.sd_layout
    .leftSpaceToView(self.co2PieView, 20)
    .topEqualToView(self.tempPieView)
    .heightRatioToView(self.tempPieView, 1);
    
    self.pm25PieView.sd_layout
    .leftSpaceToView(self.vocPieView, 20)
    .topEqualToView(self.tempPieView)
    .heightRatioToView(self.tempPieView, 1);
    
    self.pm10PieView.sd_layout
    .leftSpaceToView(self.pm25PieView, 20)
    .rightSpaceToView(_headView, 20)
    .topEqualToView(self.tempPieView)
    .heightRatioToView(self.tempPieView, 1);
    
    
}
- (void)tempPieViewAction{
    _type = 3;
    
    
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    if ([projectIP isEqualToString:@"http://210.13.100.190"]) {
        [_MCBarView removeFromSuperview];
    }else{
        [_MCBarView removeFromSuperview];
        [self createBarView];
    }
    
}
- (void)humiPieViewAction{
    _type = 4;
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    if ([projectIP isEqualToString:@"http://210.13.100.190"]||[_areaModel.humi integerValue] == 0) {
        [_MCBarView removeFromSuperview];
    }else{
        [_MCBarView removeFromSuperview];
        [self createBarView];
    }
}
- (void)hchoPieViewAction{
    _type = 5;
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    if ([projectIP isEqualToString:@"http://210.13.100.190"]||[_areaModel.hcho integerValue] == 0) {
        [_MCBarView removeFromSuperview];
    }else{
        [_MCBarView removeFromSuperview];
        [self createBarView];
    }
}
- (void)co2PieViewAction{
    _type = 6;
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    if ([projectIP isEqualToString:@"http://210.13.100.190"]||[_areaModel.co2 integerValue] == 0) {
        [_MCBarView removeFromSuperview];
    }else{
        [_MCBarView removeFromSuperview];
        [self createBarView];
    }
}
- (void)vocPieViewAction{
    _type = 7;
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    if ([projectIP isEqualToString:@"http://210.13.100.190"]||[_areaModel.voc integerValue] == 0) {
        [_MCBarView removeFromSuperview];
    }else{
        [_MCBarView removeFromSuperview];
        [self createBarView];
    }
}
- (void)pm25PieViewAction{
    _type = 1;
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    if ([projectIP isEqualToString:@"http://210.13.100.190"]||[_areaModel.pm25 integerValue] == 0) {
        [_MCBarView removeFromSuperview];
    }else{
        [_MCBarView removeFromSuperview];
        [self createBarView];
    }
}
- (void)pm10PieViewAction{
    _type = 2;
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    if ([projectIP isEqualToString:@"http://210.13.100.190"]||[_areaModel.pm10 integerValue] == 0) {
        [_MCBarView removeFromSuperview];
    }else{
        [_MCBarView removeFromSuperview];
        [self createBarView];
    }
}

//创建柱形图
-(void)createBarView{
    _MCBarView = [[UIView alloc] init];
    _MCBarView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_MCBarView];
    _MCBarView.sd_layout
    .topSpaceToView(_scrollView, 120)
    .leftSpaceToView(_scrollView, 0)
    .rightSpaceToView(_scrollView, 0)
    .heightIs(200);
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    [_MCBarView addSubview:lineView];
    lineView.sd_layout
    .leftSpaceToView(_MCBarView, 0)
    .rightSpaceToView(_MCBarView, 0)
    .bottomSpaceToView(_MCBarView, 0)
    .heightIs(1);

    historyModelArr =[NSMutableArray array];
    valueArr = [NSMutableArray array];
    initArrCount = 32;
    for (int i  = 0; i < initArrCount; i++) {
        [valueArr addObject:@0];
        [historyModelArr addObject:@0];
    }
    NSString *titleStr;
    NSMutableArray *dataArr = [NSMutableArray array];
    UILabel *titleLable1 = [[UILabel alloc] init];
    switch (_type) {
        case 1:
            titleStr = @"PM2.5颗粒物 ug/m³";
            titleLable1.text = @"PM2.5";
            dataArr = _pm25DetailArr;
            break;
        case 2:
            titleStr = @"PM10颗粒物 ug/m³";
            titleLable1.text = @"PM10";
            dataArr = _pm10DetailArr;
            break;
        case 3:
            titleStr = @"温度 ℃";
            titleLable1.text = @"TEMP";
            dataArr = _tempDetailArr;
            break;
        case 4:
            titleStr = @"湿度 %RH";
            titleLable1.text = @"HUMI";
            dataArr = _humiDetailArr;
            break;
        case 5:
            titleStr = @"甲醛 ppb";
            titleLable1.text = @"HCHO";
            dataArr = _hchoDetailArr;
            break;
        case 6:
            titleStr = @"二氧化碳 ppm";
            titleLable1.text = @"CO₂";
            dataArr = _co2DetailArr;
            break;
        case 7:
            titleStr = @"挥发性有机物 level";
            titleLable1.text = @"VOC";
            dataArr = _vocDetailArr;
            break;
        default:
            break;
    }

    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 20)];
    titleLable.text = titleStr;
    [titleLable sizeToFit];
    titleLable.textColor = [UIColor blackColor];
    [self.MCBarView addSubview:titleLable];
   
    titleLable1.textColor = [UIColor blackColor];
    titleLable1.font = [UIFont systemFontOfSize:12];
    [self.MCBarView addSubview:titleLable1];
    
    //    titleLable.sd_layout
//    .topSpaceToView(self.MCBarView, 0)
//    .leftSpaceToView(self.MCBarView, 20)
////    .autoHeightRatio(0)
//    .heightIs(250);
//    [titleLable sizeToFit];
    titleLable1.sd_layout
    .topSpaceToView(self.MCBarView, 0)
    .leftSpaceToView(titleLable, 10)
    .widthIs(80)
    .heightIs(20);
    
    
    for (NSMutableDictionary *detailDic in dataArr) {
        NSString *valueStr = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"avg_percent"]];
        NSNumber *number = [NSNumber new];
        number = [NSNumber numberWithFloat:[valueStr floatValue]];
        [valueArr addObject:number];
        
        HistoryModel *historyModel = [[HistoryModel alloc] init];
        historyModel.avg_percent = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"avg_percent"]];
        historyModel.avg_value = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"avg_value"]];
        historyModel.time = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"time"]];
        historyModel.time1 = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"time1"]];
        historyModel.time2 = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"time2"]];
        historyModel.isShowLine = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"bool"]];
        [historyModelArr addObject:historyModel];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createBarChartView];
    });
}
#pragma mark 柱形图
-(void)createBarChartView{
    
    
    
    NSArray *titleArr=[self getYTitleArr];
    
    
    _dataSource = valueArr;
    _barChartView = [[MCBarChartView alloc] initWithFrame:CGRectMake(0, 10, _MCBarView.size.width-40, 190)];
    _barChartView.yArr = [NSMutableArray arrayWithArray:titleArr];
    _barChartView.tag = 111;
    
    _barChartView.historyModelArray = historyModelArr;
    _barChartView.numberOfYAxis =[titleArr count] - 1;
    _barChartView.initArrCount= initArrCount;
    _barChartView.dataSource = self;
    _barChartView.delegate = self;
    _barChartView.type = _type;
    _barChartView.maxValue = @100;
    _barChartView.isBusiness = 1;
    //    _barChartView.unitOfYAxis = @"分";
    _barChartView.colorOfXAxis = [UIColor blackColor];
    _barChartView.colorOfXText = [UIColor blackColor];
    _barChartView.colorOfYAxis = [UIColor blackColor];
    _barChartView.colorOfYText = [UIColor blackColor];
    
    [self.MCBarView addSubview:_barChartView];
    
    [_barChartView reloadData];
    
    _barChartView.sd_layout
    .topSpaceToView(self.MCBarView,10)
    .leftSpaceToView(self.MCBarView,20)
    .rightSpaceToView(self.MCBarView,20)
    .heightIs(190);
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma -mcbarchartviewDelegate
//有几组
- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView {
    //    if (barChartView.tag == 111) {
    return [_dataSource count];
    //    }
    
}


//每组里有几个柱形图
- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section {
    
    return 1;
    
}

//柱形图高度值
- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index {
    return _dataSource[section];
    
}
//柱形图颜色
- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index {
    if (section > initArrCount-1) {
        HistoryModel *historyModel  = [historyModelArr objectAtIndex:section];
        NSInteger s = [historyModel.avg_value integerValue];
        return [self getColorWithType:_type Value:s];
    }else{
        return nil;
    }
}

//x轴文字内容
- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section {
    if (section== [_dataSource count]- 1) {
        //        loadingLabel.hidden = YES;
        //        [self sevenButtonEnabledWitheType:YES];
    }
    return @"";
}
//柱形图上方显示的view
- (NSString *)barChartView:(MCBarChartView *)barChartView informationOfBarInSection:(NSInteger)section index:(NSInteger)index {
    if (barChartView.tag == 111) {
        switch (_type) {
            case 1:
                return @"PM2.5=";
                break;
            case 2:
                return @"PM10=";
            case 3:
                return @"TEMP=";
                break;
            case 4:
                return @"HUMI=";
                break;
            case 5:
                return @"HCHO=";
                break;
            case 6:
                return @"CO₂=";
                break;
            case 7:
                return @"VOC=";
                break;
                
                break;
            default:
                return @"";
                break;
        }
    }
    return nil;
    
}
//宽度
- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView {
    return 7.5;
    
}
//间隔
- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView {
    
    return 2;
    
}
//返回Y轴标题数组
-(NSArray *)getYTitleArr{
    NSArray *titleArr = [NSMutableArray array];
    switch (_type) {
        case 1:
            titleArr=@[@" 0 ",@" 35 ",@" 75 ",@" 115 ",@" 150 ",@" 250 ",@" 500 "];
            break;
        case 2:
            titleArr=@[@" 0 ",@" 50 ",@" 150 ",@" 250 ",@" 350 ",@" 420 ",@" 600 "];
            break;
        case 3:
            titleArr=@[@" -10 ",@" 0 ",@" 10 ",@" 20 ",@" 30 ",@" 40 ",@" 50 "];
            break;
        case 4:
            titleArr=@[@" 0 ",@" 20 ",@" 40 ",@" 60 ",@" 80 ",@" 100 "];
            break;
        case 5:
            titleArr=@[@" 0 ",@" 100 ",@" 200 ",@" 300 ",@" 400 ",@" 500 "];
            break;
        case 6:
            titleArr=@[@" 0 ",@" 1000 ",@" 2000 ",@" 3000 ",@" 4000 ",@" 5000 "];
            break;
        case 7:
            titleArr=@[@" 0 ",@" 1 ",@" 2 ",@" 3 ",@" 4 ",@" 5 "];
            break;
            
        default:
            break;
    }
    
    return titleArr;
}

//返回颜色
-(UIColor *)getColorWithType:(NSInteger)dataType Value:(CGFloat)value{
    
    //3 TEMP ,4 HUMI ,5 HCHO ,6 CO2 ,7 VOC, 1 PM2.5 ,2 PM10 ,
    UIColor *color ;
    UIColor *color1 = [UIColor colorWithRed:54.0/255.0 green:188.0/255.0 blue:74.0/255.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:178.0/255.0 green:190.0/255.0 blue:30.0/255.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:244.0/255.0 green:149.0/255.0 blue:45.0/255.0 alpha:1];
    UIColor *color4 = [UIColor colorWithRed:254.0/255.0 green:48.0/255.0 blue:33.0/255.0 alpha:1];
    UIColor *color5 = [UIColor colorWithRed:164.0/255.0 green:44.0/255.0 blue:176.0/255.0 alpha:1];
    UIColor *color6 = [UIColor colorWithRed:56.0/255.0 green:0.0 blue:56.0/255.0 alpha:1];
    
     UIColor *color7 = [UIColor colorWithRed:225.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:1];//灰色
    switch (dataType) {
        case 1:
            //            1 PM2.5
            if(value == 0){
                color = color7;
            }else if (value > 0 && value < 35) {
                color = color1;
            }else if(value >= 35 && value < 75){
                color = color2;
            }else if(value >= 75 && value < 115){
                color = color3;
            }else if(value >= 115 && value < 150){
                color = color4;
            }else if(value >= 150 && value < 250){
                color = color5;
            }else if(value >= 250 && value < 500){
                color = color6;
            }else{
                color = color6;
            }
            break;
        case 2:
            //            2 PM10
            if(value == 0){
                color = color7;
            }else if (value > 0 && value <= 50) {
                color = color1;
            }else if(value > 50 && value <= 100){
                color = color2;
            }else if(value >100 && value <= 200){
                color = color3;
            }else if(value > 200 && value <= 300){
                color = color4;
            }else if(value > 300){
                color = color5;
            }else{
                color = color6;
            }
            break;
        case 3:
            //3 TEMP
            if (value >= -10 && value < 0) {
                color = color6;
            }else if(value >= 0 && value < 10){
                color = color5;
            }else if (value >= 10 && value < 15){
                color = color4;
            }else if (value >= 15 && value <20){
                color = color3;
            }else if (value >= 20 && value <24){
                color = color2;
            }else if (value >= 24 && value <28){
                color = color1;
            }else if (value >= 28 && value <32){
                color = color2;
            }else if (value >= 32 && value <35){
                color = color3;
            }else if (value >= 35 && value <40){
                color = color5;
            }else if (value >= 40 && value <50){
                color = color6;
            }else{
                color = color6;
            }
            
            break;
        case 4:
            //4 HUMI
            if(value == 0){
                color = color7;
            }else if (value > 0 && value < 20) {
                color = color4;
            }else if(value >= 20 && value < 45){
                color = color3;
            }else if(value >= 45 && value < 65){
                color = color1;
            }else if(value >= 65 && value < 75){
                color = color2;
            }else if(value >= 75 && value < 80){
                color = color3;
            }else if(value >= 80 && value < 90){
                color = color4;
            }else if(value >= 90 && value < 100){
                color = color5;
            }else{
                color = color6;
            }
            break;
        case 5:
            //            5 HCHO
            if(value == 0){
                color = color7;
            }else if (value > 0 && value < 100) {
                color = color1;
            }else if(value >= 100 && value < 200){
                color = color2;
            }else if(value >= 200 && value < 300){
                color = color3;
            }else if(value >= 300 && value < 400){
                color = color4;
            }else if(value >= 400 && value < 500){
                color = color5;
            }else{
                color = color6;
            }
            break;
        case 6:
            //            6 CO2
            if(value == 0){
                color = color7;
            }else if (value > 0 && value < 350) {
                color = color1;
            }else if(value >= 350 && value < 450){
                color = color1;
                
            }else if(value >= 450 && value < 1000){
                color = color2;
                
            }else if(value >= 1000 && value < 2000){
                color = color3;
                
            }else if(value >= 2000 && value < 5000){
                color = color4;
                
            }else if(value >= 5000){
                color = color5;
                //                color = [UIColor colorWithRed:56.0/255.0 green:0.0 blue:56.0/255.0 alpha:1];
            }else{
                color = color6;
            }
            break;
        case 7:
            //            7 VOC
            if(value == 0){
                color = color7;
            }else if (value > 0 && value <= 1) {
                color = color1;
            }else if(value > 1 && value <= 2){
                color = color2;
            }else if(value > 2 && value <= 3){
                color = color3;
            }else if(value > 3 && value <= 4){
                color = color4;
            }else if(value > 4 && value <= 5){
                color = color5;
            }else if(value > 5){
                color = color6;
            }else{
                color = color6;
            }
            break;
            
            
            
        default:
            break;
    }
    
    
    return color;
    
}
#pragma mark 创建远程控制View
-(void)createSmartTableView{
    _smartView = [[UIView alloc] init];
    _smartView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_smartView];
//    _smartModelArr= [NSMutableArray array];
    _smartView.sd_layout
    .topSpaceToView(_scrollView, 320)
    .leftSpaceToView(_scrollView, 0)
    .rightSpaceToView(_scrollView, 0)
    .bottomSpaceToView(_scrollView, 10);
    
    if (_headView == nil) {
        _smartView.sd_layout
        .topSpaceToView(_scrollView, 0);
    }
//    [_scrollView setupAutoContentSizeWithBottomView:_smartView bottomMargin:10];
    
    
    UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init ];
    layout.itemSize = CGSizeMake(self.view.frame.size.width - 40 / 3, self.view.frame.size.height/2);
    _CenterCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 3 - 20, self.view.frame.size.width, self.view.frame.size.height / 3 + 20) collectionViewLayout:layout];
    
//    [_CenterCollection registerClass :[smartCollectionViewCell class ] forCellWithReuseIdentifier : @"cell" ];
    _CenterCollection.backgroundColor = [UIColor clearColor];
    _CenterCollection.delegate = self;
    _CenterCollection.dataSource = self;
    
    [_smartView addSubview:_CenterCollection];
    _CenterCollection.sd_layout
    .topSpaceToView(_smartView, 0)
    .leftSpaceToView(_smartView, 0)
    .rightSpaceToView(_smartView, 0)
    .bottomSpaceToView(_smartView, 0);
    
    
//    _smartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
//    _smartTableView.delegate = self;
//    _smartTableView.dataSource = self;
//    _smartTableView.backgroundColor = [UIColor clearColor];
//    [_smartTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_smartView  addSubview:_smartTableView];
//    _smartTableView.sd_layout
//    .topSpaceToView(_smartView, 0)
//    .leftSpaceToView(_smartView, 0)
//    .rightSpaceToView(_smartView, 0)
//    .bottomSpaceToView(_smartView, 0);
    
}
#pragma -collectionDelegate

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,20,20,20);
}

//- collectionv
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(_smartView.frame.size.width / 2 - 40, 60);

    
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SmartModel *smartMod = [_smartModelArr objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    [_CenterCollection registerClass :[smartCollectionViewCell class ] forCellWithReuseIdentifier : cellIdentifier];
    smartCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier : cellIdentifier  forIndexPath :indexPath];
    NSString *imageNameStr = [NSString stringWithFormat:@"smart_mini_%@",smartMod.category];
    cell.smartImageView.image = [UIImage imageNamed:imageNameStr];
    cell.smartLabel.text = smartMod.name;
    cell.cellType = [smartMod.ctltype integerValue];
    cell.oldValue =smartMod.ctldata;
    cell.deviceID = smartMod.ID;

    switch ([smartMod.ctltype integerValue]) {
        case 3://滑动条
            [cell createSliderView];
            cell.slider.defaultIndx =[smartMod.ctldata integerValue];
            break;
        case 4://只有switch
            [cell createSwitch];
            if ([smartMod.ctldata integerValue] == 0) {
                cell.smartSwitch.on  = NO;
            }else{
                cell.smartSwitch.on = YES;
            }
            break;
        case 2://两个按钮
            [cell createTwoButton];
            if ([smartMod.ctldata integerValue] == 0) {
                cell.smartSwitch.on  = NO;
            }else{
                cell.smartSwitch.on = YES;
            }
            break;
        case 5://三个按钮
            [cell createthreeButton];
            if ([smartMod.ctldata integerValue] == 17) {
                cell.leftButton.selected = YES;
                cell.centerButton.selected = NO;
                cell.rightButton.selected = NO;
                cell.smartSwitch.on = YES;
            }else if([smartMod.ctldata integerValue] == 34){
                cell.leftButton.selected = NO;
                cell.centerButton.selected = YES;
                cell.rightButton.selected = NO;
                cell.smartSwitch.on = YES;
            }else if([smartMod.ctldata integerValue] == 51){
                cell.leftButton.selected = NO;
                cell.centerButton.selected = NO;
                cell.rightButton.selected = YES;
                cell.smartSwitch.on = YES;
            }
            else if([smartMod.ctldata integerValue] == 68){
                cell.leftButton.selected = NO;
                cell.centerButton.selected = NO;
                cell.rightButton.selected = NO;
                cell.smartSwitch.on = NO;
                cell.centerButton.enabled = NO;
                cell.leftButton.enabled = NO;
                cell.rightButton.enabled = NO;
                cell.lineButton1.enabled = NO;
                cell.lineButton.enabled = NO;
            }
            
            break;
            
        default:
            break;
    }

//    cell = [[smartCollectionViewCell alloc] initWithType:indexPath.row];

    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _smartModelArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
}

//#pragma mark uitableviewDelegate
////设置section表头内容
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    return @"";
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//
//    return 80;
//   
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 0.01f;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01f;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return 10;
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
////cell点击事件
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellname = @"cellname6";
//    SmartSecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellname];
//    //     cell.smartType = indexPath.row + 1;
//    //    SmartModel *smartModel = [SmartArray objectAtIndex:indexPath.row];
//    if(!cell){
//        
//        cell = [[SmartSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname smatrType:indexPath.row];
//    }
//    
//    //    cell.smartLabel.text = [NSString stringWithFormat:@"%@",smartModel.name];
//    //    if ([smartModel.ctldata integerValue] == 0) {
//    //        cell.smartSwitch.on  = NO;
//    //    }else{
//    //        cell.smartSwitch.on = YES;
//    //    }
//    //    cell.slider.defaultIndx =[smartModel.ctldata integerValue];
//    //    cell.smartImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"smart_mini_%@",smartModel.category]];
//    //    cell.smartType = [smartModel.ctltype integerValue];
//    //    cell.deviceID = smartModel.ID;
//    //    cell.leftButton.selected = YES;
//    
//    //    if ([smartModel.ctltype integerValue] == 5) {
//    //        cell.oldValue =smartModel.ctldata;
//    //        if ([smartModel.ctldata integerValue] == 17) {
//    //
//    //            cell.leftButton.selected = YES;
//    //            cell.centerButton.selected = NO;
//    //            cell.rightButton.selected = NO;
//    //        }else if([smartModel.ctldata integerValue] == 34){
//    //
//    //            cell.leftButton.selected = NO;
//    //            cell.centerButton.selected = YES;
//    //            cell.rightButton.selected = NO;
//    //        }else if([smartModel.ctldata integerValue] == 51){
//    //
//    //            cell.leftButton.selected = NO;
//    //            cell.centerButton.selected = NO;
//    //            cell.rightButton.selected = YES;
//    //        }
//    //        else if([smartModel.ctldata integerValue] == 68){
//    //
//    //            cell.leftButton.selected = NO;
//    //            cell.centerButton.selected = NO;
//    //            cell.rightButton.selected = NO;
//    //            cell.smartSwitch.on = NO;
//    //        }
//    //    }
//    //    cell.ip = ip;
//    cell.backgroundColor = [UIColor clearColor];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    
//    return cell;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
