//
//  MDPieView.m
//  MDPieView
//
//  Created by wenchao zeng on 2016/10/31.
//  Copyright © 2016年 wenchao zeng. All rights reserved.
//

#import "MDPieView.h"

#define LINE_WIDTH 10//环形宽度
#define DURATION 1.0//动画时间
#define TEXT_FONT 10.f//字体大小

@interface MDPieView()

@property (nonatomic,assign) float      percent;
@property (nonatomic,assign) float      radius;
@property (nonatomic,assign) CGPoint    centerPoint;
@property (nonatomic,strong) UIColor    *lineColor;
@property (nonatomic,strong) UIColor    *titleColor;
@property (nonatomic,strong) NSString   *titleStr;
@property (nonatomic,strong) NSString   *numStr;

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CATextLayer  *textLayer;
@property (nonatomic,strong) CATextLayer  *numTextLayer;
@property (nonatomic,strong) CAShapeLayer *pointLayer;
@end

@implementation MDPieView

-(instancetype)initWithFrame:(CGRect)frame andPercent:(float)percent andColor:(UIColor *)color andTitle:(NSString *)titleStr andNumStr:(NSString *)numStr andTextColor:(UIColor *)textColor{
    if(self = [super initWithFrame:frame]) {
        self.percent = percent;
        self.radius = CGRectGetWidth(frame) / 2.0 - LINE_WIDTH / 2.0;
        self.lineColor = color;
        self.titleStr = titleStr;
        self.numStr = numStr;
        self.titleColor = textColor;
        
        //值为0 字体颜色为灰色
        if ([self.numStr integerValue] == 0) {
            self.titleColor = [UIColor colorWithRed:225.0/255.0 green:224.0/255.0 blue:225.0/255.0 alpha:1];//灰色
        }
        
        self.centerPoint = CGPointMake(CGRectGetWidth(frame) / 2.0, CGRectGetWidth(frame) / 2.0);
        [self createBackLine];
        [self commonInit];
    }
    return self;
}

-(void)setPercent:(float)percent {
    if (percent >= 1) {
        _percent = 1;
    }else {
        _percent = percent;
    }
}

-(void)reloadViewWithPercent:(float)percent {
    self.percent = percent;
    [self.layer removeAllAnimations];
    [self.lineLayer removeFromSuperlayer];
    [self.pointLayer removeFromSuperlayer];
    [self.textLayer removeFromSuperlayer];
    [self commonInit];
}

-(void)commonInit {
    [self createPercentLayer];
//    [self createPointLayer];
    [self setPercentTextLayer];
}

-(void)createBackLine {
    //绘制背景
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = LINE_WIDTH;
    shapeLayer.strokeColor = [self.lineColor CGColor];
    shapeLayer.opacity = 0.2;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3 clockwise:YES];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}

-(void)createPercentLayer {
    //绘制环形
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.lineWidth = LINE_WIDTH;
    //端点平角
    self.lineLayer.lineCap = kCALineCapButt;
    self.lineLayer.strokeColor = [self.lineColor CGColor];
    self.lineLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI * 2 * self.percent - M_PI / 2.0 clockwise:YES];
    
    self.lineLayer.path = path.CGPath;
    CABasicAnimation *showAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    showAnimation.fromValue = @0;
    showAnimation.toValue = @1;
    showAnimation.duration = DURATION;
    showAnimation.removedOnCompletion = YES;
    showAnimation.fillMode = kCAFillModeForwards;// 当动画结束后,layer会一直保持着动画最后的状态
    [self.layer addSublayer:self.lineLayer];
    [self.lineLayer addAnimation:showAnimation forKey:@"kClockAnimation"];
}

//头部小白点
-(void)createPointLayer {
    
    self.pointLayer = [CAShapeLayer layer];
    self.pointLayer.lineWidth = 1;
    self.pointLayer.strokeColor = [[UIColor whiteColor] CGColor];
    self.pointLayer.fillColor = [[UIColor whiteColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2.0, LINE_WIDTH / 2.0) radius:1 startAngle:- M_PI / 2.0 endAngle:M_PI / 2.0 * 3 clockwise:YES];
    self.pointLayer.path = path.CGPath;
    [self.layer addSublayer:self.pointLayer];
}
//中间文字
-(void)setPercentTextLayer {
    self.textLayer = [CATextLayer layer];
    self.textLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.textLayer.string = self.titleStr;
    self.textLayer.bounds = CGRectMake(0, 0, self.radius*2, 15);
    self.textLayer.font = (__bridge CFTypeRef _Nullable)(@"HiraKakuProN-W3");
    self.textLayer.fontSize = TEXT_FONT;
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    self.textLayer.position = CGPointMake(self.centerPoint.x, self.centerPoint.y-5 );
    self.textLayer.foregroundColor =
    _titleColor.CGColor;
    [self.layer addSublayer:self.textLayer];
    
    
    self.numTextLayer = [CATextLayer layer];
    self.numTextLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.numTextLayer.string = self.numStr;
    self.numTextLayer.bounds = CGRectMake(0, 0, self.radius*2, 15);
    self.numTextLayer.font = (__bridge CFTypeRef _Nullable)(@"HiraKakuProN-W3");
    self.numTextLayer.fontSize = TEXT_FONT;
    self.numTextLayer.alignmentMode = kCAAlignmentCenter;
    self.numTextLayer.position = CGPointMake(self.centerPoint.x, self.centerPoint.y + 10 );
    self.numTextLayer.foregroundColor = _titleColor.CGColor;
    [self.layer addSublayer:self.numTextLayer];
}

@end
