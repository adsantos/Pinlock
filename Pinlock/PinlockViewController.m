//
//  PinlockViewController.m
//  Pinlock
//
//  Created by Adriana Santos on 09/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PinlockViewController.h"
#import "ConstantsPinlock.h"
#import "SFHFKeychainUtils.h"
#import "NSDate+Helper.h"

@interface PinlockViewController ()

@property (nonatomic, assign) IBOutlet UIView *pinlockView;
@property (nonatomic, assign) IBOutlet UIView *transparentView;
@property (nonatomic, assign) IBOutlet UIButton *button0;
@property (nonatomic, assign) IBOutlet UIButton *button1;
@property (nonatomic, assign) IBOutlet UIButton *button2;
@property (nonatomic, assign) IBOutlet UIButton *button3;
@property (nonatomic, assign) IBOutlet UIButton *button4;
@property (nonatomic, assign) IBOutlet UIButton *button5;
@property (nonatomic, assign) IBOutlet UIButton *button6;
@property (nonatomic, assign) IBOutlet UIButton *button7;
@property (nonatomic, assign) IBOutlet UIButton *button8;
@property (nonatomic, assign) IBOutlet UIButton *button9;
@property (nonatomic, assign) IBOutlet UIButton *buttonBackSpace;
@property (nonatomic, assign) IBOutlet UIButton *buttonCancel;
@property (nonatomic, assign) IBOutlet UITextField *pinTextField1;
@property (nonatomic, assign) IBOutlet UITextField *pinTextField2;
@property (nonatomic, assign) IBOutlet UITextField *pinTextField3;
@property (nonatomic, assign) IBOutlet UITextField *pinTextField4;
@property (nonatomic, assign) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) NSString *pin;
@property (nonatomic, assign) IBOutlet UILabel *failedPasscodeLabel;
@property (nonatomic, assign) IBOutlet UIView *failedLabelBackground;
@property (nonatomic, retain) NSTimer *lockTimer;

- (IBAction)buttonPress:(id)sender;
-(IBAction)removeView:(id)sender;

@end

@implementation PinlockViewController
@synthesize backgroundColor;
@synthesize serviceNameKeychain;
@synthesize maxAttempts = _maxAttempts;
@synthesize lockMinutes = _lockMinutes;
@synthesize delegate;
@synthesize pinlockView;
@synthesize transparentView;
@synthesize button0;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;
@synthesize button7;
@synthesize button8;
@synthesize button9;
@synthesize buttonCancel;
@synthesize buttonBackSpace;
@synthesize pinTextField1;
@synthesize pinTextField2;
@synthesize pinTextField3;
@synthesize pinTextField4;
@synthesize messageLabel;
@synthesize failedLabelBackground;
@synthesize pin;
@synthesize failedPasscodeLabel;
@synthesize lockTimer = _lockTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (!self.backgroundColor) {
            self.backgroundColor = [UIColor lightGrayColor];
        }
        if (!self.serviceNameKeychain) {
            self.serviceNameKeychain = @"pinlockApp";
        }
        if (!self.maxAttempts) {
            self.maxAttempts = [[NSUserDefaults standardUserDefaults] objectForKey:@"pinlockAttemptsLeft"];
            if (!self.maxAttempts) {
                self.maxAttempts = [NSNumber numberWithInt:DEFAULT_MAX_ATTEMPTS];
            }
        }
        if (!self.lockMinutes) {
            self.lockMinutes = [NSNumber numberWithInt:DEFAULT_LOCK_MINUTES];
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil backgroundColor:(UIColor *)color serviceNameKeychain:(NSString *)serviceName maxAttempts:(NSNumber *)attempts lockDuring:(NSNumber *)minutes bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (!color) {
            self.backgroundColor = [UIColor lightGrayColor];
        }
        else {
            self.backgroundColor = color;
        }
        
        if (!serviceName) {
            self.serviceNameKeychain = @"pinlockApp";
        }
        else {
            self.serviceNameKeychain = serviceName;
        }
        if (!attempts) {
            self.maxAttempts = [[NSUserDefaults standardUserDefaults] objectForKey:@"pinlockAttemptsLeft"];
            if (!self.maxAttempts) {
                self.maxAttempts = [NSNumber numberWithInt:DEFAULT_MAX_ATTEMPTS];
            }
        }
        else {
            self.maxAttempts = attempts;
        }
        
        if (!minutes) {
            self.lockMinutes = [NSNumber numberWithInt:DEFAULT_LOCK_MINUTES];
        }
        else {
            self.lockMinutes = minutes;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.transparentView setBackgroundColor:self.backgroundColor];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else {
        return NO;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"pinlock center before set: %f %f", self.pinlockView.center.x, self.pinlockView.center.y);
    self.pinlockView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    NSLog(@"pinlock center after set: %f %f", self.pinlockView.center.x, self.pinlockView.center.y);
}

