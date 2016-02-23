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
@property(nonatomic, strong)UILabel * stringLabel;

@property(nonatomic, copy)NSString * itemStr;

@property(nonatomic, copy)NSString * imagename;

@property(nonatomic, strong)UIImageView * iconView;


@end

@implementation IBLPoverViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier params:(NSDictionary*)dic{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSString *item = [dic objectForKey:@"itemStr"];
        NSString *imagename = dic[@"imageName"];
        
        self.itemStr = item;
        self.imagename = imagename;
    }
    
    [self initUI];
    [self cellLayout];
    return  self;
}

-(void)initUI{
    self.stringLabel = [[UILabel alloc]init];
    [self.stringLabel setText:self.itemStr];
    
    
    UIImage *icon = [UIImage imageNamed:self.imagename];
    self.iconView = [[UIImageView alloc]initWithImage:icon];
    [self.iconView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.iconView];
    
}

-(void)cellLayout{
    
    UILabel *strLabel = self.stringLabel;
    UIView * contentV = self.contentView;
    
    [strLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:strLabel];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(strLabel,contentV,_iconView);
    
    float iconWidth = 20;
    float iconHeight = 20;
    
    //图片地址是否为空
    if (![self.imagename isEqualToString:@""]) {
        iconWidth = 20;
    }else{
        iconWidth = 0;
    }
    
    NSDictionary *metric = @{@"iconWidth":@(iconWidth),@"iconHeight":@(iconHeight)};
    
    NSString * itemFormat = @"H:|-5-[_iconView(==iconWidth)]-[strLabel]";
    
    NSString * imageFormateV = @"V:|-4-[_iconView(==iconHeight)]";  ///< 多了一个与下边界的约束 导致报警高
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:imageFormateV options:NSLayoutFormatAlignAllCenterY metrics:metric views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:itemFormat options:NSLayoutFormatAlignAllCenterY metrics:metric views:views]];
    
}

-(void)setUnEnable{
    //    [self.coverView setHidden:NO];
}
-(void)setEnable{
    //    [self.coverView setHidden:YES];
}

@end