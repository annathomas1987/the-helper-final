//
//  LoanFirstResultViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "LoanResultViewController.h"


@interface LoanResultViewController ()

@end

@implementation LoanResultViewController

@synthesize calculatedEmi;
@synthesize Emi;
@synthesize calculatedInterest;
@synthesize Interest;
@synthesize calculatedPayment;
@synthesize Payment;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.jpg"] drawInRect:self.view.bounds];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    self.calculatedEmi.text = [NSString stringWithFormat:@"%@", [self.Emi description]];
    
    self.calculatedInterest.text = [NSString stringWithFormat:@"%@", [self.Interest description]];
    
    self.calculatedPayment.text = [NSString stringWithFormat:@"%@", [self.Payment description]];
   
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
