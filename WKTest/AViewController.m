//
//  ViewController.m
//  WKTest
//
//  Created by chenshuang on 2019/12/13.
//  Copyright © 2019 chenshuang. All rights reserved.
//

#import "AViewController.h"
#import <WebKit/WebKit.h>

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface AViewController ()<WKNavigationDelegate>
/** wk */
@property(nonatomic, strong)WKWebView *webView;
/** title */
@property(nonatomic, strong)UILabel *titleLbe;
///** webview */
//@property(nonatomic, strong)UIWebView *webView1;
///** btn */
//@property(nonatomic, strong)UIButton *btn;
///** 默认地址 */
//@property(nonatomic, strong)UIButton *btn1;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self drawWKWebView];
//    [self drawWebView];
    
//    [self drawBtn];
}

- (void)viewWillAppear:(BOOL)animated {
//    [self laodURL:@"https://cs-support-alab.aqara.cn/abroad?channel=appc19b01439c744375"];
}

- (void)drawWKWebView {
   WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    NSString *urlStr = @"https://www.so.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

-(void)viewDidLayoutSubviews {
}

- (void)drawWebView {
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,100, SCREEN_W, SCREEN_H - 64)];
//    self.webView1 = webView;
//    [self.view addSubview:self.webView1];
}

- (void)drawBtn {
    
//    [self.view addSubview:self.btn];
//    [self.view addSubview:self.btn1];
}

- (void)laodURL:(NSString *)loadUrl {
    //https:/cdn.cnbj2.fds.api.mi-img.com/cdn/aqara-app-h5-test/index.html#/helpFeedback?userName=15625705593&version=1.6.0&phoneModel=iPhone%206%20Plus&platForm=iOS_12.4.3&userId=e917f1400a522495.545581825980891137&language=zh-Hans-CN&timeStamp=1577775082620&temperatureUnit=0&app=aq&area=CHN
    NSURL *url = [NSURL URLWithString:loadUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (_webView) {
        [self.webView loadRequest:request];
    }
}

#pragma mark - WKNavigationDelegate

/// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.titleLbe.text = @"页面开始加载";
}

/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    self.titleLbe.text = [NSString stringWithFormat:@"加载失败:%@",error.description];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    self.titleLbe.text = @"内容开始返回";
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.titleLbe.text = @"页面加载完成";
}

#pragma mark - action

- (void)didClickChangeURLBtn {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入加载的网址" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *userNameTextField = alertController.textFields.firstObject;
        [self laodURL:userNameTextField.text];
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
      textField.placeholder = @"网址";
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)didClickChangeURLBtn1 {
    
    [self laodURL:@"http://192.168.3.92:9001/abroad?channel=appc19b01439c744375"];
    
}

#pragma mark - private

#pragma mark - lazy

//- (UILabel *)titleLbe {
//    if (_titleLbe) {
//        _titleLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_H - 40, SCREEN_W, 40)];
//        _titleLbe.font = [UIFont systemFontOfSize:16];
//        _titleLbe.textColor = [UIColor blackColor];
//        _titleLbe.layer.borderWidth = 1;
//        _titleLbe.layer.borderColor = [UIColor grayColor].CGColor;
//        _titleLbe.numberOfLines = 0;
//
//        [self.view addSubview:_titleLbe];
//    }
//    return _titleLbe;
//}
//
//- (UIButton *)btn {
//    if (!_btn) {
//        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _btn.frame = CGRectMake((SCREEN_W - 100) * 0.5, 64, 100, 40);
//        [_btn setTitle:@"更改地址" forState:UIControlStateNormal];
//        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_btn addTarget:self action:@selector(didClickChangeURLBtn) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _btn;
//}
//
//- (UIButton *)btn1 {
//    if (!_btn1) {
//        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        _btn1.frame = CGRectMake((SCREEN_W - 100), 64, 100, 40);
//        [_btn1 setTitle:@"默认地址" forState:UIControlStateNormal];
//        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_btn1 addTarget:self action:@selector(didClickChangeURLBtn1) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _btn1;
//}
//

@end
