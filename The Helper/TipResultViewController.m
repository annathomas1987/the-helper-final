//
//  TipResultViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "TipResultViewController.h"

@interface TipResultViewController ()

@end

@implementation TipResultViewController

@synthesize infoRequest;
@synthesize calculatedTip;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    self.calculatedTip.text = [NSString stringWithFormat:@"Tip : Rs. %@/-", [self.infoRequest description]];

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
