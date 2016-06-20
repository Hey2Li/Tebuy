//
//  Tool.h
//  Negotiation
//
//  Created by qkong on 7/20/15.
//  Copyright (c) 2015 zhaomi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (void)callToTelPhoneNumber:(NSString *)phoneNumber;

+ (BOOL)isEmptyString:(NSString *)str;

+ (BOOL)validateMobile:(NSString *)mobileNum;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+(NSString *)GetTodayDay;

+(NSString *)GetTomorrowDay;

+ (void)showMessage:(NSString *)message;

+ (BOOL)isStringEmpty:(NSString *)string;

+ (void)showWaitProgressView;

+ (NSString *)generateTradeNO;

+ (UIImage *)normalizedImage : (UIImage *) image;
@end
