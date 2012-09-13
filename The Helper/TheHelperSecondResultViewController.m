//
//  TheHelperSecondResultViewController.m
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TheHelperSecondResultViewController.h"

@interface TheHelperSecondResultViewController ()

@end

@implementation TheHelperSecondResultViewController


@synthesize infoRequest;
@synthesize calculatedTip;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.calculatedTip.text = [NSString stringWithFormat:@"Tip : Rs. %@/-", [self.infoRequest description]];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
