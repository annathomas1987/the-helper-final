//
//  EmiViewController.m
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "EmiViewController.h"

NSString * const EmiResultPage = @"SendLoanInfo";
//NSString * const xmlTagForEmi = @"emi";
//NSString * const xmlTagForTotalInterest = @"totalInterest";
//NSString * const xmlTagForTotalPayment = @"totalPayment";

@interface EmiViewController ()

@end

@implementation EmiViewController

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

//This function collects and returns to the view controller the calculated values.

- (void) establishConnection {
    long int principal = [[principalAmount text] longLongValue];
    float rate = [[rateAmount text] floatValue];
    int time = [[loanTerm text] intValue];
    calculateObject = [[EmiCalculatorClass alloc]init];
    [calculateObject setData:principal :rate :time];
    
}
- (void)getCalculatedLoan
{
    //[self establishConnection];
    Emi = [calculateObject getEmiValue];
    totalInterest = [calculateObject getTotalInterest];
    totalPayment = [calculateObject getTotalPayment];
}

// This function is for changing the slider when user enters a value into the related text field. - This function also includes the validation for the text filed entry.

- (void) checkAndChangeSlider {
    if (![rateAmount.text isEqualToString:@""]) {
        float sliderValue = [[rateAmount text] floatValue];
        if (sliderValue > maxValue){ sliderValue = maxValue;}
        if (sliderValue < minValue) {sliderValue = minValue;}
        [rateSlider setValue:sliderValue];
        rateAmount.text = [NSString stringWithFormat:@"%.1f", sliderValue];
    }
}

//This function is for changing the text Field value when the user has changed the value in the slider.

- (IBAction) sliderValueChanged:(UISlider *)sender {
    rateAmount.text = [NSString stringWithFormat:@"%.1f", [sender value]];
    [self changeButtonStatus];
}

// This function ensures that the user is able to click the button only after all the required entries are made. 
- (void) changeButtonStatus {
    if (!([principalAmount.text isEqualToString:@""] || [rateAmount.text isEqualToString:@""] || [loanTerm.text isEqualToString:@""])) {
        [self establishConnection];
        calculateButton.enabled = YES;
        calculateButton.alpha = enableValue;
    }
    else {
        calculateButton.enabled = NO;
        calculateButton.alpha = disableValue;
    }
}

//This function checks whether the text passed is completely numeric or not - Code taken from internet.
- (BOOL) isNumeric:(NSString *)text {
    NSUInteger length = [text length];
    NSUInteger i;
    BOOL status = NO;
    for (i=0; i < length; i++) {
        unichar singlechar = [text characterAtIndex:i];
        //this first condition is to check if there are any blank spaces before the numbers
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

// this function gives warning message to user, if the value entered is either null or wrong.
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

 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     [self getCalculatedLoan];
    if ([[segue identifier] isEqualToString:EmiResultPage]) {
        EmiResultViewController *emiObject = [segue destinationViewController];
        emiObject.Emi = [NSNumber numberWithInteger:Emi];
        emiObject.Interest = [NSNumber numberWithInteger:totalInterest];
        emiObject.Payment = [NSNumber numberWithInteger:totalPayment];
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

//this function does changes to the view only for the loan term text field as of now, as that is the only function that is getting hidden when the keyboard appears. Could be changed later on if required.
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
