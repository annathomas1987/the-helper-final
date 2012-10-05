//
//  LoanViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "LoanViewController.h"
#import "TheCalculatorClass.h"
#import "c"

@interface LoanViewController ()

@end

@implementation LoanViewController

@synthesize principalAmount;
@synthesize rateLabel;
@synthesize rateAmount;
@synthesize rateSlider;
@synthesize loanTerm;
@synthesize calculateButton;
@synthesize scrollView;
@synthesize activeField;
@synthesize warningForLoan;
@synthesize warningForPrincipal;

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
    if (![rateAmount.text isEqualToString:@""]) {
        float sliderValue = [[rateAmount text] floatValue];
        if (sliderValue > maxValue){ sliderValue = maxValue;}
        if (sliderValue < minValue) {sliderValue = minValue;}
        [rateSlider setValue:sliderValue];
        rateAmount.text = [NSString stringWithFormat:@"%.1f", sliderValue];
    }
}

- (void) changeButtonStatus {
    if (!([principalAmount.text isEqualToString:@""] || [rateAmount.text isEqualToString:@""] || [loanTerm.text isEqualToString:@""])) {
        calculateButton.enabled = YES;
        calculateButton.alpha = enableValue;
    }
    else {
        calculateButton.enabled = NO;
        calculateButton.alpha = disableValue;
    }
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
    if (activeField == principalAmount || activeField == loanTerm) {
        if (activeField.text.length>0 && [self isNumeric:activeField.text]) {
            if (activeField == principalAmount) {
                [warningForPrincipal setHidden:YES];
            }
            else {
                [warningForLoan setHidden:YES];
            }
        }
        else {
            if (activeField == principalAmount) {
                [warningForPrincipal setHidden:NO];
            }
            else {
                [warningForLoan setHidden:NO];
            }
            activeField.text = @"";
        }
    }

}

- (void) backgroundTouchedHideKeyboard:(id)sender {
    [self checkAndChangeSlider];
    [self giveWarningIfRequired];
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

- (void)keyboardDidShow:(NSNotification *)aNotification
{
    if (keyboardShown) {
        return;
    }
    if (activeField == loanTerm) {
        NSDictionary* info = [aNotification userInfo];
        NSValue *aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
        CGSize keyBoardSize = [aValue CGRectValue].size;
        CGRect aRect = self.view.frame;
        aRect.origin.y -= keyBoardSize.height-44;
        aRect.size.height +=keyBoardSize.height-44;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        self.view.frame = aRect;
        [UIView commitAnimations];
        viewMoved = YES;
    }
    keyboardShown = YES;
}

-(void)keyboardDidHide:(NSNotification *)aNotification
{
    if (viewMoved) {
        NSDictionary *info = [aNotification userInfo];
        NSValue *aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
        CGSize keyboardSize = [aValue CGRectValue].size;
        CGRect frame = self.view.frame;
        frame.origin.y += keyboardSize.height-44;
        frame.size.height -= keyboardSize.height-44;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.view.frame = frame;
        [UIView commitAnimations];
        
        viewMoved = NO;

    }
    keyboardShown = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    viewMoved = NO;
    keyboardShown = NO;
    [warningForLoan setHidden:YES];
    [warningForPrincipal setHidden:YES];
    rateAmount.keyboardType = UIKeyboardTypeDecimalPad;
    calculateButton.enabled = NO;
    calculateButton.alpha = disableValue;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:self.view.window];
}

- (void)viewDidUnload
{
    warningForPrincipal = nil;
    [self setWarningForPrincipal:nil];
    warningForLoan = nil;
    [self setWarningForPrincipal:nil];
    [self setWarningForLoan:nil];
    [super viewDidUnload];
    self.principalAmount = nil;
    self.rateAmount = nil;
    self.rateSlider = nil;
    self.loanTerm = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
