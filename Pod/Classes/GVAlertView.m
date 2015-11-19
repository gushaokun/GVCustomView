//
//  GVAlertView.m
//  msgcopy
//
//  Created by Gavin on 15/4/7.
//  Copyright (c) 2015年 Gavin. All rights reserved.
//

#import "GVAlertView.h"

@interface GVAlertView()<UIAlertViewDelegate>

@property(nonatomic,retain)UIAlertView *alertView;
@property(nonatomic,copy)void(^actionConfirm)(void);
@property(nonatomic,copy)void(^actionCancel)(void);

@end


@implementation GVAlertView
+(instancetype)defaultView
{
    static GVAlertView *alert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert = [[GVAlertView alloc] init];
    });
    return alert;

}
+(void)showAlert:(NSString*)title message:(NSString*)message confirmButton:(NSString*)confirmTitle action:(void(^)(void))confirmAction cancelTitle:(NSString*)cancelTitle action:(void(^)(void))cancelAction
{
    GVAlertView *alert = [GVAlertView defaultView];
    if (alert.alertView) {
        alert.alertView = nil;
    }
    alert.actionConfirm = confirmAction;
    alert.actionCancel = cancelAction;
    alert.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:alert cancelButtonTitle:confirmTitle otherButtonTitles:cancelTitle, nil];
    [alert.alertView show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([GVAlertView defaultView].actionConfirm) {
            [GVAlertView defaultView].actionConfirm();
        }
    }else if(buttonIndex == 1){
        
        if ([GVAlertView defaultView].actionCancel) {
            [GVAlertView defaultView].actionCancel();
        }
    }
}
@end
