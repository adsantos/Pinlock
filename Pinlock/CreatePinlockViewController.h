//
//  AddPinlockViewController.h
//  Pinlock
//
//  Created by Adriana Santos on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinlockDelegate.h"

@interface CreatePinlockViewController : UIViewController <UITextFieldDelegate> {
    
    bool showPinViewAgain;
}

@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) NSString *serviceNameKeychain;
@property (nonatomic, retain) id<PinlockDelegate> delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil backgroundColor:(UIColor *)color serviceNameKeychain:(NSString *)serviceName bundle:(NSBundle *)nibBundleOrNil;

@end
