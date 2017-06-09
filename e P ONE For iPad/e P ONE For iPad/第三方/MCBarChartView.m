//
//  MCBarChartView.m
//  zhixue_parents
//
//  Created by zhmch0329 on 15/8/17.
//  Copyright (c) 2015年 zhmch0329. All rights reserved.
//

#import "MCBarChartView.h"
#import "MCChartInformationView.h"

#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)      RGBA(r,g,b,1.0f)

#define BAR_CHART_TOP_PADDING 40
#define BAR_CHART_LEFT_PADDING 00
#define BAR_CHART_RIGHT_PADDING 0
#define BAR_CHART_TEXT_HEIGHT 40

#define BAR_WIDTH_DEFAULT 20.0

#define PADDING_SECTION_DEFAULT 10.0
#define PADDING_BAR_DEFAULT 1.0

CGFloat static const kChartViewUndefinedCachedHeight = -1.0f;

@interface MCBarChartView ()<CAAnimationDelegate>
{
    NSInteger itemsRow ;
    NSInteger oldItemsRow ;
    CAShapeLayer *shapeLayer1;
    UIBezierPath *path1;
    BOOL yincang;
    UIView *lineView;
}
@property (nonatomic, strong) NSArray *chartDataSource;

@property (nonatomic, assign) NSUInteger sections;
@property (nonatomic, assign) CGFloat paddingSection;
@property (nonatomic, assign) CGFloat paddingBar;
@property (nonatomic, assign) CGFloat barWidth;

@property (nonatomic, assign) CGFloat cachedMaxHeight;
@property (nonatomic, assign) CGFloat cachedMinHeight;

@property (nonatomic, strong) NSMutableArray *zuoBiaoArr;
@property (nonatomic, strong) NSMutableArray *baikuangArr;
@end

@implementation MCBarChartView {
    UIColor *_chartBackgroundColor;
    UIScrollView *_scrollView;
    
    CGFloat _chartHeight;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
    _chartHeight = self.bounds.size.height - BAR_CHART_TOP_PADDING - BAR_CHART_TEXT_HEIGHT;
    
    _unitOfYAxis = @"";
    _numberOfYAxis = 5;
    _yArr = [NSMutableArray array];
    _cachedMaxHeight = kChartViewUndefinedCachedHeight;
    _cachedMinHeight = kChartViewUndefinedCachedHeight;
    itemsRow = 0;
    oldItemsRow = 0;
    yincang = YES;
    _zuoBiaoArr = [NSMutableArray array];
    _baikuangArr = [NSMutableArray array];
    

    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.chartDataSource == nil) {
        [self reloadData];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawCoordinateWithContext:context];
}

#pragma mark - Draw Coordinate

- (void)drawCoordinateWithContext:(CGContextRef)context {
    CGFloat width = self.bounds.size.width;
    
    CGContextSetStrokeColorWithColor(context, _colorOfYAxis.CGColor);
    CGContextMoveToPoint(context, BAR_CHART_LEFT_PADDING - 1, 0);
    CGContextAddLineToPoint(context, BAR_CHART_LEFT_PADDING - 1, BAR_CHART_TOP_PADDING + _chartHeight + 1);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, _colorOfXAxis.CGColor);
    CGContextMoveToPoint(context, BAR_CHART_LEFT_PADDING - 1, BAR_CHART_TOP_PADDING + _chartHeight + 1);
    CGContextAddLineToPoint(context, width - BAR_CHART_RIGHT_PADDING + 1, BAR_CHART_TOP_PADDING + _chartHeight + 1);
    CGContextStrokePath(context);
}

#pragma mark - Height

- (CGFloat)normalizedHeightForRawHeight:(NSNumber *)rawHeight {
    CGFloat value = [rawHeight floatValue];
    CGFloat maxHeight = [self.maxValue floatValue];
    return value/maxHeight * _chartHeight;
}

- (id)maxValue {
    if (_maxValue == nil) {
        if ([self cachedMaxHeight] != kChartViewUndefinedCachedHeight) {
            _maxValue = @([self cachedMaxHeight]);
        }
    }
    return _maxValue;
}

- (CGFloat)cachedMinHeight {
    if(_cachedMinHeight == kChartViewUndefinedCachedHeight) {
        NSArray *chartValues = [NSMutableArray arrayWithArray:_chartDataSource];
        for (NSArray *array in chartValues) {
            for (NSNumber *number in array) {
                CGFloat height = [number floatValue];
                if (height < _cachedMinHeight) {
                    _cachedMinHeight = height;
                }
            }
        }
    }
    return _cachedMinHeight;
}

