//
//  TYAlertView.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertView.h"
#import "UIView+TYAlertView.h"
#import "UIView+TYAutoLayout.h"

@interface TYAlertAction ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) TYAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(TYAlertAction *);
@end

@implementation TYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(TYAlertActionStyle)style handler:(void (^)(TYAlertAction *))handler
{
    return [[self alloc]initWithTitle:title style:style handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(TYAlertActionStyle)style handler:(void (^)(TYAlertAction *))handler
{
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = handler;
        _enabled = YES;
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    TYAlertAction *action = [[self class]allocWithZone:zone];
    action.title = self.title;
    action.style = self.style;
    return action;
}

@end


@interface TYAlertView ()<UITextViewDelegate>

// text content View
@property (nonatomic, weak) UIView *textContentView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UITextView *messageLabel;


@property (nonatomic, copy) NSMutableAttributedString *messageAttributeString;
@property (nonatomic, copy) void (^handler)(NSString* string);

@property (nonatomic, strong) NSMutableDictionary *urlClickDic;

@property (nonatomic, weak) UIView *textFieldContentView;
@property (nonatomic, weak) NSLayoutConstraint *textFieldTopConstraint;
@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, strong) NSMutableArray *textFieldSeparateViews;


//image he 文字
@property (nonatomic, weak) UIView *imagetextContentView;
@property (nonatomic, strong) NSLayoutConstraint *imageTextTopConstraint;
@property (nonatomic, strong) UIImageView *descImageView;
@property (nonatomic, strong) UILabel *descLabel;


// button content View
@property (nonatomic, weak) UIView *buttonContentView;
@property (nonatomic, weak) NSLayoutConstraint *buttonTopConstraint;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *actions;

@end

#define kAlertViewWidth 280
#define kContentViewEdge 15
#define kContentViewSpace 15

#define kTextLabelSpace  6

#define kButtonTagOffset 1000
#define kButtonSpace     6

#define kTextFieldOffset 10000
#define kTextFieldHeight 29
#define kTextFieldEdge  8
#define KTextFieldBorderWidth 0.5


@implementation TYAlertView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
       
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [self init]) {
        
        [self configureProperty];
               
        [self addContentViews];
               
        [self addTextLabels:title message:message];
        
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message
{
    return [[self alloc]initWithTitle:title message:message];
}

#pragma mark - configure

- (void)configureProperty
{
    _clickedAutoHide = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    _alertBtnStyle = LHAlertBtnStyleVertical;
    _alertViewWidth = kAlertViewWidth;
    _contentViewSpace = kContentViewSpace;
    
    _textLabelSpace = kTextLabelSpace;
    _textLabelContentViewEdge = kContentViewEdge;
    
    _buttonHeight = KButtonHeight;
    _buttonSpace = kButtonSpace;
    _buttonContentViewEdge = kContentViewEdge;
    _buttonContentViewTop = kContentViewSpace;
    _buttonCornerRadius = 4.0;
    _buttonFont = [UIFont fontWithName:@"HelveticaNeue" size:18];
    _buttonDefaultBgColor = [UIColor blackColor];
    _buttonCancelBgColor = [UIColor lightGrayColor];
    _buttonDestructiveBgColor = [UIColor blueColor];
    
    _textFieldHeight = kTextFieldHeight;
    _textFieldEdge = kTextFieldEdge;
    _textFieldBorderWidth = KTextFieldBorderWidth;
    _textFieldContentViewEdge = kContentViewEdge;
    
    _textFieldBorderColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    _textFieldBackgroudColor = [UIColor whiteColor];
    _textFieldFont = [UIFont systemFontOfSize:14];
    
    _buttons = [NSMutableArray array];
    _actions = [NSMutableArray array];
}

- (UIColor *)buttonBgColorWithStyle:(TYAlertActionStyle)style
{
    switch (style) {
        case TYAlertActionStyleDefault:
            return _buttonDefaultBgColor;
        case TYAlertActionStyleCancel:
            return _buttonCancelBgColor;
        case TYAlertActionStyleDestructive:
            return _buttonDestructiveBgColor;
            
        default:
            return nil;
    }
}

#pragma mark - add contentview

- (void)addContentViews
{
    UIView *textContentView = [[UIView alloc]init];
    [self addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFieldContentView = [[UIView alloc]init];
    [self addSubview:textFieldContentView];
    _textFieldContentView = textFieldContentView;
    
    UIView *imageDescContentView = [[UIView alloc]init];
    [self addSubview:imageDescContentView];
    _imagetextContentView = imageDescContentView;
    
    UIView *buttonContentView = [[UIView alloc]init];
    buttonContentView.userInteractionEnabled = YES;
//    buttonContentView.layer.borderColor = [UIColor blackColor].CGColor;
//    buttonContentView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    [self addSubview:buttonContentView];
    _buttonContentView = buttonContentView;
}

- (void)addTextLabels:(NSString*)title message:(NSString*)message
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    titleLabel.numberOfLines = 0;
    titleLabel.text = title;
    [_textContentView addSubview:titleLabel];
    _titleLable = titleLabel;

    _messageAttributeString = [[NSMutableAttributedString alloc]initWithString:message];
//    [self.messageAttributeString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} range:range];

    
    UITextView *messageLabel = [[UITextView alloc]init];
    messageLabel.delegate = self;
    messageLabel.editable = NO;        // 禁止输入，否则会弹出输入键盘
    messageLabel.scrollEnabled = NO;   // 可选的，视具体情况而定
    messageLabel.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
    messageLabel.textContainer.lineFragmentPadding = 0;
//    messageLabel.textContainerInset = UIEdgeInsetsMake(15, 0, 0, 0);
//    messageLabel.numberOfLines = 0;
//    messageLabel.textAlignment = NSTextAlignmentCenter;
//    messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
//    messageLabel.textColor = [UIColor lightGrayColor];
    [_textContentView addSubview:messageLabel];
    messageLabel.attributedText = _messageAttributeString;
    _messageLabel = messageLabel;

}


- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
        [self layoutTextLabels];
//        if (_buttons.count == 1) {
//               [self layoutContentViews];
//               [self layoutTextLabels];
//           }
        if (_buttons.count) {
            [self layoutButtons];
        }
    }
}

