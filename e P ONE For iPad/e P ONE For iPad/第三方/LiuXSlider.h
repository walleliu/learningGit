//
//  LiuXSlider.h
//  LJSlider
//
//  Created by 刘鑫 on 16/3/24.
//  Copyright © 2016年 com.anjubao. All rights reserved.
//
typedef void(^valueChangeBlock)(int index);

#import <UIKit/UIKit.h>

@interface LiuXSlider : UIControl



/**
 *  回调
 */
@property (nonatomic,copy)valueChangeBlock block;


/**
 *  初始化方法
 *
 *  @param frame
 *  @param titleArray         必传，传入节点数组
 *  @param firstAndLastTitles 首，末位置的title
 *  @param defaultIndex       必传，范围（0到(array.count-1)）
 *  @param sliderImage        传入画块图片
 *
 *  @return 
 */
-(instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray *)titleArray
          firstAndLastTitles:(NSArray *)firstAndLastTitles
                defaultIndex:(CGFloat)defaultIndex
                 sliderImage:(UIImage *)sliderImage;

@property (nonatomic,assign)CGFloat defaultIndx;



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com