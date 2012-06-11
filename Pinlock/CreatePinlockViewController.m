//
//  AddPinlockViewController.m
//  Pinlock
//
//  Created by Adriana Santos on 09/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CreatePinlockViewController.h"
#import "SFHFKeychainUtils.h"
#import "ConstantsPinlock.h"
#import "PinlockDelegate.h"

@interface CreatePinlockViewController ()
@property (nonatomic, assign) IBOutlet UIView *pinlockView;
@property (nonatomic, assign) IBOutlet UIView *transparentView;
@property (nonatomic, retain) IBOutlet UITextField *pinTextField1;
@property (nonatomic, retain) IBOutlet UITextField *pinTextField2;
@property (nonatomic, retain) IBOutlet UITextField *pinTextField3;
@property (nonatomic, retain) IBOutlet UITextField *pinTextField4;
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) NSString *pinTry1;
@property (nonatomic, retain) NSString *pinTry2;
@property (nonatomic, assign) IBOutlet UILabel *failedPasscodeLabel;
@property (nonatomic, assign) IBOutlet UIView *failedLabelBackground;
@property (nonatomic, retain) NSString *message;
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

-(IBAction)removeView:(id)sender;
@end

@implementation CreatePinlockViewController
@synthesize backgroundColor;
@synthesize serviceNameKeychain;
@synthesize delegate;
@synthesize pinlockView;
@synthesize transparentView;
@synthesize pinTextField1;
@synthesize pinTextField2;
@synthesize pinTextField3;
@synthesize pinTextField4;
@synthesize pinTry1;
@synthesize pinTry2;
@synthesize messageLabel;
@synthesize failedLabelBackground;
@synthesize message;
@synthesize failedPasscodeLabel;
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!self.backgroundColor) {
            self.backgroundColor = [UIColor lightGrayColor];
        }
        if (!self.serviceNameKeychain) {
            self.serviceNameKeychain = @"pinlockApp";
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil backgroundColor:(UIColor *)color serviceNameKeychain:(NSString *)serviceName bundle:(NSBundle *)nibBundleOrNil {
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
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated {
    self.messageLabel.text = NSLocalizedString(@"Create passcode", @"");
    showPinViewAgain = YES;
    self.pinTextField1.text = nil;
    self.pinTextField2.text = nil;
    self.pinTextField3.text = nil;
    self.pinTextField4.text = nil;
}

-(void)loadView {
    [super loadView];
    
    self.failedLabelBackground.layer.cornerRadius = 15.0f;
    self.failedLabelBackground.layer.masksToBounds = YES;
    self.failedLabelBackground.hidden = YES;
    self.pinTry1 = @"";
    self.pinTry2 = @"";
    
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.transparentView setBackgroundColor:self.backgroundColor];
}

-(void)viewDidUnload {
    [super viewDidUnload];
    self.pinTextField1 = nil;
    self.pinTextField2 = nil;
    self.pinTextField3 = nil;
    self.pinTextField4 = nil;
    self.messageLabel = nil;
    self.pinTry1 = nil;
    self.pinTry2 = nil;
    self.message = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else {
        return NO;
    }
}

-(void)clearTextFields {
    self.messageLabel.text = NSLocalizedString(self.message, @"");
    self.pinTextField1.text = nil;
    self.pinTextField2.text = nil;
    self.pinTextField3.text = nil;
    self.pinTextField4.text = nil;
}

-(IBAction)removeView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)updateTextFieldsButtonPressed:(id)sender forPin:(NSString *)pin {
    
    UIButton *bt = (UIButton *) sender;
    int pressedTag = bt.tag;
    NSLog(@"label : %d , sender %@ ", pressedTag, sender);
    if (pressedTag == BACKSPACE){
        if (pin && [pin length] > 0) {
            pin = [pin substringToIndex:[pin length]-1];
            if (showPinViewAgain) {
                self.pinTry1 = pin;
            }
            else {
                self.pinTry2 = pin;
            }
            int pinLength = [pin length];
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
            pin = [pin stringByAppendingFormat:@"%d", pressedTag];
            if (showPinViewAgain) {
                self.pinTry1 = pin;
            }
            else {
                self.pinTry2 = pin;
            }
            int pinLength = [pin length];
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
        }
    }
}

- (IBAction)buttonPress:(id)sender {
    
    if (!self.failedPasscodeLabel.hidden) {
        self.failedPasscodeLabel.hidden = YES;
        self.failedLabelBackground.hidden = YES;
    }
    
    if (showPinViewAgain) {
        [self updateTextFieldsButtonPressed:sender forPin:self.pinTry1];
        
        if (self.pinTry1.length == 4) {
            showPinViewAgain = NO;
            self.message = NSLocalizedString(@"Re-enter passcode",@"");
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(clearTextFields) userInfo:nil repeats:NO];
        }
    }
    else {
        [self updateTextFieldsButtonPressed:sender forPin:self.pinTry2];
        
        if (self.pinTry2.length == 4) {
            if ([self.pinTry1 isEqualToString:self.pinTry2]) {            
                NSError *error = nil;
                [SFHFKeychainUtils storeUsername:@"pinlockCode" andPassword:self.pinTry1 forServiceName:serviceNameKeychain updateExisting:YES error:&error];
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"pinlockLastDateShown"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self removeView:self];
                [self.delegate pinlockCreatedCorrectly:YES viewController:self];
            }
            else {
                showPinViewAgain = YES;
                self.failedPasscodeLabel.text = NSLocalizedString(@"Passcode-no match",@"");
                self.failedPasscodeLabel.hidden = NO;
                self.failedLabelBackground.hidden = NO;
                self.message = NSLocalizedString(@"Create passcode", @"");
                [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(clearTextFields) userInfo:nil repeats:NO];
                [self.delegate pinlockCreatedCorrectly:NO viewController:self];
            }
            self.pinTry1 = @"";
            self.pinTry2 = @"";
        }
    }
}

@end
