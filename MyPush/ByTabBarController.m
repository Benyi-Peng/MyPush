//
//  ByTabBarController.m
//  MyPush
//
//  Created by pbyi on 17/3/24.
//  Copyright © 2017年 pbyi. All rights reserved.
//

#import "ByTabBarController.h"
#import "ByAController.h"
#import "ByBController.h"
#import "ByCController.h"

#import "Transformer.h"

@interface ByTabBarController () 

@end

@implementation ByTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    
    //
    ByAController *aVC = [[ByAController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:aVC];
    nav1.tabBarItem.title = @"A";
    [nav1.tabBarItem setImage:[UIImage imageNamed:@"home"]];
    [self addChildViewController:nav1];
    
    //
    ByBController *bVC = [[ByBController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:bVC];
    nav2.tabBarItem.title = @"B";
    [nav2.tabBarItem setImage:[UIImage imageNamed:@"live"]];
    [self addChildViewController:nav2];
    
    ByCController *cVC = [[ByCController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:cVC];
    nav3.tabBarItem.title = @"C";
    [nav3.tabBarItem setImage:[UIImage imageNamed:@"local"]];
    [self addChildViewController:nav3];
    
    self.transform = [[Transformer alloc] init];
    NSLog(@"init transform : %@",self.transform);
    self.delegate = self.transform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        [self.tabBar.items[i] setTag:i];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.transform.selectedIndex = item.tag;
    self.transform.preIndex = self.selectedIndex;
    NSLog(@"tabVC transform: %@",self.transform);
//    NSLog(@"preIndex:%zd",self.transform.preIndex);
//    NSLog(@"selectIndex:%zd",self.transform.selectedIndex);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
