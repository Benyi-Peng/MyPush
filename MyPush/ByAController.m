//
//  ByAController.m
//  MyPush
//
//  Created by pbyi on 17/3/24.
//  Copyright © 2017年 pbyi. All rights reserved.
//

#import "ByAController.h"

@interface ByAController ()

@end

@implementation ByAController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"A";
    
    UIView *orangeView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-30, kScreenHeight*0.5-30, 60, 60)];
    orangeView.backgroundColor = [UIColor orangeColor];
    orangeView.layer.cornerRadius = 30;
    [self.view addSubview:orangeView];
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
