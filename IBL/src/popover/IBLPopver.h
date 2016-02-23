//
//  IBLPopver.h
//  IBL
//
//  Created by simpossible on 16/1/11.
//  Copyright © 2016年 simpossible. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PositionStyle){
    PositionStyleNone,
    PositionStyleCenter,
    PositionStyleLeft,
    PositionStyleRight,
};

@class PopoverView;
@protocol MeetPoverDelegate <NSObject>

-(void)poverClickAtIndex:(NSInteger)index;

- (void)popover:(PopoverView*)pover clickAtIndex:(NSInteger)index;

-(void)poverDisapper;
@end

@interface IBLPopver : UIView

@property(nonatomic, weak)id<MeetPoverDelegate>    delegate;

@property(nonatomic, assign)float   width;

/**
 * 如果有多个popover 可以通过这个属性进行判断
 */
@property(nonatomic, copy)NSString * mark;

//-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame andTableWidth:(float)width andItems:(NSArray *)items;

/**
 *不指定背景大小
 */
- (instancetype)initWithTableWidth:(float)width andItems:(NSArray*)items;

- (instancetype)initWithTableWidth:(float)width andItems:(NSArray*)items andImageNames:(NSArray*)images;

/**
 *  设置位置 左边距 右边距 以及三角形的大小
 *  @param left 左边距
 *  @param right 右边距
 */
- (void)setPositionWithRightMargin:(float)left;


/**
 *  设置三角形的高度
 */
- (void)setTriangleHeight:(float)height;

/**
 *  设置三角形箭头的百分比
 */
- (void)setTrianglePersent:(float)persent;

-(void)addToView:(UIView*)supView;

-(void)addToView:(UIView *)supView andPositionStyle:(PositionStyle)style;

@end
