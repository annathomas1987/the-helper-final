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

- (void) backgroundTouchedHideKeyboard:(id)sender {
    NSLog(@"background is touched..");
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


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    if (textField == loanTerm) {
        viewMoved = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int intValue;
    activeField = nil;
    if (textField == loanTerm) {
        viewMoved = YES;
    }
    if (textField.text.length>0 && [[NSScanner scannerWithString:textField.text] scanInt:&intValue]) {
        if (textField == principalAmount) {
            [warningForPrincipal setHidden:YES];
        }
        else {
             [warningForLoan setHidden:YES];
        }       
    }
    else {
        if (textField == principalAmount) {
            [warningForPrincipal setHidden:NO];
        }
        else {
            [warningForLoan setHidden:NO];
        }
        textField.text = nil;
    }
}

- (void)keyboardDidShow:(NSNotification *)aNotification
{
    NSLog(@"keyboard came");
    if (keyboardShown) {
        return;
    }
    if (activeField == loanTerm) {
        NSDictionary* info = [aNotification userInfo];
        CGSize keyBoardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGRect aRect = self.view.frame;
        aRect.origin.y -= keyBoardSize.height;
        aRect.size.height -=keyBoardSize.height;
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
    NSLog(@"keyboard went");
    if (viewMoved) {
        NSDictionary *info = [aNotification userInfo];
        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

        NSTimeInterval animationDuration = 0.300000011920929;
        CGRect frame = self.view.frame;
        frame.origin.y += keyboardSize.height;
        frame.size.height -= keyboardSize.height;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
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
