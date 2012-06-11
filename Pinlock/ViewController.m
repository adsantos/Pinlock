//
//  ViewController.m
//  Pinlock
//
//  Created by Adriana Santos on 09/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PinlockViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)loadView {
    [super loadView];
}

-(IBAction)createPinlock:(id)sender {
    CreatePinlockViewController *createPinlockVC = (CreatePinlockViewController *)[[CreatePinlockViewController alloc] initWithNibName:@"PinlockViewController" bundle:[NSBundle mainBundle]];
    createPinlockVC.delegate = self;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        createPinlockVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    else {
        createPinlockVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    [self presentModalViewController:createPinlockVC animated:NO];
    
}

-(IBAction)viewPinlock:(id)sender {
    PinlockViewController *pinlockVC = (PinlockViewController *)[[PinlockViewController alloc] initWithNibName:@"PinlockViewController" bundle:[NSBundle mainBundle]];
    pinlockVC.delegate = self;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        pinlockVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    else {
        pinlockVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    [self presentModalViewController:pinlockVC animated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)pinlockCorrect:(BOOL)correct attemptsLeft:(NSNumber *)attemptsLeftNumber viewController:(PinlockViewController *)vc {
    if ([attemptsLeftNumber intValue] == 0 && !correct) {
        NSLog(@"NO MORE ATTEMPTS");
    }
}

-(void)pinlockCreatedCorrectly:(BOOL)success viewController:(CreatePinlockViewController *)vc {
    
}

@end
