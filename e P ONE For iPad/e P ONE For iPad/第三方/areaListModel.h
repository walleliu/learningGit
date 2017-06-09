//
//  areaListModel.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/16.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface areaListModel : NSObject
@property (nonatomic,copy) NSString *temp;
@property (nonatomic,copy) NSString *humi;
@property (nonatomic,copy) NSString *hcho;
@property (nonatomic,copy) NSString *co2;
@property (nonatomic,copy) NSString *voc;
@property (nonatomic,copy) NSString *pm25;
@property (nonatomic,copy) NSString *pm10;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *areaName;
@property (nonatomic,copy) NSString *areaID;

@property (nonatomic,assign) float tempPercent;
@property (nonatomic,assign) float humiPercent;
@property (nonatomic,assign) float hchoPercent;
@property (nonatomic,assign) float co2Percent;
@property (nonatomic,assign) float vocPercent;
@property (nonatomic,assign) float pm25Percent;
@property (nonatomic,assign) float pm10Percent;

@end
