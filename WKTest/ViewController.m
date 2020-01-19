//
//  ViewController.m
//  WKTest
//
//  Created by chenshuang on 2019/12/13.
//  Copyright © 2019 chenshuang. All rights reserved.
//

#import "ViewController.h"
#import "LHAlert.h"
 

// first way to show ,use UIView Category
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
 
@property(nonatomic,strong)UIView* bgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    
}

 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
 {
 
//     [self.navigationController pushViewController:NSClassFromString(@"AViewController").new animated:YES];
     
     LHAlertView *alertView = [LHAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, but it can support long message, hahahhahahahahhahahahahhaahahhahahahahahhahahahahhahahahahahhahahahahahhahahahhahahhahahahahh. (NSTextAlignmentCenter)"];
     __weak LHAlertView* weakalert = alertView;
     [alertView addAction:[LHAlertAction actionWithTitle:@"取消" style:LHAlertActionStyleDefault handler:^(LHAlertAction *action) {
         [weakalert hideInWindow];
     }]];
     
      [alertView addAction:[LHAlertAction actionWithTitle:@"取消" style:LHAlertActionStyleDefault handler:^(LHAlertAction *action) {
            
        }]];
     
     // first way to show ,use UIView Category
//     [alertView showInWindowWithOriginY:200 backgoundTapDismissEnable:YES];
     [alertView showInWindow];
 }
 
@end
