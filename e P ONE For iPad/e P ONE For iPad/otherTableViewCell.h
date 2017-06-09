//
//  otherTableViewCell.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/10.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBarChartView.h"
#import "privateModel.h"
#import "UIView+SDAutoLayout.h"
@interface otherTableViewCell : UITableViewCell<MCBarChartViewDataSource, MCBarChartViewDelegate>
@property (nonatomic,strong) privateModel *priModel;
@property (strong, nonatomic) MCBarChartView *barChartView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic)NSInteger type;//数据类型


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDataType:(NSInteger)dataType withCellArr:(NSMutableArray *)cellArr;
@end
