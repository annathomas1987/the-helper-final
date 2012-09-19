//
//  TipViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) Client XYZ. All rights reserved.
//

#import "TipViewController.h"
#import "TheCalculatorClass.h"
#import "constants.h"

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
    TheCalculatorClass *calculateObject=[[TheCalculatorClass alloc]init];
    long int amount = [[billAmount text] longLongValue];
    float rate = [[tipRate text] floatValue];
    //call the function to calculate the tip
    tipToGive = [calculateObject calculate:amount Tip:rate];
    totalAmount = [calculateObject calculateTotalBill:amount];
}  

- (void) checkAndChangeSlider {
    float sliderValue = [[tipRate text] floatValue];
    if (sliderValue > maxValue) { sliderValue = maxValue; }
    if (sliderValue < minValue) { sliderValue = minValue; }
    [tipSlider setValue:sliderValue];
    tipRate.text = [NSString stringWithFormat:@"%.1f", sliderValue];

}

- (void) changeButtonStatus {
    if (!([billAmount.text isEqualToString:blank] || [tipRate.text isEqualToString:blank])) {
        tipCalculateButton.enabled = YES;
        tipCalculateButton.alpha = enableValue;
    } 
    else {
        tipCalculateButton.enabled = NO;
        tipCalculateButton.alpha = disableValue;
    }

}

- (void)backgroundTouchedHideKeyboard:(id)sender  
{  
    [self checkAndChangeSlider];
    [self changeButtonStatus];
    [billAmount resignFirstResponder];  
    [tipRate resignFirstResponder];
}  

- (IBAction) sliderValueChanged:(UISlider *)sender {  
    tipRate.text = [NSString stringWithFormat:@"%.1f", [sender value]];  
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:TipResultPage]) {
        TipResultViewController *tipObject = [segue destinationViewController];
        tipObject.tip = [NSNumber numberWithInteger:tipToGive];
        tipObject.totalAmount = [NSNumber numberWithInteger:totalAmount];
        //tipObject
    }
}

 
- (void)viewDidLoad
{
    [super viewDidLoad];
    tipRate.keyboardType = UIKeyboardTypeDecimalPad;
    tipCalculateButton.enabled = NO;
    tipCalculateButton.alpha = disableValue;
    
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
