//
//  MeetingCellHanler.m
//  Pods
//
//  Created by simpossible on 15/11/22.
//
//

#import "IBLCellHandler.h"
#import "IBLPoverViewCellHandler.h"
@implementation IBLCellHandler


-(UITableViewCell *)getCellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parms:(NSDictionary*)dic{
    NSString *type = dic[@"type"];
    if (type != nil) {
        return [self.nextHandler getCellWithStyle:style reuseIdentifier:reuseIdentifier parms:dic];
    }
    return [[UITableViewCell alloc] init];
}


-(void)linkNext{
self.nextHandler =[[IBLPoverViewCellHandler alloc]init];
    [self.nextHandler linkNext];
}
@end
