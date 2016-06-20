//
//  LTHttpManager.h
//  TwMall
//
//  Created by TaiHuiTao on 16/6/15.
//  Copyright © 2016年 TaiHuiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTHTTPSessionManager.h"

@interface LTHttpManager : NSObject

+ (void)testHttpPost:(completeBlock)complete;

+ (void)GetTestRequest:(completeBlock)complete;
@end
