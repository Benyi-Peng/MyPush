//
//  Transformer.m
//  MyPush
//
//  Created by pbyi on 17/3/25.
//  Copyright © 2017年 pbyi. All rights reserved.
//

#import "Transformer.h"
#import "ByTabBarController.h"

static CGFloat const kPadding  = 10;
static CGFloat const kDamping  = 0.75;
static CGFloat const kVelocity = 2;

@implementation Transformer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _preIndex = 0;
        _selectedIndex = 0;
    }
    return self;
}

//UITabBarControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    ByTabBarController *tabVC = (ByTabBarController *)tabBarController;
    return tabVC.transform;
}

//UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.33;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"Animation begin... ... ");
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
//    NSLog(@"preIndex:%zd",self.preIndex);
//    NSLog(@"selectIndex:%zd",self.selectedIndex);
    
    NSLog(@"transform : %@",self);
    CGFloat translation = containerView.bounds.size.width + kPadding;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(_preIndex > _selectedIndex ? translation : -translation, 0);
    toViewController.view.transform = CGAffineTransformInvert(transform);
    [containerView addSubview:toViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:kDamping initialSpringVelocity:kVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromViewController.view.transform = transform;
        toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromViewController.view.transform = transform;
//        toViewController.view.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        fromViewController.view.transform = CGAffineTransformIdentity;
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
}

//UIViewControllerContextTransitioning
@end
