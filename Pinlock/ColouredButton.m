//
//  ColouredButton.m
//  Pinlock
//
//  Created by Adriana Santos on 10/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColouredButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation ColouredButton

-(void)awakeFromNib {
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f] CGColor];
    [super awakeFromNib];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
