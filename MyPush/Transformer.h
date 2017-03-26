//
//  Transformer.h
//  MyPush
//
//  Created by pbyi on 17/3/25.
//  Copyright © 2017年 pbyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Transformer : NSObject <UITabBarControllerDelegate,
                                   UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) NSInteger preIndex;
@property (assign, nonatomic) NSInteger selectedIndex;
@end
