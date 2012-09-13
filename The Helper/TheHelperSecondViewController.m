//
//  TheHelperSecondViewController.m
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TheHelperSecondViewController.h"

@interface TheHelperSecondViewController ()

@end

@implementation TheHelperSecondViewController

@synthesize billAmount;
@synthesize tipRateLabel;
@synthesize tipRate;
@synthesize tipSlider;
@synthesize tipCalculateButton;

- (void)calculateTip:(id)sender   
{  
    int amount = [[billAmount text] intValue];
    int rate = [[tipRate text] intValue];
    tipToGive = amount * rate /100;
}  

- (void)backgroundTouchedHideKeyboard:(id)sender  
{  
    [billAmount resignFirstResponder];  
    [tipRate resignFirstResponder];
}  

- (IBAction) sliderValueChanged:(UISlider *)sender {  
    tipRate.text = [NSString stringWithFormat:@"%.1f", [sender value]];  
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"SendTipInfo"]) {
        TheHelperSecondResultViewController *secondresultViewController = [segue destinationViewController];
        //This is the id infoRequest, which is a pointer to the object
        //Look at the viewDidLoad in the Destination implementation.
        
        
        //this line is imp. pass the calculated value to this
        secondresultViewController.infoRequest = [NSNumber numberWithInteger:tipToGive];
    }
}

 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.billAmount = nil;
    self.tipRate = nil;
    self.tipSlider = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
