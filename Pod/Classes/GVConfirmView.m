//
//  GVConfirmView.m
//  msgcopy
//
//  Created by Gavin on 15/4/7.
//  Copyright (c) 2015年 Gavin. All rights reserved.
//

#import "GVConfirmView.h"

@interface GVConfirmView()<UIActionSheetDelegate>
@property(nonatomic,retain)UIActionSheet *actionSheet;
@property(nonatomic,copy)void(^actionConfirm)(void);
@property(nonatomic,copy)void(^actionCancel)(void);
@property(nonatomic,copy)void(^actionOther)(void);

@end


@implementation GVConfirmView

+(instancetype)defaultView
{
    static GVConfirmView *confirm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        confirm = [[GVConfirmView alloc] init];
    });
    return confirm;
}
+(void)showConfirm:(NSString*)title inView:(UIView*)view confirmButton:(NSString*)confirmTitle action:(void(^)(void))confirmAction otherTitle:(NSString*)otherTitle action:(void(^)(void))otherAction cancelTitle:(NSString*)cancelTitle action:(void(^)(void))cancelAction
{
    GVConfirmView *confirmView = [GVConfirmView defaultView];
    if (confirmView.actionSheet) {
        confirmView.actionSheet = nil;
    }
    confirmView.actionConfirm = confirmAction;
    confirmView.actionCancel = cancelAction;
    confirmView.actionOther = otherAction;

    confirmView.actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:confirmView cancelButtonTitle:cancelTitle destructiveButtonTitle:confirmTitle otherButtonTitles:otherTitle, nil];
    [confirmView.actionSheet showInView:view];
    
}

+(void)showConfirm:(NSString*)title inView:(UIView*)view confirmButton:(NSString*)confirmTitle action:(void(^)(void))confirmAction cancelTitle:(NSString*)cancelTitle action:(void(^)(void))cancelAction
{
    GVConfirmView *confirmView = [GVConfirmView defaultView];
    if (confirmView.actionSheet) {
        confirmView.actionSheet = nil;
    }
    
    confirmView.actionConfirm = confirmAction;
    confirmView.actionCancel = cancelAction;
    confirmView.actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:confirmView cancelButtonTitle:cancelTitle destructiveButtonTitle:confirmTitle otherButtonTitles:nil, nil];
    [confirmView.actionSheet showInView:view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([GVConfirmView defaultView].actionConfirm) {
            [GVConfirmView defaultView].actionConfirm();
        }
    }else if(buttonIndex == 1){
        if (actionSheet.numberOfButtons>2) {
            if ([GVConfirmView defaultView].actionOther) {
                [GVConfirmView defaultView].actionOther();
            }
            return;
        }
        if ([GVConfirmView defaultView].actionCancel) {
            [GVConfirmView defaultView].actionCancel();
        }
    }else if(buttonIndex == 2){
        if ([GVConfirmView defaultView].actionCancel) {
            [GVConfirmView defaultView].actionCancel();
        }

    }
}
@end
