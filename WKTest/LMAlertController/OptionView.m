//
//  OptionView.m
//  TYAlertControllerDemo
//
//  Created by lumi on 2020/1/6.
//  Copyright © 2020 tanyang. All rights reserved.
//

#import "OptionView.h"
#import "LHAlertView.h"
#import "UIView+LHAutoLayout.h"
#import "UIView+LHAlertView.h"


@interface OptionView()

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UIView *buttonContentView;

@property (nonatomic, strong)NSArray *optionsArray;

@property (nonatomic, strong)NSLayoutConstraint *buttonTopConstraint;

@property (nonatomic, assign)NSInteger selectedIndex;

@property (nonatomic, copy) void (^handler)(NSString* option,NSInteger index);

@end

@implementation OptionView


- (instancetype)initWithTitle:(NSString *)title optionsArray:(NSArray *)options
 SelectedIndex:(NSInteger)selectedIndex handler:(void (^)(NSString* option,NSInteger index))handler
{
    if (self = [self init]) {
        
        self.selectedIndex = selectedIndex;
        self.optionsArray = options;
        self.handler = handler;
        [self addContentViews:title];
//
 
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title optionsArray:(NSArray *)options SelectedIndex:(NSInteger)selectedIndex handler:(void (^)(NSString* option,NSInteger index))handler
{
    return [[self alloc]initWithTitle:title optionsArray:options SelectedIndex:selectedIndex handler:handler];
}

- (void)addContentViews:(NSString*)title
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kTextFont];
    titleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
    titleLabel.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    titleLabel.numberOfLines = 0;
    titleLabel.text = title;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UIView *buttonContentView = [[UIView alloc]init];
    buttonContentView.userInteractionEnabled = YES;
    [self addSubview:buttonContentView];
    _buttonContentView = buttonContentView;
    
    [self addButtons];
}


- (void)addButtons
{
    
    for (int i = 0; i< self.optionsArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.optionsArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
        //    button.backgroundColor = [self buttonBgColorWithStyle:action.style];
        [button setBackgroundColor:[UIColor whiteColor]];
//        button.enabled = action.enabled;
        button.tag = i;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitleColor:(i == self.selectedIndex)?  [UIColor colorWithRed:95/255.0 green:167/255.0 blue:254/255.0 alpha:1/1.0]:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonContentView addSubview:button];
    }
    
}

- (void)layoutContentViews
{
    if (!_titleLabel.translatesAutoresizingMaskIntoConstraints) {
      return;
    }
    
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintWithView:_titleLabel topView:self leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsZero];
    [_titleLabel addConstraintWidth:0 height:KButtonHeight];

    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;

    _buttonTopConstraint = [self addConstraintWithTopView:_titleLabel toBottomView:_buttonContentView constant:0];

    [self addConstraintWithView:_buttonContentView topView:nil leftView:self bottomView:self rightView:self edgeInset:UIEdgeInsetsZero];

    //设置圆角
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}

 

- (void)layoutButtons
{
    if (_buttonContentView.subviews.count ==0) {
        return;
    }
    
    UIButton* previewBtn = nil;
    __weak typeof(self) weakself = self;

    for (int i = 0; i< _buttonContentView.subviews.count ; i++) {
       UIButton* obj = _buttonContentView.subviews[i];
       BOOL isLast = (i == (_buttonContentView.subviews.count - 1));
       [weakself.buttonContentView addConstraintWithView:obj topView:previewBtn?nil:self.buttonContentView leftView:weakself.buttonContentView bottomView:isLast?weakself.buttonContentView:nil  rightView:weakself.buttonContentView edgeInset:UIEdgeInsetsZero];
       [weakself.buttonContentView addConstraintWithTopView:previewBtn?previewBtn:nil toBottomView:obj constant:-1];
       [obj addConstraintWidth:0 height:KButtonHeight];
       previewBtn = obj;
    }
//    if (_buttons.count) {
//       _buttonTopConstraint.constant = -_buttonContentViewTop;
//    }
    
}



- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];

        if (_buttonContentView.subviews.count) {
            [self layoutButtons];
        }
    }
}

- (void)actionButtonClicked:(UIButton*)sender
{
    self.handler(self.optionsArray[sender.tag], sender.tag);
    [self hideView];
}


- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textLabel.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _titleLabel = textLabel;
    }
    return _titleLabel;
}


@end