- (void)addAction:(TYAlertAction *)action
{
    
    if (self.alertBtnStyle == LHAlertBtnStyleHorizontal && _buttons.count >=2 ) {
        return;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    [button setTitle:action.title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
//    button.backgroundColor = [self buttonBgColorWithStyle:action.style];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.enabled = action.enabled;
    button.tag = kButtonTagOffset + _buttons.count;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitleColor:[self buttonBgColorWithStyle:action.style] forState:UIControlStateNormal];
    button.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonContentView addSubview:button];
    [_buttons addObject:button];
    [_actions addObject:action];
    
}

- (void)addImage:(NSString*)imageName andDescString:(NSString*)desc
{
    self.descImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [_imagetextContentView addSubview:self.descImageView];

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.numberOfLines = 0;
    [_imagetextContentView addSubview:titleLabel];
    _descLabel = titleLabel;
    _descLabel.text = desc;
    
    [self layoutImageAndDesc];
}

- (void)addClickRange:(NSRange)range andhandle: (void(^)(NSString* string))handle{
    if (!self.urlClickDic) {
        self.urlClickDic = [NSMutableDictionary dictionary];
    }
    
    //click1
    NSString* value = @"click";
    [value stringByAppendingString:[NSString stringWithFormat:@"%lu",(unsigned long)self.urlClickDic.allKeys.count]];
    
    [self.messageAttributeString addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@://",value] range:range];
    
    [self.urlClickDic setValue:handle forKey:value];
    self.messageLabel.attributedText = self.messageAttributeString;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
    NSString* value = [URL scheme];
    if (self.urlClickDic[value]) {
        NSAttributedString *abStr = [textView.attributedText attributedSubstringFromRange:characterRange];
        self.handler  = self.urlClickDic[value];
        self.handler(abStr.string);
        return NO;
    }
    return YES;
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler
{
    if (_textFields == nil) {
        _textFields = [NSMutableArray array];
    }
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = kTextFieldOffset + _textFields.count;
    textField.font = _textFieldFont;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (configurationHandler) {
        configurationHandler(textField);
    }
    
    [_textFieldContentView addSubview:textField];
    [_textFields addObject:textField];
    
    if (_textFields.count > 1) {
        if (_textFieldSeparateViews == nil) {
            _textFieldSeparateViews = [NSMutableArray array];
        }
        UIView *separateView = [[UIView alloc]init];
        separateView.backgroundColor = _textFieldBorderColor;
        separateView.translatesAutoresizingMaskIntoConstraints = NO;
        [_textFieldContentView addSubview:separateView];
        [_textFieldSeparateViews addObject:separateView];
    }
    
    [self layoutTextFields];
}

- (NSArray *)textFieldArray
{
    return _textFields;
}

#pragma mark - layout contenview

- (void)layoutContentViews
{
    if (!_textContentView.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    if (_alertViewWidth) {
        [self addConstraintWidth:_alertViewWidth height:0];
    }
    
    // textContentView
    _textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraintWithView:_textContentView topView:self leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake((_titleLable.text.length ||_messageLabel.text.length)?_contentViewSpace:0, _textLabelContentViewEdge, 0, -_textLabelContentViewEdge)];
    
    // textFieldContentView
    _textFieldContentView.translatesAutoresizingMaskIntoConstraints = NO;
    //有子view再设置vertical padding.
    _textFieldTopConstraint = [self addConstraintWithTopView:_textContentView toBottomView:_textFieldContentView constant:_textFieldContentView.subviews.count? (_buttonContentViewTop):0];
    
    [self addConstraintWithView:_textFieldContentView topView:nil leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, _textFieldContentViewEdge, 0, -_textFieldContentViewEdge)];
    
    _imagetextContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageTextTopConstraint = [self addConstraintWithTopView:_textFieldContentView toBottomView:_imagetextContentView constant:self.imagetextContentView.subviews.count? (_buttonContentViewTop):0];
  
    [self addConstraintWithView:_imagetextContentView topView:nil leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, _textFieldContentViewEdge, 0, -_textFieldContentViewEdge)];

    
    // buttonContentView
    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _buttonTopConstraint = [self addConstraintWithTopView:_imagetextContentView toBottomView:_buttonContentView constant:0];
    
    [self addConstraintWithView:_buttonContentView topView:nil leftView:self bottomView:self rightView:self edgeInset:UIEdgeInsetsZero];
    
    
    //设置圆角
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
}

