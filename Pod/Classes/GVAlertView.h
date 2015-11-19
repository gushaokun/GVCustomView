//
//  GVAlertView.h
//  msgcopy
//
//  Created by Gavin on 15/4/7.
//  Copyright (c) 2015年 Gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GVAlertView : NSObject
+(instancetype)defaultView;
+(void)showAlert:(NSString*)title message:(NSString*)message confirmButton:(NSString*)confirmTitle action:(void(^)(void))confirmAction cancelTitle:(NSString*)cancelTitle action:(void(^)(void))cancelAction;
@end
