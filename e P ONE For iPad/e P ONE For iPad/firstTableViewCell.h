//
//  firstTableViewCell.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/10.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPieView.h"
#import "areaListModel.h"
@interface firstTableViewCell : UITableViewCell
@property (nonatomic,assign) float tempPercent;
@property (nonatomic,assign) float humiPercent;
@property (nonatomic,assign) float hchoPercent;
@property (nonatomic,assign) float co2Percent;
@property (nonatomic,assign) float vocPercent;
@property (nonatomic,assign) float pm25Percent;
@property (nonatomic,assign) float pm10Percent;

@property (nonatomic,copy) NSString *tempNumStr;
@property (nonatomic,copy) NSString *humiNumStr;
@property (nonatomic,copy) NSString *hchoNumStr;
@property (nonatomic,copy) NSString *co2NumStr;
@property (nonatomic,copy) NSString *vocNumStr;
@property (nonatomic,copy) NSString *pm25NumStr;
@property (nonatomic,copy) NSString *pm10NumStr;



@property (nonatomic,strong) MDPieView *tempPieView;
@property (nonatomic,strong) MDPieView *humiPieView;
@property (nonatomic,strong) MDPieView *hchoPieView;
@property (nonatomic,strong) MDPieView *co2PieView;
@property (nonatomic,strong) MDPieView *vocPieView;
@property (nonatomic,strong) MDPieView *pm25PieView;
@property (nonatomic,strong) MDPieView *pm10PieView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withAreaModel:(areaListModel *)areaModel;
@end
