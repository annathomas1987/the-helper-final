//
//  TheHelperFirstResultViewController.m
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TheHelperFirstResultViewController.h"

@interface TheHelperFirstResultViewController ()

@end

@implementation TheHelperFirstResultViewController

@synthesize array;
@synthesize calculatedEMI;
@synthesize obtainedEMI;
@synthesize calculatedInterest;
@synthesize obtainedInterest;
@synthesize calculatedPayment;
@synthesize obtainedPayment;


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
   
    self.calculatedEMI.text = [NSString stringWithFormat:@"EMI : Rs. %@ /-", [self.obtainedEMI description]];
    
    self.calculatedInterest.text = [NSString stringWithFormat:@"Total Interest : Rs. %@ /-", [self.obtainedInterest description]];
    
    self.calculatedPayment.text = [NSString stringWithFormat:@"Total Amount Payable : Rs. %@ /-", [self.obtainedPayment description]];
    
    [super viewDidLoad];
    //calculatedEMI.text = [[NSString alloc] initWithFormat:@"EMI : Rs. %d/-", [array objectAtIndex:0]];
    
    // calculatedInterest = [[NSString alloc] initWithFormat:@"Total Interest : Rs. %d/-", [array objectAtIndex:1]];
    
    //calculatedPayment = [[NSString alloc] initWithFormat:@"EMI : Rs. %d/-", [array objectAtIndex:2]];
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
