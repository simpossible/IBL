//
//  PoverViewCellHandler.h
//  Pods
//
//  Created by simpossible on 15/12/10.
//
//

#import "IBLCellHandler.h"

@interface IBLPoverViewCellHandler : IBLCellHandler
-(UITableViewCell *)getCellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parms:(NSDictionary *)dic;
@end


@interface IBLPoverViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier params:(NSDictionary*)dic;

-(void)setEnable;
@end