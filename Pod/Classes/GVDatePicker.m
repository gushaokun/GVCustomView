//
//  CustomDatePicker.m
//  Kaoke
//
//  Created by xiaogu on 14-2-12.
//
//

#import "GVDatePicker.h"
#define DATEHIGHT 216
static GVDatePicker *piker = nil;
@implementation GVDatePicker
+(GVDatePicker*)sharedPicker{
    if (piker == nil) {
        piker = [[GVDatePicker alloc] init];
    }
    return piker;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame           = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        main                 = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width,DATEHIGHT+44)];
        main.backgroundColor = [UIColor whiteColor];
        UIView *bar          = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        bar.backgroundColor  = [UIColor colorWithWhite:0.9 alpha:1];
        [main addSubview:bar];
        UIButton *close                = [UIButton buttonWithType:UIButtonTypeCustom];
//        [close setImage:[UIImage imageNamed:@"bt_cancel"] forState:UIControlStateNormal];
        [close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [close setTitle:@"关闭" forState:UIControlStateNormal];

        [close addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        UIButton *submmite             = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [submmite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submmite setTitle:@"确定" forState:UIControlStateNormal];
        [submmite addTarget:self action:@selector(submite:) forControlEvents:UIControlEventTouchUpInside];
        close.frame                    = CGRectMake(10,0, 44, 44);
        submmite.frame                 = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 44,  0, 44, 44);
        [main addSubview:submmite];
        [main addSubview:close];

        _datePicker                    = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, DATEHIGHT)];
        _datePicker.datePickerMode     = UIDatePickerModeDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [main addSubview:_datePicker];
        [self addSubview:main];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hidden];
}
-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self animatedIn];
}
-(void)animatedIn{
    [UIView animateWithDuration:.35 animations:^{
        CGRect frame = main.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - DATEHIGHT - 44;
        main.frame = frame;
    }];
}
-(void)hidden{
    [self animatedOut];
}
-(void)animatedOut{
    [UIView animateWithDuration:.35 animations:^{
        CGRect frame   = main.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        main.frame     = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)submite:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(changeDateSubmite:)]) {
        [self.delegate performSelector:@selector(changeDateSubmite:) withObject:_datePicker.date];
    }
    [self hidden];
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
