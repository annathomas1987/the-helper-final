//
//  TipViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) Client XYZ. All rights reserved.
//

#import "TipViewController.h"
#import "TheCalculatorClass.h"

@interface TipViewController ()

@end

@implementation TipViewController

@synthesize billAmount;
@synthesize tipRateLabel;
@synthesize tipRate;
@synthesize tipSlider;
@synthesize tipCalculateButton;

- (void)calculateTip:(id)sender   
{  
    TheCalculatorClass *calculateObject;
    long amount = [[billAmount text] intValue];
    float rate = [[tipRate text] floatValue];
    tipToGive = [calculateObject calculate:amount Tip:rate];
    NSLog(@"Tip to give : %d", tipToGive);
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
        TipResultViewController *tipObject = [segue destinationViewController];
        tipObject.infoRequest = [NSNumber numberWithInteger:tipToGive];
    }
}

 
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.billAmount = nil;
    self.tipRate = nil;
    self.tipSlider = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
