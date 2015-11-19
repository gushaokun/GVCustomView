//
//  GVToastView.m
//  toast
//
//  Created by xiaogu on 14-2-7.
//  Copyright (c) 2014年 BeijingMsgcopyTecnology. All rights reserved.
//

#import "GVToastView.h"

#define centerY  [UIApplication sharedApplication].keyWindow.frame.size.height/2.0f



static GVToastView *toastView = nil;
@implementation GVToastView
+(id)sharedToast{
    if (toastView == nil) {
        toastView = [[GVToastView alloc] init];
    }
    return toastView;
}
-(id)init{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor    = [UIColor colorWithWhite:0 alpha:0.8];
        self.numberOfLines      = 4;
        self.font               = [UIFont systemFontOfSize:15];
        self.textColor          = [UIColor whiteColor];
        self.textAlignment      = NSTextAlignmentCenter;
        self.layer.cornerRadius = 10;
        self.clipsToBounds = true;
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor    = [UIColor colorWithWhite:0 alpha:0.8];
        self.font               = [UIFont systemFontOfSize:15] ;
        self.textColor          = [UIColor whiteColor];
        self.numberOfLines      = 4;
        self.textAlignment      = NSTextAlignmentCenter;
        self.layer.cornerRadius = 10;
        self.clipsToBounds = true;
    }
    return self;
}
+(void)showMessage:(NSString *)message in:(UIView*)view{
    if (toastView) {
        toastView = nil;
    }
    if (toastView == nil) {
        toastView = [[GVToastView alloc] init];
    }
    toastView.text = message;
    CGRect frame    = [UIScreen mainScreen].bounds;
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15] };
    CGSize mSize = [message boundingRectWithSize:CGSizeMake(frame.size.width - 40, frame.size.height - 100) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
//    CGSize mSize    = [message sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(frame.size.width-40, frame.size.height-100) lineBreakMode:NSLineBreakByCharWrapping];

    toastView.frame = CGRectMake((frame.size.width-mSize.width)/2-5, centerY,mSize.width+10 , mSize.height+10);
    [view addSubview:toastView];
    [toastView show];
}
+(void)showMessageOnWindow:(NSString *)message{
    if (toastView) {
        toastView = nil;
    }
    if (toastView == nil) {
        toastView = [[GVToastView alloc] init];
    }
    toastView.text  = message;
    CGRect frame    = [UIScreen mainScreen].bounds;
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15] };
    CGSize mSize = [message boundingRectWithSize:CGSizeMake(frame.size.width - 40, frame.size.height - 100) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
//    CGSize mSize    = [message sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(frame.size.width-40, frame.size.height-100) lineBreakMode:NSLineBreakByCharWrapping];
    toastView.frame = CGRectMake((frame.size.width-mSize.width)/2-10, centerY,mSize.width+20 , mSize.height+10);
    [toastView show];
}
-(void)show{
     UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [UIView setAnimationDuration:1.8];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hidden)];
    self.alpha = 1;
    [UIView commitAnimations];
}
-(void)hidden{

    [UIView animateWithDuration:1.8 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
