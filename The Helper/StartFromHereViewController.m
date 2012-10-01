//
//  StartFromHereViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/28/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//
//

#import "StartFromHereViewController.h"

@interface StartFromHereViewController ()

@end

@implementation StartFromHereViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setGetStarted:nil];
    [self setGetStarted:nil];
    [super viewDidUnload];
}
@end
