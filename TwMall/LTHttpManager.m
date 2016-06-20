//
//  LTHttpManager.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/15.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "LTHttpManager.h"

@implementation LTHttpManager

+ (void)testHttpPost:(completeBlock)complete{
    LTHTTPSessionManager *manager = [LTHTTPSessionManager new];
    [manager POSTWithParameters:[NSString stringWithFormat:@"http://192.168.1.29:3000/brand/brandList/156"] parameters:nil complete:complete];
}

+ (void)GetTestRequest:(completeBlock)complete{
    LTHTTPSessionManager *manager = [LTHTTPSessionManager new];
    [manager GETWithParameters:@"http://192.168.1.29:3000/brand/brandList/156" parameters:nil complete:complete];
}
@end
