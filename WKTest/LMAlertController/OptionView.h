//
//  OptionView.h
//  TYAlertControllerDemo
//
//  Created by lumi on 2020/1/6.
//  Copyright © 2020 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OptionView : UIView

+ (instancetype)alertViewWithTitle:(NSString *)title optionsArray:(NSArray *)options SelectedIndex:(NSInteger)selectedIndex handler:(void (^)(NSString* option,NSInteger index))handler;


@end

NS_ASSUME_NONNULL_END
