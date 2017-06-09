//
//  HistoryModel.h
//  purenfort-2
//
//  Created by wall-e on 16/7/26.
//  Copyright © 2016年 wall-e. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject
@property (nonatomic,copy) NSString *avg_percent;//比例
@property (nonatomic,copy) NSString *avg_value;//数值
@property (nonatomic,copy) NSString *time;//时间
@property (nonatomic,copy) NSString *time1;//时间1
@property (nonatomic,copy) NSString *time2;//时间2
@property (nonatomic,copy) NSString *isShowLine;//是否显示分界线
@end
