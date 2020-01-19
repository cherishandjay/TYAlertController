//
//  OptionView.m
//  TYAlertControllerDemo
//
//  Created by lumi on 2020/1/6.
//  Copyright © 2020 tanyang. All rights reserved.
//

#import "IntroductionView.h"
#import "LHAlertView.h"
#import "UIView+LHAutoLayout.h"
#import "UIView+LHAlertView.h"


@interface IntroductionView()

@property (nonatomic, strong)UILabel *messageLabel;

@property (nonatomic, strong)UIImageView *imagView;

@property (nonatomic, strong)UIButton *righButton;

@property (nonatomic, strong)UIButton *bottomButton;

@property (nonatomic, copy) void (^handler)(NSInteger isBottomBtn);

@end

@implementation IntroductionView


- (instancetype)initWithTitle:(NSString *)title imageName:(NSString*)imageName buttonName:(NSString*)btnName handler:(void (^)(NSInteger isBottomBtn))handler
{
    if (self = [self init]) {
        
         self.handler = handler;
        [self addContentViews:title imageName:imageName buttonName:btnName];
//
 
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title imageName:(NSString*)imageName buttonName:(NSString*)btnName handler:(void (^)(NSInteger isBottomBtn))handler
{
    return [[self alloc]initWithTitle:title imageName:imageName buttonName:btnName handler:handler];
}

- (void)addContentViews:(NSString*)title imageName:(NSString*)imageName buttonName:(NSString*)btnName
{
    //righttop button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    button.tag = 0;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.righButton = button;
    [self addSubview:button];
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    self.imagView = imageView;
    [self addSubview:imageView];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:kTextFont];
    titleLabel.numberOfLines = 0;
    titleLabel.text = title;
    [self addSubview:titleLabel];
    _messageLabel = titleLabel;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:btnName forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.tag = 1;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitleColor: [UIColor colorWithRed:95/255.0 green:167/255.0 blue:254/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bottomButton = button;
    [self addSubview:button];
}


- (void)layoutContentViews
{
    _righButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintWithView:self.righButton topView:self leftView:nil bottomView:nil rightView:self edgeInset:UIEdgeInsetsZero];
    [_righButton addConstraintWidth:KButtonHeight height:KButtonHeight];

    _imagView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintCenterXToView:self.imagView centerYToView:nil];
    [self addConstraintWithTopView:_righButton toBottomView:_imagView constant:KButtonHeight/2];
    [_messageLabel addConstraintWidth:KButtonHeight*2 height:KButtonHeight*2];

    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintWithTopView:self.imagView toBottomView:_messageLabel constant:KButtonHeight/2];
    [self addConstraintWithView:self.messageLabel topView:nil leftView:self  bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_messageLabel addConstraintWidth:0 height:KButtonHeight];
    
    _bottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintWithTopView:self.messageLabel toBottomView:_bottomButton constant:KButtonHeight/2];
    [self addConstraintWithView:_bottomButton topView:nil leftView:self bottomView:self rightView:self edgeInset:UIEdgeInsetsZero];
    [_bottomButton addConstraintWidth:0 height:KButtonHeight];

    //设置圆角
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}

 

- (void)layoutButtons
{
//    if (_buttonContentView.subviews.count ==0) {
//        return;
//    }
//
//    UIButton* previewBtn = nil;
//    __weak typeof(self) weakself = self;
//
//    for (int i = 0; i< _buttonContentView.subviews.count ; i++) {
//       UIButton* obj = _buttonContentView.subviews[i];
//       BOOL isLast = (i == (_buttonContentView.subviews.count - 1));
//       [weakself.buttonContentView addConstraintWithView:obj topView:previewBtn?nil:self.buttonContentView leftView:weakself.buttonContentView bottomView:isLast?weakself.buttonContentView:nil  rightView:weakself.buttonContentView edgeInset:UIEdgeInsetsZero];
//       [weakself.buttonContentView addConstraintWithTopView:previewBtn?previewBtn:nil toBottomView:obj constant:-1];
//       [obj addConstraintWidth:0 height:KButtonHeight];
//       previewBtn = obj;
//    }
//    if (_buttons.count) {
//       _buttonTopConstraint.constant = -_buttonContentViewTop;
//    }
    
}



- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
    }
}

- (void)actionButtonClicked:(UIButton*)sender
{
//    self.handler(self.optionsArray[sender.tag], sender.tag);
//    [self hideView];
}

@end
