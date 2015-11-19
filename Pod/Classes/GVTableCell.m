//
//  MsgTableCell.m
//  msgcopy
//
//  Created by Gavin on 15/5/20.
//  Copyright (c) 2015年 Gavin. All rights reserved.
//

#import "GVTableCell.h"

@implementation GVTableCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:.5].CGColor);
    CGContextStrokeRect(context, CGRectMake(_lineLeftInset, rect.size.height, rect.size.width - _lineLeftInset - _lineRightInset, 1/[UIScreen mainScreen].scale));
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