-(void)unlockScreen {
    NSLog(@"unlock");
    self.failedLabelBackground.hidden = YES;
    self.failedPasscodeLabel.hidden = YES;
    
    self.button0.userInteractionEnabled = YES;
    self.button1.userInteractionEnabled = YES;
    self.button2.userInteractionEnabled = YES;
    self.button3.userInteractionEnabled = YES;
    self.button4.userInteractionEnabled = YES;
    self.button5.userInteractionEnabled = YES;
    self.button6.userInteractionEnabled = YES;
    self.button7.userInteractionEnabled = YES;
    self.button8.userInteractionEnabled = YES;
    self.button9.userInteractionEnabled = YES;
    self.buttonBackSpace.userInteractionEnabled = YES;
    self.buttonCancel.userInteractionEnabled = YES;
    self.button0.titleLabel.textColor = [UIColor whiteColor];
    self.button1.titleLabel.textColor = [UIColor whiteColor];
    self.button2.titleLabel.textColor = [UIColor whiteColor];
    self.button3.titleLabel.textColor = [UIColor whiteColor];
    self.button4.titleLabel.textColor = [UIColor whiteColor];
    self.button5.titleLabel.textColor = [UIColor whiteColor];
    self.button6.titleLabel.textColor = [UIColor whiteColor];
    self.button7.titleLabel.textColor = [UIColor whiteColor];
    self.button8.titleLabel.textColor = [UIColor whiteColor];
    self.button9.titleLabel.textColor = [UIColor whiteColor];
    self.buttonCancel.titleLabel.textColor = [UIColor whiteColor];
    self.buttonBackSpace.titleLabel.textColor = [UIColor whiteColor];
    
    self.maxAttempts = [NSNumber numberWithInt:DEFAULT_MAX_ATTEMPTS];
    [self.lockTimer invalidate];
    _lockTimer = nil;
}

-(void)loadView {
    [super loadView];
    
    //    CAGradientLayer *failedPasscodeGrad = [CAGradientLayer layer];
    //    failedPasscodeGrad.frame = self.failedPasscodeLabel.layer.bounds;
    //    failedPasscodeGrad.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:181.0f/255.0f green:20.0f/255.0f blue:15.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:196.0f/255.0f green:52.0f/255.0f blue:50.0f/255.0f alpha:1.0f].CGColor, nil];
    //    [self.failedPasscodeLabel.layer insertSublayer:failedPasscodeGrad atIndex:0];
    
    self.failedLabelBackground.layer.cornerRadius = 15.0f;
    self.failedLabelBackground.layer.masksToBounds = YES;
    self.failedLabelBackground.hidden = YES;
    self.pin = @"";
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        self.pinlockView.layer.cornerRadius = 8.0f;
        self.pinlockView.layer.borderColor = [[UIColor blackColor] CGColor];
        self.pinlockView.layer.borderWidth = 2.0f;
        self.pinlockView.layer.masksToBounds = NO;
        self.pinlockView.layer.shadowOffset = CGSizeMake(0, 0);
        self.pinlockView.layer.shadowRadius = 10;
        self.pinlockView.layer.shadowOpacity = 4.5;
        self.view.backgroundColor = [UIColor colorWithRed:70.0f/255.0f green:90.0f/255.0f blue:104.0f/255.0f alpha:1];
    }
    
    NSDate *appLockedDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLocked"];
    NSDate *checkDate = [NSDate dateXMinutesLater:appLockedDate numberOfMinutes:[self.lockMinutes intValue]];
    
    if (appLockedDate && [(NSDate *)[NSDate date] compare:checkDate] == NSOrderedAscending) {
        [self lockScreen];
    }
    
    //    self.failedPasscodeLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundWrongPin"]];
    //    CAGradientLayer *gradient = [CAGradientLayer layer];
    //    gradient.frame = self.button1.layer.bounds;
    ////    CGColorRef ligherColorRef = (id)[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    ////    CGColorRef darkerColorRef = [[UIColor colorWithRed:71/255 green:71/255 blue:72/255 alpha:1.0] CGColor];
    //    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:109.0f/255.0f green:116.0f/255.0f blue:129.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:78.0f/255.0f green:85.0f/255.0f blue:99.0f/255.0f alpha:1.0f].CGColor, nil];
    //    
    //    [self.button1.layer insertSublayer:gradient atIndex:0];
    ////    self.button1.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    //
    //    self.button1.layer.borderWidth = 1;
}

