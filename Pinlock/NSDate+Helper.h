//
//  NSDate+Helper.h
//  PinlockF
//
//  Created by Adriana Santos on 21/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (Helper)

+(NSDate *)dateXMonthsAgo:(NSDate *)date numberOfMonths:(int)months;
+(NSDate *)dateXMinutesLater:(NSDate *)date numberOfMinutes:(int)minutes;

@end
