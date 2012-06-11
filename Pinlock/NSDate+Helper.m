//
//  NSDate+Helper.m
//  PinlockF
//
//  Created by Adriana Santos on 21/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

+(NSDate *)dateXMonthsAgo:(NSDate *)date numberOfMonths:(int)months {
    
    NSCalendar *cal = [[NSCalendar alloc]
                       initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                               | NSMinuteCalendarUnit | NSHourCalendarUnit 
                                               | NSSecondCalendarUnit) 
                                     fromDate:date];
    [comps setMonth:[comps month]-months];
    NSDate *newDate = [[NSDate alloc] init];
    newDate = [cal dateFromComponents:comps];
    return newDate;
}

+(NSDate *)dateXMinutesLater:(NSDate *)date numberOfMinutes:(int)minutes {
    
    NSCalendar *cal = [[NSCalendar alloc]
                       initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                               | NSMinuteCalendarUnit | NSHourCalendarUnit 
                                               | NSSecondCalendarUnit) 
                                     fromDate:date];
    [comps setMinute:[comps minute]+minutes];
    NSDate *newDate = [[NSDate alloc] init];
    newDate = [cal dateFromComponents:comps];
    return newDate;
}

@end
