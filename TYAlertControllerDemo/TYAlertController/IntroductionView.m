//
//  OptionView.m
//  TYAlertControllerDemo
//
//  Created by lumi on 2020/1/6.
//  Copyright © 2020 tanyang. All rights reserved.
//

#import "IntroductionView.h"
#import "TYAlertView.h"
#import "UIView+TYAutoLayout.h"
#import "UIView+TYAlertView.h"


@interface IntroductionView()

@property (nonatomic, strong)UILabel *messageLabel;

@property (nonatomic, strong)UIImageView *imagView;

@property (nonatomic, strong)UIButton *righButton;

@property (nonatomic, strong)UIButton *bottomButton;

@property (nonatomic, assign)NSInteger selectedIndex;

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
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    titleLabel.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    titleLabel.numberOfLines = 0;
    titleLabel.text = title;
    [self addSubview:titleLabel];
    _messageLabel = titleLabel;
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:btnName forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.tag = 1;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _bottomButton = button;
    [self addSubview:button];
    
}


- (void)layoutContentViews
{
    [self addConstraintWithView:self.righButton topView:self leftView:nil bottomView:nil rightView:self edgeInset:UIEdgeInsetsZero];
    
    [self addConstraintWithView:self.imagView topView:nil leftView:self  bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, 50, 0, 50)];

    
    [self addConstraintWithView:self.messageLabel topView:nil leftView:self  bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, 50, 0, 50)];

    [self addConstraintWithView:self.imagView topView:nil leftView:self  bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, 50, 0, 50)];

    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintWithView:_messageLabel topView:self leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsZero];
    [_messageLabel addConstraintWidth:0 height:KButtonHeight];

//    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;

    

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
//    if (self.superview) {
//        [self layoutContentViews];
//
//        if (_buttonContentView.subviews.count) {
//            [self layoutButtons];
//        }
//    }
}

- (void)actionButtonClicked:(UIButton*)sender
{
//    self.handler(self.optionsArray[sender.tag], sender.tag);
//    [self hideView];
}

@end
