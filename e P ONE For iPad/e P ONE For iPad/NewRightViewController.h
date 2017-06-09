//
//  NewRightViewController.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/22.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "areaListModel.h"
#import "MDPieView.h"
#import "MCBarChartView.h"
#import "privateModel.h"
#import "SmartSecondTableViewCell.h"
#import "smartCollectionViewCell.h"
#import "SmartModel.h"

@interface NewRightViewController : UIViewController<UISplitViewControllerDelegate,UIPopoverControllerDelegate,MCBarChartViewDataSource, MCBarChartViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) UILabel *customLab;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (strong,nonatomic) areaListModel *areaModel;
@property (strong,nonatomic) UIView *headView;

@property (nonatomic,strong) MDPieView *tempPieView;
@property (nonatomic,strong) MDPieView *humiPieView;
@property (nonatomic,strong) MDPieView *hchoPieView;
@property (nonatomic,strong) MDPieView *co2PieView;
@property (nonatomic,strong) MDPieView *vocPieView;
@property (nonatomic,strong) MDPieView *pm25PieView;
@property (nonatomic,strong) MDPieView *pm10PieView;

@property (nonatomic,strong) privateModel *priModel;
@property (strong, nonatomic) MCBarChartView *barChartView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic)NSInteger type;//数据类型
@property (strong,nonatomic)UIView *MCBarView;

@property (strong, nonatomic) NSMutableArray *tempDetailArr;
@property (strong, nonatomic) NSMutableArray *humiDetailArr;
@property (strong, nonatomic) NSMutableArray *co2DetailArr;
@property (strong, nonatomic) NSMutableArray *hchoDetailArr;
@property (strong, nonatomic) NSMutableArray *vocDetailArr;
@property (strong, nonatomic) NSMutableArray *pm25DetailArr;
@property (strong, nonatomic) NSMutableArray *pm10DetailArr;

@property (strong,nonatomic) UIView *smartView;
//@property (strong,nonatomic) UITableView *smartTableView;
@property (strong, nonatomic)  UICollectionView *CenterCollection;

@property (strong, nonatomic) NSMutableArray *smartModelArr;

@property (copy,nonatomic)NSString*cellIndexpathRow;

-(void)createSevenView;
-(void)createBarView;
-(void)createSmartTableView;
@end
