//
//  Tool.m
//  Negotiation
//
//  Created by qkong on 7/20/15.
//  Copyright (c) 2015 zhaomi. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (void)callToTelPhoneNumber:(NSString *)phoneNumber{
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
    [[UIApplication sharedApplication]openURL:phoneUrl];
}

+ (BOOL)isEmptyString:(NSString *)str{
    NSArray *words = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *nospaceString = [words componentsJoinedByString:@""];
    return nospaceString.length == 0;
}

+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|77|83)\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[1278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//获取当前星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(NSString *)GetTodayDay
{
    NSDate *datenow = [NSDate date];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd号"];
    NSString *todayStr = [NSString stringWithFormat:@"%@  %@",[self weekdayStringFromDate:datenow],[formatter stringFromDate:datenow]];
    
    return todayStr;
}

+(NSString *)GetTomorrowDay
{
    NSDate *datenow = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:datenow];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM月dd号"];
    
    NSString *tomorrowStr = [NSString stringWithFormat:@"%@  %@",[self weekdayStringFromDate:beginningOfWeek],[dateday stringFromDate:beginningOfWeek]];
    return tomorrowStr;
}

+ (void)showMessage:(NSString *)message{
//    NSDictionary *options = @{kCRToastNotificationTypeKey: @(CRToastTypeStatusBar),
//                              kCRToastTextKey : message,
//                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
//                              kCRToastBackgroundColorKey : [UIColor redColor],
//                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
//                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
//                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
//                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
//                              };
////    [CRToastManager dismissAllNotifications:YES];
//    [CRToastManager showNotificationWithOptions:options
//                                completionBlock:nil];
}

+ (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

+ (void)showWaitProgressView{
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD show];
}


#pragma mark   ==============产生随机订单号==============


+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+ (UIImage *)normalizedImage : (UIImage *) image{
         if (image.imageOrientation == UIImageOrientationUp) return image;
    
         UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
         [image drawInRect:(CGRect){0, 0, image.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         return normalizedImage;
     }
@end
