//
//  otherTableViewCell.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/10.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "otherTableViewCell.h"

@implementation otherTableViewCell
{
    NSMutableArray *historyModelArr;//model 数组
    NSInteger initArrCount;
    
    NSMutableArray *valueArr;//数值
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDataType:(NSInteger)dataType withCellArr:(NSMutableArray *)cellArr{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.type = dataType;
        historyModelArr =[NSMutableArray array];
        valueArr = [NSMutableArray array];
        initArrCount = 32;
        for (int i  = 0; i < initArrCount; i++) {
            [valueArr addObject:@0];
            [historyModelArr addObject:@0];
        }
        for (NSMutableDictionary *detailDic in cellArr) {
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
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.textColor = [UIColor colorWithRed:140/255.0 green:177/255.0 blue:66/255.0 alpha:1.0];
        [self.contentView addSubview:titleLable];
        switch (dataType) {
            case 1:
                titleLable.text = @"PM2.5颗粒物 ug/m³ PM2.5";
                break;
            case 2:
                titleLable.text = @"PM10颗粒物 ug/m³ PM10";
                break;
            case 3:
                titleLable.text = @"温度 ℃ TEMP";
                break;
            case 4:
                titleLable.text = @"湿度 %RH HUMI";
                break;
            case 5:
                titleLable.text = @"甲醛 ppb HCHO";
                break;
            case 6:
                titleLable.text = @"二氧化碳 ppm CO₂";
                break;
            case 7:
                titleLable.text = @"挥发性有机物 level VOC";
                break;
            
                
            default:
                break;
        }
        titleLable.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 20)
        .widthIs(300)
        .heightIs(20);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createBarChartView];
        });
        
        
    }
    return self;
}
#pragma mark 柱形图
-(void)createBarChartView{
    
    
//    NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//    NSString *fiekPathName = [NSString stringWithFormat:@"priVateHistoryDicFor%@%@.plist",_priModel.project_id,_priModel.num];
//    NSString*newFielPath = [documentsPath stringByAppendingPathComponent:fiekPathName];
//    
//    NSMutableDictionary *publicHisthoryDic = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:newFielPath]];
//    NSMutableArray *arr1 = [[publicHisthoryDic objectForKey:[NSString stringWithFormat:@"1"]] objectForKey:[NSString stringWithFormat:@"1"]];

//    for (NSInteger a = 0; a< 100;a++) {
//        NSString *valueStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"avg_percent"]];
//        NSNumber *number = [NSNumber new];
//        
//        number = [NSNumber numberWithFloat:60];
//        
//        HistoryModel *historyModel = [[HistoryModel alloc] init];
//        historyModel.avg_percent = [NSString stringWithFormat:@"20"];
//        historyModel.avg_value = [NSString stringWithFormat:@"60"];
//        historyModel.time = [NSString stringWithFormat:@"12"];
//        historyModel.time1 = [NSString stringWithFormat:@"32"];
//        historyModel.time2 = [NSString stringWithFormat:@"44"];
//        historyModel.isShowLine = [NSString stringWithFormat:@"1"];
//        [historyModelArr addObject:historyModel];
//        [valueArr addObject:number];
//    }
//    publicHisthoryDic = nil;
//    arr1 = nil;
    
    NSArray *titleArr=[self getYTitleArr];
    
    
    _dataSource = valueArr;
    _barChartView = [[MCBarChartView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width-20, 190)];
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
    
    [self.contentView addSubview:_barChartView];
    
    [_barChartView reloadData];
    
    _barChartView.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,20)
    .rightSpaceToView(self.contentView,20)
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
    
    //1 TEMP ,2 HUMI ,3 HCHO ,4 CO2 ,5 VOC, 6 PM2.5 ,
    UIColor *color ;
    UIColor *color1 = [UIColor colorWithRed:54.0/255.0 green:188.0/255.0 blue:74.0/255.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:178.0/255.0 green:190.0/255.0 blue:30.0/255.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:244.0/255.0 green:149.0/255.0 blue:45.0/255.0 alpha:1];
    UIColor *color4 = [UIColor colorWithRed:254.0/255.0 green:48.0/255.0 blue:33.0/255.0 alpha:1];
    UIColor *color5 = [UIColor colorWithRed:164.0/255.0 green:44.0/255.0 blue:176.0/255.0 alpha:1];
    UIColor *color6 = [UIColor colorWithRed:56.0/255.0 green:0.0 blue:56.0/255.0 alpha:1];
    
    
    switch (dataType) {
        case 1:
            //            6 PM2.5
            if (value >= 0 && value < 35) {
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
            //            7 PM10
            if (value > 0 && value <= 50) {
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
            //1 TEMP
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
            //2 HUMI
            if (value >= 0 && value < 20) {
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
            //            3 HCHO
            if (value >= 0 && value < 100) {
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
            //            4 CO2
            if (value >= 0 && value < 350) {
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
            //            5 VOC
            if (value > 0 && value <= 1) {
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

@end
