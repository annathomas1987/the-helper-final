//
//  LoanViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "LoanViewController.h"
#import "TheCalculatorClass.h"
#import "constants.h"

@interface LoanViewController ()

@end

@implementation LoanViewController

@synthesize principalAmount;
@synthesize rateLabel;
@synthesize rateAmount;
@synthesize rateSlider;
@synthesize loanTerm;
@synthesize calculateButton;


- (void)calculateLoan:(id)sender   
{  
    TheCalculatorClass *calculatorObject = [[TheCalculatorClass alloc]init];
    long int principal = [[principalAmount text] longLongValue];  
    float rate = [[rateAmount text] floatValue];
    int time = [[loanTerm text] intValue];
    //call the function to calculate emi
    emi = [calculatorObject calculate:principal Emi:rate formula:time];
    //call the function to calculate total Interest
    totalInterest = [calculatorObject calculate:time totalInterest:principal];   
    // call the function to calculate total Payment
    totalPayment = [calculatorObject calculateTotalPayment:principal];
}  

- (void) checkAndChangeSlider {
    float sliderValue = [[rateAmount text] floatValue];
    if (sliderValue > maxValue){ sliderValue = maxValue;}
    if (sliderValue < minValue) {sliderValue = minValue;}
    [rateSlider setValue:sliderValue];
    rateAmount.text = [NSString stringWithFormat:@"%.1f", sliderValue];
}

- (void) changeButtonStatus {
    
    if (!([principalAmount.text isEqualToString:blank] || [rateAmount.text isEqualToString:blank] || [loanTerm.text isEqualToString:blank])) {
        calculateButton.enabled = YES;
        calculateButton.alpha = enableValue;
    } 
    else {
        calculateButton.enabled = NO;
        calculateButton.alpha = disableValue;
    }

}
- (void) backgroundTouchedHideKeyboard:(id)sender {     
    [self checkAndChangeSlider];
    [self changeButtonStatus];
    [principalAmount resignFirstResponder];  
    [rateAmount resignFirstResponder];
    [loanTerm resignFirstResponder];
}  

- (IBAction) sliderValueChanged:(UISlider *)sender {  
    rateAmount.text = [NSString stringWithFormat:@"%.1f", [sender value]];  
}  

 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:LoanResultPage]) {
        LoanResultViewController *loanObject = [segue destinationViewController];
        loanObject.Emi = [NSNumber numberWithInteger:emi];
        loanObject.Interest = [NSNumber numberWithInteger:totalInterest];
        loanObject.Payment = [NSNumber numberWithInteger:totalPayment];
    }
} 

- (void)viewDidLoad
{
    [super viewDidLoad];
    rateAmount.keyboardType = UIKeyboardTypeDecimalPad;
    calculateButton.enabled = NO;
    calculateButton.alpha = disableValue;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.principalAmount = nil;
    self.rateAmount = nil;
    self.rateSlider = nil;
    self.loanTerm = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