- (CGFloat)cachedMaxHeight {
    if (_cachedMaxHeight == kChartViewUndefinedCachedHeight) {
        NSArray *chartValues = [NSMutableArray arrayWithArray:_chartDataSource];
        for (NSArray *array in chartValues) {
            for (NSNumber *number in array) {
                CGFloat height = [number floatValue];
                if (height > _cachedMaxHeight) {
                    _cachedMaxHeight = height;
                }
            }
        }
    }
    return _cachedMaxHeight;
}

#pragma mark - Reload Data
- (void)reloadData {
    [_zuoBiaoArr removeAllObjects];
    [_baikuangArr removeAllObjects];
    oldItemsRow = 0;
    itemsRow = 0;
    
    [self reloadDataWithAnimate:YES];
}

- (void)reloadDataWithAnimate:(BOOL)animate {
    [self reloadChartYAxis];
    [self reloadChartDataSource];
    
    [self reloadBarWithAnimate:animate];
    
}

- (void)reloadChartDataSource {
    _cachedMaxHeight = kChartViewUndefinedCachedHeight;
    _cachedMinHeight = kChartViewUndefinedCachedHeight;
    
    _sections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInBarChartView:)]) {
        _sections = [self.dataSource numberOfSectionsInBarChartView:self];
    }
    
    NSAssert([self.dataSource respondsToSelector:@selector(barChartView:numberOfBarsInSection:)], @"BarChartView // delegate must implement barChartView:numberOfBarsInSection:");
    
    _paddingSection = PADDING_SECTION_DEFAULT;
    if ([self.delegate respondsToSelector:@selector(paddingForSectionInBarChartView:)]) {
        _paddingSection = [self.delegate paddingForSectionInBarChartView:self];
    }
    _paddingBar = PADDING_BAR_DEFAULT;
    if ([self.delegate respondsToSelector:@selector(paddingForBarInBarChartView:)]) {
        _paddingBar = [self.delegate paddingForBarInBarChartView:self];
    }
    _barWidth = BAR_WIDTH_DEFAULT;
    if ([self.delegate respondsToSelector:@selector(barWidthInBarChartView:)]) {
        _barWidth = [self.delegate barWidthInBarChartView:self];
    }
    
    NSAssert(([self.dataSource respondsToSelector:@selector(barChartView:valueOfBarInSection:index:)]), @"MCBarChartView // delegate must implement - (CGFloat)barChartView:(MCBarChartView *)barChartView valueOfBarsInSection:(NSUInteger)section index:(NSUInteger)index");
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:_sections];
    CGFloat contentWidth = _paddingSection;
    for (NSUInteger i = 0; i < _sections; i ++) {
        NSUInteger barCount = [self.dataSource barChartView:self numberOfBarsInSection:i];

        contentWidth += barCount * _barWidth + (barCount - 1) * _paddingBar;
        contentWidth += _paddingSection;
        
        NSMutableArray *barArray = [NSMutableArray arrayWithCapacity:barCount];
        for (NSInteger j = 0; j < barCount; j ++) {
            id value = [self.dataSource barChartView:self valueOfBarInSection:i index:j];
            [barArray addObject:value];
        }
        [dataArray addObject:barArray];
    }
    _scrollView.contentSize = CGSizeMake(contentWidth + self.frame.size.width /2 + 50, 0);
    _scrollView.contentOffset = CGPointMake(contentWidth - self.frame.size.width
                                            , 0);
    _chartDataSource = [[NSMutableArray alloc] initWithArray:dataArray];
}

- (void)reloadChartYAxis {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat chartYOffset = _chartHeight + BAR_CHART_TOP_PADDING;
    CGFloat unitHeight = _chartHeight/_numberOfYAxis;
    //    CGFloat unitValue = [self.maxValue floatValue]/_numberOfYAxis;
    
    for (NSInteger i = 0; i <= _numberOfYAxis; i ++) {
        
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, chartYOffset - unitHeight * i, self.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:0.1];
        [self addSubview:lineView];
    
    }
    CGFloat width = self.bounds.size.width;
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    topLineView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:0.1];
    [self addSubview:topLineView];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(BAR_CHART_LEFT_PADDING, 0, width - BAR_CHART_RIGHT_PADDING - BAR_CHART_LEFT_PADDING, CGRectGetHeight(self.bounds))];
    
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    for (NSInteger i = 0; i <= _numberOfYAxis; i ++) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, chartYOffset - unitHeight * i - 14, 30, 20)];
        textLabel.textColor = _colorOfYText;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.numberOfLines = 1;
        textLabel.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:0.3];
         textLabel.text = [_yArr objectAtIndex:i];
        [textLabel sizeToFit];
        textLabel.layer.cornerRadius = 2;
        
        textLabel.layer.masksToBounds = YES;
        [self addSubview:textLabel];

        
    }
}

