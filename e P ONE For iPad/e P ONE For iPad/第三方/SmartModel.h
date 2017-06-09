//
//  SmartModel.h
//  PURENFORT_ios
//
//  Created by wall-e on 16/5/13.
//  Copyright © 2016年 wall-e. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartModel : NSObject
@property (nonatomic,copy) NSString *category;//设备类型
@property (nonatomic,copy) NSString *ctldata;//当前数值
@property (nonatomic,copy) NSString *ctltype;//控制方式
@property (nonatomic,copy) NSString *ID;//设备ID
@property (nonatomic,copy) NSString *name;//设备名称

@end
