//
//  IBLPopver.h
//  IBL
//
//  Created by simpossible on 16/1/11.
//  Copyright © 2016年 simpossible. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IBLPopoverDelegate <NSObject>

-(void)poverClickAtIndex:(NSInteger)index;

-(void)poverDisapper;

@end

@interface IBLPopver : UIView

@property(nonatomic,weak)id<IBLPopoverDelegate>    delegate;

/**
 *不指定背景大小
 */
-(instancetype)initWithTableWidth:(float)width andItems:(NSArray*)items;


-(void)setTouchUnEnableInRow:(NSInteger)row;

-(void)setTouchEnableInRow:(NSInteger)row;

-(void)addToView:(UIView*)supView;

@end
