//
//  firstTableViewCell.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/10.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "firstTableViewCell.h"
   
#import "UIView+SDAutoLayout.h"
@implementation firstTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withAreaModel:(areaListModel *)areaModel {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.tempNumStr = areaModel.temp;
        self.humiNumStr = areaModel.humi;
        self.hchoNumStr = areaModel.hcho;
        self.co2NumStr = areaModel.co2;
        self.vocNumStr = areaModel.voc;
        self.pm25NumStr = areaModel.pm25;
        self.pm10NumStr = areaModel.pm10;
        
        self.tempPercent = areaModel.tempPercent;
        self.humiPercent = areaModel.humiPercent;//0 - 100
        self.hchoPercent = areaModel.hchoPercent;// 0 - 500
        self.co2Percent = areaModel.co2Percent;// 0 - 5000
        self.vocPercent = areaModel.vocPercent;// 0 - 6
        self.pm25Percent = areaModel.pm25Percent;//0 - 500
        self.pm10Percent = areaModel.pm10Percent;// 0 - 300
        
        UIColor *tempColor= [self getColorWithType:1 Value:[self.tempNumStr integerValue]];
        UIColor *humiColor= [self getColorWithType:2 Value:[self.humiNumStr integerValue]];
        UIColor *hchoColor= [self getColorWithType:3 Value:[self.hchoNumStr integerValue]];
        UIColor *co2Color= [self getColorWithType:4 Value:[self.co2NumStr integerValue]];
        UIColor *vocColor= [self getColorWithType:5 Value:[self.vocNumStr integerValue]];
        UIColor *pm25Color= [self getColorWithType:6 Value:[self.pm25NumStr integerValue]];
        UIColor *pm10Color= [self getColorWithType:7 Value:[self.pm10NumStr integerValue]];
        
        
        self.tempPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:self.tempPercent andColor:tempColor andTitle:@"TEMP" andNumStr:[NSString stringWithFormat:@"%@ ℃",self.tempNumStr] andTextColor:[UIColor blackColor] ];
        [self.contentView addSubview:self.tempPieView];
        
        self.humiPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:self.humiPercent andColor:humiColor andTitle:@"HUMI" andNumStr:[NSString stringWithFormat:@"%@ %%RH",self.humiNumStr ]andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.humiPieView];
        
        self.hchoPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:self.hchoPercent andColor:hchoColor andTitle:@"HCHO" andNumStr:[NSString stringWithFormat:@"%@ ppb",self.hchoNumStr]andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.hchoPieView];
        
        self.co2PieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:self.co2Percent andColor:co2Color andTitle:@"CO₂" andNumStr:[NSString stringWithFormat:@"%@ ppm",self.co2NumStr]andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.co2PieView];
        
        self.vocPieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:self.vocPercent andColor:vocColor andTitle:@"VOC" andNumStr:[NSString stringWithFormat:@"%@ level",self.vocNumStr]andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.vocPieView];
        
        self.pm25PieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:self.pm25Percent andColor:pm25Color andTitle:@"PM2.5" andNumStr:[NSString stringWithFormat:@"%@ ug/m³",self.pm25NumStr]andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.pm25PieView];
        
        self.pm10PieView = [[MDPieView alloc]initWithFrame:CGRectMake(20, 20, 80, 80) andPercent:self.pm10Percent  andColor:pm10Color andTitle:@"PM10" andNumStr:[NSString stringWithFormat:@"%@ ug/m³",self.pm10NumStr]andTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.pm10PieView];
        
        
        self.contentView.sd_equalWidthSubviews = @[self.tempPieView, self.humiPieView,self.hchoPieView,self.co2PieView,self.vocPieView,self.pm25PieView,self.pm10PieView];
        
        self.tempPieView.sd_layout
        .leftSpaceToView(self.contentView, 20)
        .topSpaceToView(self.contentView, 20)
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
        .rightSpaceToView(self.contentView, 20)
        .topEqualToView(self.tempPieView)
        .heightRatioToView(self.tempPieView, 1);
        
        
    }
    return self;
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
    
    UIColor *color7 = [UIColor colorWithRed:225.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:1];//灰色
    

        switch (dataType) {
            case 1:
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
            case 2:
                //2 HUMI
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
            case 3:
                //            3 HCHO
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
            case 4:
                //            4 CO2
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
            case 5:
                //            5 VOC
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
            case 6:
                //            6 PM2.5
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
            case 7:
                //            7 PM10
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
     
                
            default:
                break;
        }

    
    return color;
    
}

@end
