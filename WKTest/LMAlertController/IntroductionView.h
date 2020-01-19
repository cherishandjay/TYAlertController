//
//  IntroductionView.h
//  TYAlertControllerDemo
//
//  Created by lumi on 2020/1/6.
//  Copyright © 2020 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroductionView : UIView

+ (instancetype)alertViewWithTitle:(NSString *)title imageName:(NSString*)imageName buttonName:(NSString*)btnName handler:(void (^)(NSInteger isBottomBtn))handler;

@end

NS_ASSUME_NONNULL_END
