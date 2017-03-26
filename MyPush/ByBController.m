//
//  ByAController.m
//  MyPush
//
//  Created by pbyi on 17/3/24.
//  Copyright © 2017年 pbyi. All rights reserved.
//

#import "ByBController.h"

@interface ByBController ()

@end

@implementation ByBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"B";
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-30, kScreenHeight*0.5-30, 60, 60)];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.layer.cornerRadius = 30;
    [self.view addSubview:blueView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
