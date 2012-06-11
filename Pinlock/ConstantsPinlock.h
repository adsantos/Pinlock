//
//  ConstantsPinlock.h
//  Pinlock
//
//  Created by Adriana Santos on 11/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstantsPinlock : NSObject

typedef enum _KEYBOARD_BUTTONS {
    BACKSPACE = 10,
    CANCEL = 11
} KEYBOARD_BUTTONS;

extern int const DEFAULT_MAX_ATTEMPTS;
extern int const DEFAULT_LOCK_MINUTES;

@end
