//
//  IPListView.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/6/7.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNSRequestData.h"
#import "IPModel.h"
#import "IPListViewTableViewCell.h"
@interface IPListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTabelView;
-(instancetype)initWithFrame:(CGRect)frame withIPModelArr:(NSMutableArray *)array;
@end
