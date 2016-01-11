//
//  PoverViewCellHandler.m
//  Pods
//
//  Created by simpossible on 15/12/10.
//
//

#import "IBLPoverViewCellHandler.h"

@implementation IBLPoverViewCellHandler
-(UITableViewCell *)getCellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parms:(NSDictionary *)dic{
    NSString *type = [dic objectForKey:@"type"];
    if (type.intValue == IBLCellHanlerTypePover) {
        return [[IBLPoverViewCell alloc]initWithStyle:style reuseIdentifier:reuseIdentifier params:dic];
    }
    
    if (self.nextHandler) {
        return [self.nextHandler getCellWithStyle:style reuseIdentifier:reuseIdentifier parms:dic];
    }
    return nil;
}
-(void)linkNext{
    NSLog(@"end_cell_link");
}
@end




@interface IBLPoverViewCell ()
@property(nonatomic,strong)UILabel * stringLabel;

@property(nonatomic,copy)NSString * itemStr;

@end

@implementation IBLPoverViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier params:(NSDictionary*)dic{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSString *item = [dic objectForKey:@"itemStr"];
        self.itemStr = item;
    }
    
    [self initUI];
    [self cellLayout];
    return  self;
}

-(void)initUI{
    self.stringLabel = [[UILabel alloc]init];
    [self.stringLabel setText:self.itemStr];
}

-(void)cellLayout{
    
    UILabel *strLabel = self.stringLabel;
    [strLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:strLabel];
    
    UIView * contentV = self.contentView;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(strLabel,contentV);
    NSString * itemFormat = @"H:|-30-[strLabel]";
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:strLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentV attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:itemFormat options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.contentView addConstraint:centerY];

    
}

-(void)setEnable{
}

@end