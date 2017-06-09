//
//  RightViewController.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/9.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "firstTableViewCell.h"
#import "otherTableViewCell.h"
#import "areaListModel.h"
@interface RightViewController : UIViewController<UISplitViewControllerDelegate,UIPopoverControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong,nonatomic) UILabel *customLab;
@property (strong,nonatomic) areaListModel *areaModel;

@property (strong, nonatomic) NSMutableArray *tempDetailArr;
@property (strong, nonatomic) NSMutableArray *humiDetailArr;
@property (strong, nonatomic) NSMutableArray *co2DetailArr;
@property (strong, nonatomic) NSMutableArray *hchoDetailArr;
@property (strong, nonatomic) NSMutableArray *vocDetailArr;
@property (strong, nonatomic) NSMutableArray *pm25DetailArr;
@property (strong, nonatomic) NSMutableArray *pm10DetailArr;
@end
