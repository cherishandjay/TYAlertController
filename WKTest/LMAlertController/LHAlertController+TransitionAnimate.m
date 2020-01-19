//
//  TYAlertController+TransitionAnimate.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "LHAlertController.h"
#import "LHAlertFadeAnimation.h"
 
@implementation LHAlertController (TransitionAnimate)

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [LHAlertFadeAnimation alertAnimationIsPresenting:YES];

}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [LHAlertFadeAnimation alertAnimationIsPresenting:NO];
}

@end
