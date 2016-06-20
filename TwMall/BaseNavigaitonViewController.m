//
//  BaseNavigaitonViewController.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/13.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "BaseNavigaitonViewController.h"

@interface BaseNavigaitonViewController ()

@end

@implementation BaseNavigaitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:17], NSFontAttributeName,nil];
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