- (void)layoutTextLabels
{
    if (!_titleLable.translatesAutoresizingMaskIntoConstraints && _messageLabel.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    // title
    _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstraintWithView:_titleLable topView:_textContentView leftView:_textContentView bottomView:nil rightView:_textContentView edgeInset:UIEdgeInsetsZero];
    
    // message
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstraintWithTopView:_titleLable toBottomView:_messageLabel constant:(_titleLable.text.length && _messageLabel.text.length)? _textLabelSpace:0];
    [_textContentView addConstraintWithView:_messageLabel topView:nil leftView:_textContentView bottomView:_textContentView rightView:_textContentView edgeInset:UIEdgeInsetsZero];
}

- (void)layoutButtons
{
    if (self.alertBtnStyle == LHAlertBtnStyleVertical) {
        UIButton* previewBtn = nil;
        __weak typeof(self) weakself = self;
        
        for (int i = 0; i< _buttons.count ; i++) {
            UIButton* obj = _buttons[i];
            BOOL isLast = (i == (_buttons.count-1));
            [weakself.buttonContentView addConstraintWithView:obj topView:previewBtn?nil:self.buttonContentView leftView:weakself.buttonContentView bottomView:isLast?weakself.buttonContentView:nil  rightView:weakself.buttonContentView edgeInset:UIEdgeInsetsZero];
            [weakself.buttonContentView addConstraintWithTopView:previewBtn?previewBtn:nil toBottomView:obj constant:-1];
            [obj addConstraintWidth:0 height:_buttonHeight];
            previewBtn = obj;
        }
        
        if (_buttons.count) {
            _buttonTopConstraint.constant = -_buttonContentViewTop;
        }
    }else{
        
        UIButton *button = _buttons.lastObject;
        if (_buttons.count == 1) {
            _buttonTopConstraint.constant = -_buttonContentViewTop;
            [_buttonContentView addConstraintToView:button edgeInset:UIEdgeInsetsZero];
            [button addConstraintWidth:0 height:_buttonHeight];
        }else if (_buttons.count >= 2) {
            UIButton *firstButton = _buttons.firstObject;
            _buttonTopConstraint.constant = -_buttonContentViewTop;
            [_buttonContentView addConstraintToView:firstButton edgeInset:UIEdgeInsetsZero];
            [firstButton addConstraintWidth:0 height:_buttonHeight];
            [_buttonContentView removeConstraintWithView:firstButton attribute:NSLayoutAttributeRight];
            [_buttonContentView addConstraintWithView:button topView:_buttonContentView leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
            [_buttonContentView addConstraintWithLeftView:firstButton toRightView:button constant:-1];
            [_buttonContentView addConstraintEqualWithView:button widthToView:firstButton heightToView:firstButton];
        }else {
            if (_buttons.count == 3) {
                UIButton *firstBtn = _buttons[0];
                UIButton *secondBtn = _buttons[1];
                [_buttonContentView removeConstraintWithView:firstBtn attribute:NSLayoutAttributeRight];
                [_buttonContentView removeConstraintWithView:firstBtn attribute:NSLayoutAttributeBottom];
                [_buttonContentView removeConstraintWithView:secondBtn attribute:NSLayoutAttributeTop];
                [_buttonContentView addConstraintWithView:firstBtn topView:nil leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
                [_buttonContentView addConstraintWithTopView:firstBtn toBottomView:secondBtn constant:_buttonSpace];
                
            }
            
            UIButton *lastSecondBtn = _buttons[_buttons.count - 2];
            [_buttonContentView removeConstraintWithView:lastSecondBtn attribute:NSLayoutAttributeBottom];
            [_buttonContentView addConstraintWithTopView:lastSecondBtn toBottomView:button constant:_buttonSpace];
            [_buttonContentView addConstraintWithView:button topView:nil leftView:_buttonContentView bottomView:_buttonContentView rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
            [_buttonContentView addConstraintEqualWithView:button widthToView:nil heightToView:lastSecondBtn];
        }
    }
}


- (void)layoutImageAndDesc
{
    
    if (!self.descImageView.translatesAutoresizingMaskIntoConstraints && !self.descLabel.translatesAutoresizingMaskIntoConstraints) {
          // layout done
          return;
      }
      // title
    _descImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imagetextContentView addConstraintWithView:self.descImageView topView:self.imagetextContentView leftView:self.imagetextContentView bottomView:nil rightView:self.imagetextContentView edgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.imagetextContentView addConstraintWithTopView:self.descImageView toBottomView:self.descLabel constant:0];

    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [self.imagetextContentView addConstraintWithView:self.descLabel topView:nil leftView:self.imagetextContentView bottomView:self.imagetextContentView rightView:self.imagetextContentView edgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)layoutTextFields
{
    UITextField *textField = _textFields.lastObject;
    
    if (_textFields.count == 1) {
        // setup textFieldContentView
        _textFieldContentView.backgroundColor = _textFieldBackgroudColor;
        _textFieldContentView.layer.masksToBounds = YES;
        _textFieldContentView.layer.cornerRadius = 4;
        _textFieldContentView.layer.borderWidth = _textFieldBorderWidth;
        _textFieldContentView.layer.borderColor = _textFieldBorderColor.CGColor;
        [_textFieldContentView addConstraintToView:textField edgeInset:UIEdgeInsetsMake(_textFieldBorderWidth, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [textField addConstraintWidth:0 height:_textFieldHeight];
    }else {
        // textField
        UITextField *lastSecondTextField = _textFields[_textFields.count - 2];
        [_textFieldContentView removeConstraintWithView:lastSecondTextField attribute:NSLayoutAttributeBottom];
        [_textFieldContentView addConstraintWithTopView:lastSecondTextField toBottomView:textField constant:_textFieldBorderWidth];
        [_textFieldContentView addConstraintWithView:textField topView:nil leftView:_textFieldContentView bottomView:_textFieldContentView rightView:_textFieldContentView edgeInset:UIEdgeInsetsMake(0, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [_textFieldContentView addConstraintEqualWithView:textField widthToView:nil heightToView:lastSecondTextField];
        
        // separateview
        UIView *separateView = _textFieldSeparateViews[_textFields.count - 2];
        [_textFieldContentView addConstraintWithView:separateView topView:nil leftView:_textFieldContentView bottomView:nil rightView:_textFieldContentView edgeInset:UIEdgeInsetsZero];
        [_textFieldContentView addConstraintWithTopView:separateView toBottomView:textField constant:0];
        [separateView addConstraintWidth:0 height:_textFieldBorderWidth];
    }
}

#pragma mark - action

- (void)actionButtonClicked:(UIButton *)button
{
    TYAlertAction *action = _actions[button.tag - kButtonTagOffset];
    
    if (_clickedAutoHide) {
        [self hideView];
    }
    
    if (action.handler) {
        action.handler(action);
    }
}

//- (void)dealloc
//{
//    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
//}


@end