- (void)reloadBarWithAnimate:(BOOL)animate {
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_scrollView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    CGFloat xSection = _paddingSection;
    CGFloat xOffset = _paddingSection + _barWidth/2 ;
    CGFloat chartYOffset = _chartHeight + BAR_CHART_TOP_PADDING;
    for (NSInteger section = 0; section < _sections; section ++) {
        NSArray *array = _chartDataSource[section];
        for (NSInteger index = 0; index < array.count; index ++) {
            CGFloat height = [self normalizedHeightForRawHeight:array[index]];
            if (height<0) {
                height = 0;
            }
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(xOffset, chartYOffset+0.5)];
            [bezierPath addLineToPoint:CGPointMake(xOffset, chartYOffset - height)];
            CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
            shapeLayer.lineWidth = _barWidth;
            shapeLayer.path = bezierPath.CGPath;
            shapeLayer.fillColor = [UIColor blueColor].CGColor;
            
            if ([self.delegate respondsToSelector:@selector(barChartView:colorOfBarInSection:index:)]) {
                shapeLayer.strokeColor = [self.delegate barChartView:self colorOfBarInSection:section index:index].CGColor;
            } else {
                shapeLayer.strokeColor = [UIColor redColor].CGColor;
            }
            [_scrollView.layer addSublayer:shapeLayer];

            path1 = [UIBezierPath bezierPathWithRect:CGRectMake(xOffset - _barWidth/2, chartYOffset- height, _barWidth,height)];
            shapeLayer1 = [[CAShapeLayer alloc] init];
            shapeLayer1.path = path1.CGPath;
            shapeLayer1.fillColor = [UIColor clearColor].CGColor;
            shapeLayer1.lineWidth = 1;
            shapeLayer1.strokeColor = [UIColor blackColor].CGColor;
            if (section == _sections - 26) {
                [_scrollView.layer addSublayer:shapeLayer1];
            }
            
 
            [_baikuangArr addObject:shapeLayer1];
            //月日
            if (section >_initArrCount-1) {
                
                HistoryModel *historyModel = [_historyModelArray objectAtIndex:section];
                if ([historyModel.isShowLine isEqualToString:@"1"]) {
                    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(xOffset - _barWidth/2, 20, 1,chartYOffset)];
                    view4.backgroundColor =[UIColor grayColor];
//                    [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
                    view4.alpha = 0.4;
                    [_scrollView addSubview:view4];
                    
                    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(xOffset - _barWidth/2 + 8, 20, 100, 16)];
                    label4.textColor = [UIColor grayColor];
                    label4.font = [UIFont systemFontOfSize:13];
                    label4.alpha = 0.7;
                    label4.text = historyModel.time;
                    [_scrollView addSubview:label4];
                    
                    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(xOffset - _barWidth/2 + 8, 31, 100, 16)];
                    label5.textColor = [UIColor grayColor];
//                    [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
                    label5.font = [UIFont systemFontOfSize:11];
                    label5.text = historyModel.time2;
                    label5.alpha = 0.7;
                    [_scrollView addSubview:label5];
                }

                
                
            }
            
            
            if (animate) {
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                animation.fromValue = @(0.0);
                animation.toValue = @(1.0);
                animation.repeatCount = 1.0;
                animation.duration = height/_chartHeight * 0.75;
                animation.fillMode = kCAFillModeForwards;
                animation.delegate = self;
                [shapeLayer addAnimation:animation forKey:@"animation"];
            }
            
            NSTimeInterval delay = animate ? 0.75 : 0.0;
            if ([self.delegate respondsToSelector:@selector(barChartView:hintViewOfBarInSection:index:)]) {
                UIView *hintView = [self.delegate barChartView:self hintViewOfBarInSection:section index:index];
                if (hintView) {
                    hintView.center = CGPointMake(xOffset, chartYOffset - height - CGRectGetHeight(hintView.bounds)/2);
                    hintView.alpha = 0.0;
                    [_scrollView addSubview:hintView];
                    [UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        hintView.alpha = 1.0;
                    } completion:nil];
                }
            } else if ([self.delegate respondsToSelector:@selector(barChartView:informationOfBarInSection:index:)]) {
                NSString *information = [self.delegate barChartView:self informationOfBarInSection:section index:index];
                if (information&&section > _initArrCount - 1) {
  
                    HistoryModel *historyModel = [_historyModelArray objectAtIndex:section];
                    NSString *unitStr = @"";
                    if (_isBusiness) {
                        switch (_type) {
                            case 1:
                                unitStr = @"ug/m³";
                                break;
                            case 2:
                                unitStr = @"ug/m³";
                                break;
                            case 3:
                                unitStr = @"℃";
                                break;
                            case 4:
                                unitStr =@"%RH";
                                break;
                            case 5:
                                unitStr = @"ppb";
                                break;
                            case 6:
                                unitStr =@"ppm";
                                break;
                            case 7:
                                unitStr = @"level";
                                break;
                            
                            default:
                                unitStr = @"ug/m³";
                                break;
                        }
                    }else{
                        if (_type != 3) {
                            unitStr = @"ug/m³";
                        }
                        
                    }
                    
                    if ([historyModel.avg_value isEqualToString:@"(null)"]) {
                        historyModel.avg_value = @"";
                    }
                    NSString *information1 = [NSString stringWithFormat:@"%@ %@%@%@",historyModel.time1,information,historyModel.avg_value,unitStr];
                    
                    MCChartInformationView *informationView = [[MCChartInformationView alloc] initWithText:information1];
                    informationView.center = CGPointMake(xOffset-3, chartYOffset + CGRectGetHeight(informationView.bounds)/2 + 10);
                    if (section == _sections - 26) {
                        [_scrollView addSubview:informationView];
                    }
                    
//                    informationView.tag = index+100;
                    
                    
                    [_zuoBiaoArr addObject:informationView];
                    
                }else{
                    [_zuoBiaoArr addObject:@0];
                }
            }
            
            xOffset += _barWidth + (index == array.count - 1 ? 0 : _paddingBar);
        }
        //x轴文字内容
        if ([self.delegate respondsToSelector:@selector(barChartView:titleOfBarInSection:)]) {
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xSection - _paddingSection/2, _chartHeight + BAR_CHART_TOP_PADDING, xOffset - xSection + _paddingSection, BAR_CHART_TEXT_HEIGHT)];
            textLabel.textColor = _colorOfXText;
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:14];
            textLabel.numberOfLines = 0;
            textLabel.text = [self.dataSource barChartView:self titleOfBarInSection:section];
            [_scrollView addSubview:textLabel];
        }
        xOffset += _paddingSection;
        xSection = xOffset;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView   {
    
    NSInteger temp = _paddingSection + _barWidth;
    if (_zuoBiaoArr.count != 0&&_zuoBiaoArr.count >_initArrCount) {
        if (yincang) {
            
            MCChartInformationView *informationView = [_zuoBiaoArr objectAtIndex:_sections - 1];
            //            informationView.alpha = 0.0;
            [informationView removeFromSuperview];
            
            CAShapeLayer *shapeLayer = [_baikuangArr objectAtIndex:_sections - 1];
            //            shapeLayer.hidden = YES;
            [shapeLayer removeFromSuperlayer];
            yincang = NO;
        }
        
        if ((NSInteger)scrollView.contentOffset.x / temp <  0) {
            itemsRow = _initArrCount+1;
        }else if((NSInteger)scrollView.contentOffset.x / temp >= _zuoBiaoArr.count ){
            itemsRow = _zuoBiaoArr.count - 1;
        }
        else{
            itemsRow =(NSInteger)scrollView.contentOffset.x / temp + _initArrCount;
            
        }
        if (itemsRow <_zuoBiaoArr.count) {
            
            for (NSInteger i = _initArrCount;  i < _zuoBiaoArr.count ; i ++) {
                if ( i == itemsRow) {
                    MCChartInformationView *informationView = [_zuoBiaoArr objectAtIndex:itemsRow];
                    [_scrollView addSubview:informationView];
                    CAShapeLayer *shapeLayer = [_baikuangArr objectAtIndex:itemsRow];
                    [_scrollView.layer addSublayer:shapeLayer];
                }else{
                    MCChartInformationView *informationView = [_zuoBiaoArr objectAtIndex:i];
                    
                    [informationView removeFromSuperview];
                    CAShapeLayer *shapeLayer = [_baikuangArr objectAtIndex:i];
                    [shapeLayer removeFromSuperlayer];
                }
            }
            
            
            
        }
        
    }

    
   
}

@end
