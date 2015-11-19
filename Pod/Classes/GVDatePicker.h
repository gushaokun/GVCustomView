//
//  CustomDatePicker.h
//  Kaoke
//
//  Created by xiaogu on 14-2-12.
//
//

#import <UIKit/UIKit.h>

@protocol GVDatePickerDelegate <NSObject>
-(void)changeDateSubmite:(NSDate*)date;
@end

@interface GVDatePicker : UIView{
    UIView *main;
}
-(void)show;
+(GVDatePicker*)sharedPicker;
@property (nonatomic,assign) id<GVDatePickerDelegate> delegate;
@property (nonatomic,retain) UIDatePicker *datePicker;
@end
