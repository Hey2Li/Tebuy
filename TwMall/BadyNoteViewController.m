//
//  BadyNoteViewController.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/13.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "BadyNoteViewController.h"

@interface BadyNoteViewController ()

@end

@implementation BadyNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"宝贝笔记";
    [self initWithView];
}
- (void)initWithView{
    UITextField *textFiled = [UITextField new];
    textFiled.placeholder = @"请输入文字";
    [self.view addSubview:textFiled];
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(100);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
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
