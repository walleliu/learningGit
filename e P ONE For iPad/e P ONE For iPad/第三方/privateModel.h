//
//  privateModel.h
//  purenfort-2
//
//  Created by wall-e on 16/7/21.
//  Copyright © 2016年 wall-e. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface privateModel : NSObject
@property (nonatomic,copy) NSString *co2;//co2
@property (nonatomic,copy) NSString *compare_co2;//co2变化
@property (nonatomic,copy) NSString *compare_hcho;//hcho变化
@property (nonatomic,copy) NSString *compare_humidity;//humi变化
@property (nonatomic,copy) NSString *compare_pm10;//pm10变化
@property (nonatomic,copy) NSString *hcho;//hcho
@property (nonatomic,copy) NSString *humidity;//humi
@property (nonatomic,copy) NSString *img;//图片
@property (nonatomic,copy) NSString *name;//名字
@property (nonatomic,copy) NSString *pm10;//pm10
@property (nonatomic,copy) NSString *pm2_5;//pm2.5
@property (nonatomic,copy) NSString *time;//时间region_name
@property (nonatomic,copy) NSString *region_name;//区域名称
@property (nonatomic,copy) NSString *percent_co2;
@property (nonatomic,copy) NSString *percent_hcho;
@property (nonatomic,copy) NSString *percent_humidity;
@property (nonatomic,copy) NSString *percent_pm10;
@property (nonatomic,copy) NSString *percent_temp;
@property (nonatomic,copy) NSString *percent_voc;
@property (nonatomic,copy) NSString *temp;
@property (nonatomic,copy) NSString *voc;
@property (nonatomic,copy) NSString *project_id;
@property (nonatomic,copy) NSString *num;



@end
