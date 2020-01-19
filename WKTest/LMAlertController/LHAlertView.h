//
//  LHAlertView.h
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LHAlertActionStyle) {
    LHAlertActionStyleDefault,//black
    LHAlertActionStyleCancel,
    LHAlertActionStyleDestructive,//blue
};

typedef NS_ENUM(NSUInteger, LHAlertBtnStyle) {
    LHAlertBtnStyleHorizontal,//一个按钮一行
    LHAlertBtnStyleVertical,//black
};

#define KButtonHeight    44

#define KActionSheetBtnHeight    71

#define kAlertViewWidth 280
#define kContentViewEdge 20
#define kContentViewSpace 14

#define kTextLabelSpace  6

#define kButtonTagOffset 1000
#define kButtonSpace     6

#define kTextFieldOffset 10000
#define kTextFieldHeight 29
#define kTextFieldEdge  8
#define KTextFieldBorderWidth 0.5

#define kTitleFont  16

#define kTextFont  13

#define kImagePadding  10

#define RGBHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]



@interface LHAlertAction : NSObject <NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(LHAlertActionStyle)style handler:(void (^)(LHAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) LHAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end


@interface LHAlertView : UIView

@property (nonatomic, weak, readonly) UILabel *titleLable;
@property (nonatomic, weak, readonly) UITextView *messageLabel;

// alertView textfield array
@property (nonatomic, strong, readonly) NSArray *textFieldArray;


@property (nonatomic, assign) CGFloat alertViewWidth;


// default LHAlertBtnStyleVertical
@property (nonatomic, assign) LHAlertBtnStyle  alertBtnStyle;

// contentView space custom
@property (nonatomic, assign) CGFloat contentViewSpace;

// textLabel custom
@property (nonatomic, assign) CGFloat textLabelSpace;
@property (nonatomic, assign) CGFloat textLabelContentViewEdge;

// button custom
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat buttonSpace;
@property (nonatomic, assign) CGFloat buttonContentViewEdge;
@property (nonatomic, assign) CGFloat buttonContentViewTop;
@property (nonatomic, assign) CGFloat buttonCornerRadius;
@property (nonatomic, strong) UIFont *buttonFont;
@property (nonatomic, strong) UIColor *buttonDefaultBgColor;
@property (nonatomic, strong) UIColor *buttonCancelBgColor;
@property (nonatomic, strong) UIColor *buttonDestructiveBgColor;

// textField custom
@property (nonatomic, strong) UIColor *textFieldBorderColor;
@property (nonatomic, strong) UIColor *textFieldBackgroudColor;
@property (nonatomic, strong) UIFont *textFieldFont;
@property (nonatomic, assign) CGFloat textFieldHeight;
@property (nonatomic, assign) CGFloat textFieldEdge;
@property (nonatomic, assign) CGFloat textFieldBorderWidth;
@property (nonatomic, assign) CGFloat textFieldContentViewEdge;

@property (nonatomic, assign) BOOL clickedAutoHide;


+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message;

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message description:(NSString*)description andDescImageName:(NSString*)imageName;

- (void)addAction:(LHAlertAction *)action;

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextView *textField))configurationHandler;

- (void)addClickRange:(NSRange)range andhandle: (void(^)(NSString* string))handle;

@end
