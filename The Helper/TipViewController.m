//
//  TipViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) Client XYZ. All rights reserved.
//

#import "TipViewController.h"
#import "TipCalculatorClass.h"

NSString * const TipResultPage = @"SendTipInfo";

@interface TipViewController ()

@end

@implementation TipViewController

@synthesize billAmount;
@synthesize tipRateLabel;
@synthesize tipRate;
@synthesize tipSlider;
@synthesize tipCalculateButton;
@synthesize warningForBill;
@synthesize activeField;
@synthesize scrollView;

- (void) establishConnection {
    
    long int amount = [[billAmount text] longLongValue];
    float rate = [[tipRate text] floatValue];
    calculateObject = [[TipCalculatorClass alloc]init];
    [calculateObject setData:amount :rate];
}

- (void)getCalculatedTip
{
    tipToGive = [calculateObject getTip];
    totalAmount = [calculateObject getTotalBill];    
}  

// This function is for changing the slider when user enters a value into the related text field. - This function also includes the validation for the text filed entry.

- (void) checkAndChangeSlider {
    if (![tipRate.text isEqualToString:@""]) {
        float sliderValue = [[tipRate text] floatValue];
        if (sliderValue > maxValue) { sliderValue = maxValue; }
        if (sliderValue < minValue) { sliderValue = minValue; }
        [tipSlider setValue:sliderValue];
        tipRate.text = [NSString stringWithFormat:@"%.1f", sliderValue];
    }
}

//This function is for changing the text Field value when the user has changed the value in the slider.

- (IBAction) sliderValueChanged:(UISlider *)sender {
    tipRate.text = [NSString stringWithFormat:@"%.1f", [sender value]];
    //changeButtonStatus function is called to enable the button so that user doesn't have to touch background to enable button - cos otherwise the function is called only when background is touched.
    [self changeButtonStatus];
}

- (BOOL) isNumeric:(NSString *)text {
    NSUInteger length = [text length];
    NSUInteger i;
    BOOL status = NO;
    for (i=0; i < length; i++) {
        unichar singlechar = [text characterAtIndex:i];
        if ((singlechar == ' ') && (!status)) {
            continue;
        }
        if ((singlechar == '+') && (!status)) {
            status = YES;
            continue;
        }
        if ((singlechar >= '0') && (singlechar <= '9')) {
            status = YES;
        }
        else {
            return NO;
        }
    }
    return (i == length) && status;
}

- (void) giveWarningIfRequired {
    if (activeField == billAmount) {
        if (activeField.text.length>0 && [self isNumeric:activeField.text]) {
            [warningForBill setHidden:YES];
        }
        else {
            [warningForBill setHidden:NO];
            activeField.text = nil;
        }
    }
}
- (void) changeButtonStatus {
    if (!([billAmount.text isEqualToString:@""] || [tipRate.text isEqualToString:@""])) {
        [self establishConnection];
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
    NSLog(@"backgroud touched");
    [self checkAndChangeSlider];
    [self giveWarningIfRequired];
    [self changeButtonStatus];
    [billAmount resignFirstResponder];  
    [tipRate resignFirstResponder];
}  


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self getCalculatedTip];
    if ([[segue identifier] isEqualToString:TipResultPage]) {
        TipResultViewController *tipObject = [segue destinationViewController];
        tipObject.tip = [NSNumber numberWithInteger:tipToGive];
        tipObject.totalAmount = [NSNumber numberWithInteger:totalAmount];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tipRate.keyboardType = UIKeyboardTypeDecimalPad;
    tipCalculateButton.enabled = NO;
    tipCalculateButton.alpha = disableValue;
    [warningForBill setHidden:YES];
}

- (void)viewDidUnload
{
    [self setWarningForBill:nil];
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
