//
//  PinlockViewController.h
//  Pinlock
//
//  Created by Adriana Santos on 09/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinlockDelegate.h"

@interface PinlockViewController : UIViewController
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) NSString *serviceNameKeychain;
@property (nonatomic, retain) NSNumber *maxAttempts;
@property (nonatomic, retain) NSNumber *lockMinutes;
@property (nonatomic, retain) id<PinlockDelegate> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil backgroundColor:(UIColor *)color serviceNameKeychain:(NSString *)serviceName maxAttempts:(NSNumber *)attempts lockDuring:(NSNumber *)minutes bundle:(NSBundle *)nibBundleOrNil;

@end
