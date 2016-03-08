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

@property(nonatomic, assign)float triangleHeight;

@property(nonatomic, assign)float trianglePercent;

@property(nonatomic, assign)float leftMargin;

@property(nonatomic, assign)float rightMargin;

@property(nonatomic, assign)float tableWidth;

@property(nonatomic, strong)CAShapeLayer * triangleLayer;

@property(nonatomic, strong)NSMutableArray * images; //图片名称们

@property(nonatomic, strong)NSArray * horizonConstrains;

@end



@implementation IBLPopver


-(instancetype)initWithTableWidth:(float)width andItems:(NSArray *)items{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self initialDatas];
        _width = width;
    }
    self.dataArray = items;
    
    [self initialPoverViewWithWidth:width];
    [self addTriangleAtPoint:width*_trianglePercent];
    
    return self;
}

- (instancetype)initWithTableWidth:(float)width andItems:(NSArray*)items andImageNames:(NSArray*)images{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _width = width;
        [self initialDatas];
       
    }
    self.dataArray = items;
    self.images = [NSMutableArray arrayWithArray:images];
    
    [self initialPoverViewWithWidth:width];
    [self addTriangleAtPoint:width*_trianglePercent];
    
    return self;
}

- (void)initialDatas {
    _triangleHeight = 10;
    self.trianglePercent = 0.68;
    _rightMargin = 0;
    _itemHeight = 44;//默认值
}

#pragma mark UI初始化 -
-(void)initialPoverTabviewWithFrame:(CGRect)frame {
    self.poverTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.poverTableView setDelegate:self];
    [self.poverTableView setDataSource:self];
    [self.poverTableView setBackgroundColor:[UIColor whiteColor]];
    [[self.poverTableView layer]setCornerRadius:2];
    [self.poverTableView setScrollEnabled:NO];
}


-(void)initialPoverViewWithWidth:(float)width{
    self.poverView = [[UIView alloc]init];
    float heigth = self.dataArray.count *30 +_triangleHeight;
    
    _popoverWidth = width;
    _popverHeight = heigth;
    
    CGRect rect = CGRectMake(0, 0, width, heigth);
    [self.poverView setBounds:rect];
    
    
    [self initialPoverTabviewWithFrame:CGRectMake(0, _triangleHeight, width, heigth-_triangleHeight)];
    [self.poverView setClipsToBounds:YES];
    [self.poverView addSubview:self.poverTableView];
}

//重置table的size
- (void)resetTableFrame{
    float heigth = self.dataArray.count *30 +_triangleHeight;
    [self.poverTableView setFrame:CGRectMake(0, _triangleHeight, _popoverWidth, heigth-_triangleHeight)];
}

#pragma mark 外部布局接口 -
- (void)setPositionWithLeftMargin:(float)left{
    _rightMargin = left;
    [self drawRect:self.bounds];
}

- (void)setTriangleHeight:(float)height{
    if (height>0) {
        _triangleHeight = height;
    }
    [self resetTableFrame];
    if (self.triangleLayer) {
        [self.triangleLayer removeFromSuperlayer];
        self.triangleLayer = nil;
    }
    [self addTriangleAtPoint:_trianglePercent*_popoverWidth];
    [self drawRect:self.bounds];
}

- (void)setTrianglePersent:(float)persent{
    if (persent>1 || persent< 0) {
        return;
    }
    _trianglePercent = persent;
    [self addTriangleAtPoint:persent*_popoverWidth];
    [self drawRect:self.bounds];
}

#pragma mark disapper -


#pragma mark tableviewDelegate________________________________________________________
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemHeight;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = @"poperCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        NSString *item = (NSString *)[self.dataArray objectAtIndex:indexPath.row];
        
        NSString *image;
        if (self.images) {
            image  = (NSString *)[self.images objectAtIndex:indexPath.row];
        }else{
            image = @"";
            IBLPoverViewCellHandler *handler = [[IBLPoverViewCellHandler alloc]init];
            [handler linkNext];
            cell = [handler getCellWithStyle:UITableViewCellStyleDefault reuseIdentifier:string parms:@{@"type":@(IBLCellHanlerTypePover),@"itemStr":item,@"imageName":image}];
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    if ([self.delegate respondsToSelector:@selector(popover:clickAtIndex:)]) {
        [self.delegate popover:self clickAtIndex:indexPath.row];
    }
    if ([self.delegate respondsToSelector:@selector(poverClickAtIndex:)]) {
        [self.delegate poverClickAtIndex:indexPath.row];
    }
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

//重写设置方法
- (void)setItemHeight:(NSInteger)height {
    if (height > 0) {
        _itemHeight = height;
        if (self.superview) {
            [self.poverTableView reloadData];
        }
    }
}
@end
