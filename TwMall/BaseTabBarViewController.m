//
//  BaseTabBarViewController.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/13.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigaitonViewController.h"
#import "HomePageViewController.h"
#import "CategoryViewController.h"
#import "BadyNoteViewController.h"
#import "ShoppingCartViewController.h"
#import "MineViewController.h"

@interface BaseTabBarViewController ()
@property (nonatomic, strong) BaseNavigaitonViewController *homePageTab;
@property (nonatomic, strong) BaseNavigaitonViewController *CategoryTab;
@property (nonatomic, strong) BaseNavigaitonViewController *BabyNoteTab;
@property (nonatomic, strong) BaseNavigaitonViewController *shoppingCartTab;
@property (nonatomic, strong) BaseNavigaitonViewController *mineTab;
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tabbar
    [self createTabBar];
}
- (void)createTabBar{
    _homePageTab = [[BaseNavigaitonViewController alloc]initWithRootViewController:[HomePageViewController new]];
    _CategoryTab = [[BaseNavigaitonViewController alloc]initWithRootViewController:[CategoryViewController new]];
    _BabyNoteTab = [[BaseNavigaitonViewController alloc]initWithRootViewController:[BadyNoteViewController new]];
    _shoppingCartTab = [[BaseNavigaitonViewController alloc]initWithRootViewController:[ShoppingCartViewController new]];
    _mineTab = [[BaseNavigaitonViewController alloc]initWithRootViewController:[MineViewController new]];
    self.viewControllers = @[_homePageTab, _CategoryTab, _BabyNoteTab, _shoppingCartTab, _mineTab];
    self.selectedIndex = 0;
    
    NSArray *titleArr = @[@"首页", @"分类", @"宝贝笔记", @"购物车",@"我的"];
//    NSArray *normalImgArr = @[@"look_unclick",  @"buy_click-1", @"shopping_unclick", @"mynew_unclick"];
//    NSArray *selectedImgArr = @[@"look_click",  @"buy_click", @"shopping_click", @"mynew_click"];
    // 设置分栏元素项
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = self.viewControllers[i];
//        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArr[i] image:[[UIImage imageNamed:normalImgArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImgArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        vc.tabBarItem.title = titleArr[i];
    }

    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    self.tabBar.tintColor = [UIColor purpleColor];
    
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
