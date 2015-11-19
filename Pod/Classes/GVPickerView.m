//
//  GroupPickerView.m
//  msgcopy
//
//  Created by Gavin on 15/7/9.
//  Copyright (c) 2015年 Gavin. All rights reserved.
//

#import "GVPickerView.h"
#define DATEHIGHT 216
static GVPickerView *piker = nil;

@implementation GVPickerView
+(GVPickerView*)sharedPicker{
    if (piker == nil) {
        piker = [[GVPickerView alloc] init];
    }
    return piker;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.frame                     = [UIScreen mainScreen].bounds;
        self.backgroundColor           = [UIColor colorWithWhite:0 alpha:0.3];
        main                           = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width,DATEHIGHT+44)];
        main.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        main.backgroundColor           = [UIColor whiteColor];
        UIView *bar                    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        bar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [bar addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:main attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        bar.backgroundColor            = [UIColor colorWithWhite:0.9 alpha:1];
        [main addSubview:bar];
        UIButton *close                = [UIButton buttonWithType:UIButtonTypeCustom];
        [close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [close setTitle:@"关闭" forState:UIControlStateNormal];
        [close addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        close.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        UIButton *submmite             = [UIButton buttonWithType:UIButtonTypeCustom];
        [submmite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submmite setTitle:@"确定" forState:UIControlStateNormal];
        [submmite addTarget:self action:@selector(submite:) forControlEvents:UIControlEventTouchUpInside];
        close.frame                    = CGRectMake(10,0, 44, 44);
        submmite.frame                 = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 44,  0, 44, 44);
        submmite.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [main addSubview:submmite];
        [main addSubview:close];
        _picker                    = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, DATEHIGHT)];
        _picker.dataSource         = self;
        _picker.delegate           = self;
        [main addSubview:_picker];
        [self addSubview:main];
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if ([_delegate respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
           return [_delegate numberOfComponentsInPickerView:self];
    }
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_delegate pickerView:self numberOfRowsInComponent:component];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_delegate pickerView:self titleForRow:row forComponent:component];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    curIndexPath = [NSIndexPath indexPathForRow:row inSection:component];
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
        CGRect frame   = main.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - DATEHIGHT - 44;
        main.frame     = frame;
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
    if ([self.delegate respondsToSelector:@selector(changePickerSubmite:)]) {
        [self.delegate performSelector:@selector(changePickerSubmite:) withObject:curIndexPath];
    }
    [self hidden];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
