//
//  UIView+TYAlertView.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "UIView+LHAlertView.h"
#import "TYShowAlertView.h"

@implementation UIView (LHAlertView)

+ (instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

+ (instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
}

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - show in window

- (void)showInWindow
{
    [self showInWindowWithBackgoundTapDismissEnable:YES];
}

- (void)showInWindowWithBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [TYShowAlertView showAlertViewWithView:self backgoundTapDismissEnable:backgoundTapDismissEnable];
}

- (void)showInWindowWithOriginY:(CGFloat)OriginY
{
    [self showInWindowWithOriginY:OriginY backgoundTapDismissEnable:NO];
}

- (void)showInWindowWithOriginY:(CGFloat)OriginY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [TYShowAlertView showAlertViewWithView:self originY:OriginY backgoundTapDismissEnable:backgoundTapDismissEnable];
}

- (void)hideInWindow
{
    if ([self isShowInWindow]) {
        [(TYShowAlertView *)self.superview hide];
    }else {
        NSLog(@"self.superview is nil, or isn't TYShowAlertView");
    }
    
}

#pragma mark - show in controller

- (void)showInController:(UIViewController *)viewController
{
    [self showInController:viewController preferredStyle:LHAlertControllerStyleAlert transitionAnimation:LHAlertTransitionAnimationFade];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(LHAlertControllerStyle)preferredStyle
{
    [self showInController:viewController preferredStyle:preferredStyle transitionAnimation:LHAlertTransitionAnimationFade];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(LHAlertControllerStyle)preferredStyle backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    [self showInController:viewController preferredStyle:preferredStyle transitionAnimation:LHAlertTransitionAnimationFade backgoundTapDismissEnable:backgoundTapDismissEnable];
}

//- (void)showInController:(UIViewController *)viewController preferredStyle:(LHAlertControllerStyle)preferredStyle transitionAnimation:(TYAlertTransitionAnimation)transitionAnimation
//{
//    [self showInController:viewController preferredStyle:preferredStyle transitionAnimation:transitionAnimation backgoundTapDismissEnable:NO];
//}

//- (void)showInController:(UIViewController *)viewController preferredStyle:(LHAlertControllerStyle)preferredStyle transitionAnimation:(TYAlertTransitionAnimation)transitionAnimation backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
//{
//    if (self.superview) {
//        [self removeFromSuperview];
//    }
//
//    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:self preferredStyle:preferredStyle transitionAnimation:transitionAnimation];
//    alertController.backgoundTapDismissEnable = backgoundTapDismissEnable;
//    [viewController presentViewController:alertController animated:YES completion:nil];
//}

- (void)hideInController
{
    if ([self isShowInAlertController]) {
        [(LHAlertController *)self.viewController dismissViewControllerAnimated:YES];
    }else {
        NSLog(@"self.viewController is nil, or isn't TYAlertController");
    }
}

#pragma mark - hide

- (BOOL)isShowInAlertController
{
    UIViewController *viewController = self.viewController;
    if (viewController && [viewController isKindOfClass:[LHAlertController class]]) {
        return YES;
    }
    return NO;
    
}

- (BOOL)isShowInWindow
{
    if (self.superview && [self.superview isKindOfClass:[TYShowAlertView class]]) {
        return YES;
    }
    return NO;
}

- (void)hideView
{
    if ([self isShowInAlertController]) {
        [self hideInController];
    }else {
        NSLog(@"self.viewController is nil, or isn't TYAlertController,or self.superview is nil, or isn't TYShowAlertView");
    }
}

@end
