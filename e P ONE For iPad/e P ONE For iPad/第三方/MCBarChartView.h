//
//  MCBarChartView.h
//  zhixue_parents
//
//  Created by zhmch0329 on 15/8/17.
//  Copyright (c) 2015年 zhmch0329. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"
@class MCBarChartView;
@class UITableView;
@protocol MCBarChartViewDataSource <NSObject>

@required
//每组里有几个柱形图
- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section;
//柱形图高度值
- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index;

@optional
//有几组
- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView;
//x轴文字内容
- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section;


@end

@protocol MCBarChartViewDelegate <NSObject>

@optional
- (void)barChartView:(MCBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index;
//宽度
- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView;
//间隔
- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView;
- (CGFloat)paddingForBarInBarChartView:(MCBarChartView *)barChartView;
//柱形图颜色
- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index;
- (NSArray *)barChartView:(MCBarChartView *)barChartView selectionColorForBarInSection:(NSUInteger)section;
//柱形图上方显示的view
- (NSString *)barChartView:(MCBarChartView *)barChartView informationOfBarInSection:(NSInteger)section index:(NSInteger)index;
//自定义柱形图上方显示的view
- (UIView *)barChartView:(MCBarChartView *)barChartView hintViewOfBarInSection:(NSInteger)section index:(NSInteger)index;

@end

@interface MCBarChartView : UIView<UIScrollViewDelegate>


@property (nonatomic, weak) id<MCBarChartViewDataSource> dataSource;
@property (nonatomic, weak) id<MCBarChartViewDelegate> delegate;

/// 最大值，如果未设置计算数据源中的最大值
@property (nonatomic, strong) id maxValue;
/// y轴数据标记个数
@property (nonatomic, assign) NSInteger numberOfYAxis;
/// y轴数据单位
@property (nonatomic, copy) NSString *unitOfYAxis;
/// y轴的颜色
@property (nonatomic, strong) UIColor *colorOfYAxis;
/// y轴文本数据颜色
@property (nonatomic, strong) UIColor *colorOfYText;
/// x轴的颜色
@property (nonatomic, strong) UIColor *colorOfXAxis;
/// x轴文本数据颜色
@property (nonatomic, strong) UIColor *colorOfXText;
//y轴数据
@property (nonatomic,strong) NSMutableArray *yArr;
//传过来的数据类型
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger initArrCount;



//数据模型数组
@property (nonatomic,strong) NSMutableArray *historyModelArray;

@property (nonatomic,assign) BOOL isBusiness;//yes  商用 no  公共

- (void)reloadData;
- (void)reloadDataWithAnimate:(BOOL)animate;

@end
