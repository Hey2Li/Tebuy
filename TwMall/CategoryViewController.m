//
//  CategoryViewController.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/13.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "CategoryViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    [self initWithView];
}
- (void)initWithView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [button setTitle:@"支付" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(alipay) forControlEvents:UIControlEventTouchUpInside];
}
- (void)alipay{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString * partner = @"2088021456014146";
    NSString * seller = @"mycaidada@sina.cn";
    NSString * privateKey = @"MIICXAIBAAKBgQDHZfMAX6d2F4xqAlUKqAz6oxtb+oyK95FBe6+jFFzhILteO73h6dtsL6C8V5LyCnQsrGE4fbvOvQataqtpcoxsLkKnbmpgpErDSSmIZVoVQTh1gDblwHjk15SXd6B5NibXi8PXlJh3hNzB6jHpgUJ3qDr35ShPFM0jM+CmPyEdNQIDAQABAoGAUHKQZOEyxhFgJFEGkIMWoXR3EFf4pgSWBS5qwUfw5R94mN9Pj7rzPSXGGtbWQXL4RiHSI6GOyS04aXT07Vk6z58Sb9u9R4W9dsmalvrAzdGQIIwIcaF2UGwcGK6/waOsGf11HVNBLmSJvwa2wUgTKA4+P6Yxu8wq/6Xv+dsjdU0CQQD+NQDMcrfncLUjziWM0IzsAbjTy7CFXojSMTzBT7qJspu6pQxLuEP/VtrbCTJy1DfjmeUhxAekMdKQfpB6HgifAkEAyM37skox8LBhDTnXnceZD0gf6+TEkqNKyvPeb7XjYiXQMl/R7r3kU3nN66Ndp7EBOAtpN/fZ5kD7/Vxp1jHFqwJANrMFBvkwZVa1Q40aO2Cs0iPUt44+35Pl8QSzRA154CNUqybUrH5r80enNDaYamkL1afJzCg4VLZ7zqfNQtmvlQJAfukQhqI15fTTodRI3cNkjS/8XM59HmBtyM9QajH+v+0+JFhDCiyhvdBhwOfDLVTFfHJZ0bGn2cqAeKSLj4BteQJBAJlwfsbpFMRWoH+6ZpFR2grwYrieA46P1ggQwMXFPs/L5K+v1C2WlaPjsEqoICGX7qyxlcNg4WdlSO9S48T97jc=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.subject = @"1221"; //商品标题
    order.body = @"1111"; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alipayTwMall";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            //            9000	订单支付成功
            //            8000	正在处理中
            //            4000	订单支付失败
            //            6001	用户中途取消
            //            6002	网络连接出错
            NSString *resultStatus =
            [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
            if ([resultStatus isEqualToString:@"9000"]) {
                [self.view makeToast:@"已付款成功"];
            }else if ([resultStatus isEqualToString:@"8000"]){
                [self.view makeToast:@"正在处理中"];
            }else if ([resultStatus isEqualToString:@"4000"]){
                [self.view makeToast:@"订单支付失败"];
            }else if ([resultStatus isEqualToString:@"6001"]){
                [self.view makeToast:@"用户中途取消"];
            }else if ([resultStatus isEqualToString:@"6002"]){
                [self.view makeToast:@"网络连接出错"];
            }
        }];
    }
}
#pragma mark   ==============产生随机订单号==============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
