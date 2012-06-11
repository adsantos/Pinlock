//
//  PinlockDelegate.h
//  Pinlock
//
//  Created by Adriana Santos on 15/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PinlockViewController;
@class CreatePinlockViewController;

@protocol PinlockDelegate

-(void)pinlockCorrect:(BOOL)correct attemptsLeft:(NSNumber *)attemptsLeftNumber viewController:(PinlockViewController *)vc;
-(void)pinlockCreatedCorrectly:(BOOL)success viewController:(CreatePinlockViewController *)vc;

@end
