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
@protocol MeetPopoverDelegate <NSObject>

-(void)poverClickAtIndex:(NSInteger)index;

- (void)popover:(PopoverView*)pover clickAtIndex:(NSInteger)index;

-(void)poverDisapper;
@end

@interface IBLPopver : UIView

@property(nonatomic, weak)id<MeetPopoverDelegate>    delegate;

/**popover的高度*/
@property(nonatomic, assign)float   width;

/**如果有多个popover 可以通过这个属性进行判断*/
@property(nonatomic, copy)NSString * mark;

#pragma mark 初始化方法 ------------------------------------------------------------------------

    /**
    *不指定背景大小
    */
    - (instancetype)initWithTableWidth:(float)width andItems:(NSArray*)items;

    - (instancetype)initWithTableWidth:(float)width andItems:(NSArray*)items andImageNames:(NSArray*)images;


#pragma mark 使用方法 ------------------------------------------------------------------------

    /**
     * 三种布局 以满足支持选择 而保持相对位置不变
     */
    -(void)addToView:(UIView *)supView andPositionStyle:(PositionStyle)style;

    /**将popover添加到*/
    -(void)addToView:(UIView*)supView;


#pragma mark 外部布局接口 ------------------------------------------------------------------------

    /**
     *  设置位置 左边距 右边距 以及三角形的大小
     *  @param left 左边距
     *  @param right 右边距
     */
    - (void)setPositionWithLeftMargin:(float)left;

    /**
     *  设置三角形的高度
     */
    - (void)setTriangleHeight:(float)height;

    /**
     *  设置三角形箭头的百分比
     */
    - (void)setTrianglePersent:(float)persent;


#pragma mark 外部操作接口 ------------------------------------------------------------------------


@end