-(void)lockScreen {
    self.failedLabelBackground.hidden = NO;
    self.failedPasscodeLabel.hidden = NO;
    
    NSDate *appLockedDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLocked"];
    int intervalMinutes = round([self.lockMinutes intValue] - [[NSDate date] timeIntervalSinceDate:appLockedDate]/60);
    NSString *failedMessage = [NSString stringWithFormat:@"%@ %d %@", NSLocalizedString(@"App locked for", @""), intervalMinutes, NSLocalizedString(@"min", @"")];
    self.failedPasscodeLabel.text = failedMessage;
    self.button0.userInteractionEnabled = NO;
    self.button1.userInteractionEnabled = NO;
    self.button2.userInteractionEnabled = NO;
    self.button3.userInteractionEnabled = NO;
    self.button4.userInteractionEnabled = NO;
    self.button5.userInteractionEnabled = NO;
    self.button6.userInteractionEnabled = NO;
    self.button7.userInteractionEnabled = NO;
    self.button8.userInteractionEnabled = NO;
    self.button9.userInteractionEnabled = NO;
    self.buttonBackSpace.userInteractionEnabled = NO;
    self.buttonCancel.userInteractionEnabled = NO;
    self.button0.titleLabel.textColor = [UIColor grayColor];
    self.button1.titleLabel.textColor = [UIColor grayColor];
    self.button2.titleLabel.textColor = [UIColor grayColor];
    self.button3.titleLabel.textColor = [UIColor grayColor];
    self.button4.titleLabel.textColor = [UIColor grayColor];
    self.button5.titleLabel.textColor = [UIColor grayColor];
    self.button6.titleLabel.textColor = [UIColor grayColor];
    self.button7.titleLabel.textColor = [UIColor grayColor];
    self.button8.titleLabel.textColor = [UIColor grayColor];
    self.button9.titleLabel.textColor = [UIColor grayColor];
    self.buttonCancel.titleLabel.textColor = [UIColor grayColor];
    self.buttonBackSpace.titleLabel.textColor = [UIColor grayColor];
    
    self.lockTimer = [NSTimer scheduledTimerWithTimeInterval:intervalMinutes*60.0f target:self selector:@selector(unlockScreen) userInfo:nil repeats:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"PinlockOnScreen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    self.pinlockView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

-(void)viewWillDisappear:(BOOL)animated {
    if (self.lockTimer) {
        [self.lockTimer invalidate];
        _lockTimer = nil;
    }
}

- (void)viewDidUnload
{
    [self setPinlockView:nil];
    [self setButton1:nil];
    [self setPinTextField1:nil];
    [self setPinTextField2:nil];
    [self setPinTextField3:nil];
    [self setPinTextField4:nil];
    [self setMessageLabel:nil];
    [self setPin:nil];
    [self setFailedPasscodeLabel:nil];
    [self setTransparentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)clearTextFields {
    
    //    CAGradientLayer *gradient = [CAGradientLayer layer];
    //    gradient.frame = self.messageLabel.layer.bounds;
    //    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:180.0f/255.0f green:110.0f/255.0f blue:108.0f/255.0f alpha:0.9f].CGColor, (id)[UIColor colorWithRed:169.0f/255.0f green:64.0f/255.0f blue:61.0f/255.0f alpha:0.9f].CGColor, nil];
    
    //    [self.messageLabel.layer insertSublayer:gradient atIndex:0];
    //    self.messageLabel.backgroundColor = [UIColor colorWithRed:183.0f/255.0f green:12.0f/255.0f blue:12.0f/255.0f alpha:1.0];
    //    self.messageLabel.text = NSLocalizedString(@"Wrong passcode", @"");
    
    self.failedPasscodeLabel.hidden = NO;
    self.failedLabelBackground.hidden = NO;
    self.pinTextField1.text = nil;
    self.pinTextField2.text = nil;
    self.pinTextField3.text = nil;
    self.pinTextField4.text = nil;
    self.pin = [NSString stringWithString:@""];
    
    switch ([self.maxAttempts intValue]) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"pinlockAttemptsLeft"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"appLocked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self lockScreen];
            break;
        case 1:
            self.failedPasscodeLabel.text = NSLocalizedString(@"Last Attempt", @"");
            break;
        default:
        {
            NSString *failedPasscodeStr = [NSString stringWithFormat:@"%@ %@", self.maxAttempts, NSLocalizedString(@"Passcode Attempts Left", @"")];
            self.failedPasscodeLabel.text = failedPasscodeStr;
            break;
        }
    }    
}

- (IBAction)buttonPress:(id)sender {
    
    if ([self.maxAttempts intValue] == 0) {
        [self clearTextFields];
        return;
    }
    
    if (!self.failedPasscodeLabel.hidden) {
        self.failedPasscodeLabel.hidden = YES;
        self.failedLabelBackground.hidden = YES;
    }
    
    UIButton *bt = (UIButton *) sender;
    int pressedTag = bt.tag;
    NSLog(@"label : %d , sender %@ ", pressedTag, sender);
    if (pressedTag == BACKSPACE){
        if (self.pin && [self.pin length] > 0) {
            self.pin = [self.pin substringToIndex:[self.pin length]-1];
            int pinLength = [self.pin length];
            switch (pinLength) {
                case 0:
                    self.pinTextField1.text = nil;
                    break;
                case 1:
                    self.pinTextField2.text = nil;
                    break;
                case 2:
                    self.pinTextField3.text = nil;
                    break;
                case 3:
                    self.pinTextField4.text = nil;
                    break;
                default:
                    break;
            }
        }
    }
    else {
        if (pressedTag != CANCEL) {
            self.pin = [self.pin stringByAppendingFormat:@"%d", pressedTag];
            int pinLength = [self.pin length];
            switch (pinLength) {
                case 1:
                    self.pinTextField1.text = [NSString stringWithFormat:@"%d", pressedTag];
                    break;
                case 2:
                    self.pinTextField2.text = [NSString stringWithFormat:@"%d", pressedTag];
                    break;
                case 3:
                    self.pinTextField3.text = [NSString stringWithFormat:@"%d", pressedTag];
                    break;
                case 4:
                    self.pinTextField4.text = [NSString stringWithFormat:@"%d", pressedTag];
                    break;
                default:
                    break;
            }
            if (self.pin.length == 4) {
                NSError *error = nil;
                NSString *savedCode = [SFHFKeychainUtils getPasswordForUsername:@"pinlockCode" andServiceName:self.serviceNameKeychain error:&error];
                
                self.maxAttempts = [NSNumber numberWithInt:[self.maxAttempts intValue]-1];
                [[NSUserDefaults standardUserDefaults] setObject:self.maxAttempts forKey:@"pinlockAttemptsLeft"];
                
                if ([savedCode isEqualToString:self.pin]) {
                    //setPinlockLastDateShown
                    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"pinlockLastDateShown"];
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"pinlockAttemptsLeft"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"PinlockOnScreen"];
                    [self.delegate pinlockCorrect:YES attemptsLeft:self.maxAttempts viewController:self];
                    [self removeView:self];
                }
                else {
                    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(clearTextFields) userInfo:nil repeats:NO];
                    [self.delegate pinlockCorrect:NO attemptsLeft:self.maxAttempts viewController:self];
                }
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }
}

-(IBAction)removeView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
