//
//  MeetingCellHanler.h
//  Pods
//
//  Created by simpossible on 15/11/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
IBLCellHanlerTypePover,
}IBLCellHanlerType;

@interface IBLCellHandler : NSObject

/**
 *下一个处理节点
 */
@property(nonatomic,strong)IBLCellHandler *nextHandler;

/**
 *字典中必须要有type字段，值为MeetingCellHanlerType
 */
-(UITableViewCell *)getCellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parms:(NSDictionary*)dic;

/**
 *指定下一个节点
 */
-(void)linkNext;
@end
