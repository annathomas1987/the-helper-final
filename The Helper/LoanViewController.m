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
        NSLog(@"h%@--%@--%@h", principalAmount.text,rateAmount.text, loanTerm.text);
        calculateButton.enabled = YES;
        calculateButton.alpha = enableValue;
    } 
    else {
        calculateButton.enabled = NO;
        calculateButton.alpha = disableValue;
    }
    NSLog(@"the value : %d",!([principalAmount.text isEqualToString:@""]  || [rateAmount.text isEqualToString:@""] || [loanTerm.text isEqualToString:@""]));
}


- (void) backgroundTouchedHideKeyboard:(id)sender {
    NSLog(@"touched");
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
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int intValue;
    activeField = nil;
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
    //Assign new frame to your view
    //[self.view setFrame:CGRectMake(0,-20,320,460)];
    //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    NSDictionary* info = [aNotification userInfo];
    CGSize keyBoardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyBoardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -=keyBoardSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin)) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-keyBoardSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

-(void)keyboardDidHide:(NSNotification *)aNotification
{
    //[self.view setFrame:CGRectMake(0,0,320,460)];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [warningForLoan setHidden:YES];
    [warningForPrincipal setHidden:YES];
    rateAmount.keyboardType = UIKeyboardTypeDecimalPad;
    calculateButton.enabled = NO;
    calculateButton.alpha = disableValue;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidShowNotification object:nil];
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
