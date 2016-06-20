//
//  LTHTTPSessionManager.m
//  TwMall
//
//  Created by TaiHuiTao on 16/6/15.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import "LTHTTPSessionManager.h"

//解析数据返回错误
NSString *const kParseResponseError = @"解析数据失败";
NSString *const kHttpRequestFailure = @"网络连接错误";
//返回参数key值
NSString *const kKeyResult = @"error_code";
NSString *const kKeyMessage = @"error_msg";
NSString *const kKeyData = @"data";
NSString *const kKeyModelList = @"modellist";

@implementation LTHTTPSessionManager

- (instancetype)init{
    if (self = [super init]) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    }
    return self;
}
+ (instancetype)manager{
    return [[self alloc]init];
}

- (NSURLSessionDataTask *)POSTWithParameters:(NSString *)url parameters:(id)parameters complete:(completeBlock)complete{
    [Tool showWaitProgressView];
    return [super POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"成功");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"responseObject:%@",responseObject);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else if([responseObject[kKeyResult] isEqualToString:@"ERROR"]){
            complete(LTHttpResultFailure, responseObject[kKeyMessage], nil);
        }else{
            complete(LTHttpResultSuccess, responseObject[kKeyMessage], responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"失败");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"error:%@",error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else{
            complete(LTHttpResultFailure, kHttpRequestFailure, nil);
        }
    }];
}

- (NSURLSessionDataTask *)GETWithParameters:(NSString *)url parameters:(id)parameters complete:(completeBlock)complete{
    [Tool showWaitProgressView];
    return [super GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"成功");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"responseObject:%@",responseObject);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else if([responseObject[kKeyResult] isEqualToString:@"ERROR"]){
            complete(LTHttpResultFailure, responseObject[kKeyMessage], nil);
        }else{
            complete(LTHttpResultSuccess, responseObject[kKeyMessage], responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"失败");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"error:%@",error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else{
            complete(LTHttpResultFailure, kHttpRequestFailure, nil);
        }
    }];
}


- (NSURLSessionDataTask *)PUTWithParameters:(NSString *)url parameters:(id)parameters complete:(completeBlock)complete{
    [Tool showWaitProgressView];
    return [super PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"成功");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"responseObject:%@",responseObject);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else if([responseObject[kKeyResult] isEqualToString:@"ERROR"]){
            complete(LTHttpResultFailure, responseObject[kKeyMessage], nil);
        }else{
            complete(LTHttpResultSuccess, responseObject[kKeyMessage], responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"失败");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"error:%@",error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else{
            complete(LTHttpResultFailure, kHttpRequestFailure, nil);
        }
    }];
}


- (NSURLSessionDataTask *)DELTEWithParameters:(NSString *)url parameters:(id)parameters complete:(completeBlock)complete{
    [Tool showWaitProgressView];
    return [super DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"成功");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"responseObject:%@",responseObject);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else if([responseObject[kKeyResult] isEqualToString:@"ERROR"]){
            complete(LTHttpResultFailure, responseObject[kKeyMessage], nil);
        }else{
            complete(LTHttpResultSuccess, responseObject[kKeyMessage], responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"失败");
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",parameters);
        NSLog(@"error:%@",error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            complete(LTHttpResultFailure, kParseResponseError, nil);
        }else{
            complete(LTHttpResultFailure, kHttpRequestFailure, nil);
        }
    }];
}

@end
