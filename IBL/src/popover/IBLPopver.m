//
//  IBLPopver.m
//  IBL
//
//  Created by simpossible on 16/1/11.
//  Copyright © 2016年 simpossible. All rights reserved.
//

#import "IBLPopver.h"
#import "IBLPoverViewCellHandler.h"

@interface IBLPopver()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * poverTableView;

@property(nonatomic,strong)NSArray * dataArray;

@property(nonatomic,strong)UIView * poverView;

@property(nonatomic, assign)float popoverWidth;

@property(nonatomic, assign)float popverHeight;
@end


@implementation IBLPopver


-(instancetype)initWithTableWidth:(float)width andItems:(NSArray *)items{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:0.2];
    }
    self.dataArray = items;
    [self initialPoverViewWithWidth:width];
    [self addTriangleAtPoint:68];
    return self;
}

#pragma mark UI初始化________________________________________
-(void)initialPoverTabviewWithFrame:(CGRect)frame{
    self.poverTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.poverTableView setDelegate:self];
    [self.poverTableView setDataSource:self];
    [self.poverTableView setBackgroundColor:[UIColor whiteColor]];
    [self.poverTableView setScrollEnabled:NO];
}


-(void)initialPoverViewWithWidth:(float)width{
    self.poverView = [[UIView alloc]init];
    float heigth = self.dataArray.count *30 +10;
    
    _popoverWidth = width;
    _popverHeight = heigth;
    
    CGRect rect = CGRectMake(0, 0, width, heigth);
    [self.poverView setBounds:rect];
    [self initialPoverTabviewWithFrame:CGRectMake(0, 10, width, heigth-10)];
    [self.poverView setClipsToBounds:YES];
    [self.poverView addSubview:self.poverTableView];
}

#pragma mark disapper
-(void)CancelPover{
    self.hidden = YES;
}


#pragma mark tableviewDelegate________________________________________________________
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = @"poperCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        NSString *item = (NSString *)[self.dataArray objectAtIndex:indexPath.row];
        IBLCellHandler *handler = [[IBLCellHandler alloc]init];
        [handler linkNext];
        cell = [handler getCellWithStyle:UITableViewCellStyleDefault reuseIdentifier:string parms:@{@"type":@(IBLCellHanlerTypePover),@"itemStr":item}];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"pover clicked in row %ld",(long)indexPath.row);
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    [self.delegate poverClickAtIndex:indexPath.row];
    [self.delegate poverDisapper];
    [self removeFromSuperview];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate poverDisapper];
    [self removeFromSuperview];
}

#pragma mark 外部接口_________________________________________________________
-(void)setTouchUnEnableInRow:(NSInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
    IBLPoverViewCell *cell =(IBLPoverViewCell*)[self.poverTableView cellForRowAtIndexPath:index];
    [cell setUnEnable];;
}


-(void)setTouchEnableInRow:(NSInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
    IBLPoverViewCell *cell =(IBLPoverViewCell*)[self.poverTableView cellForRowAtIndexPath:index];
    [cell setEnable];
}


-(void)addToView:(UIView *)supView{
    UIView *poverView = self.poverView;
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [poverView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [supView addSubview:self];
    [self addSubview:poverView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(supView,self,poverView);
    NSString *formateH = @"H:|[self]|";
    NSString *formatV = @"V:|[self]|";
    
    NSString *formatePoverH = @"H:[poverView(==width)]|";
    NSString *formatePoverV = @"V:|[poverView(==height)]";
    
    NSDictionary *metrics = @{@"width":@(_popoverWidth),@"height":@(_popverHeight)};
    
    [supView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formateH options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [supView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatV options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatePoverH options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatePoverV options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
}


-(void)addTriangleAtPoint:(float)point{
    CAShapeLayer *trangleLayer = [CAShapeLayer layer];
    
    [trangleLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [trangleLayer setFrame:CGRectMake(0, 0, 100, 10)];
    [trangleLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(point, 0)];
    [path addLineToPoint:CGPointMake(point-5, 10)];
    [path addLineToPoint:CGPointMake(point+5, 10)];
    [path closePath];
    [path stroke];
    
    [trangleLayer setPath:path.CGPath];
    
    [self.poverView.layer addSublayer:trangleLayer];
}


@end
