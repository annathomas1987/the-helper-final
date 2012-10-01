//
//  LoanViewController.h
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanResultViewController.h"

@interface LoanViewController : UIViewController {

    UITextField *principalAmount;  
    UILabel     *rateLabel;
    IBOutlet UITextField *rateAmount;
    IBOutlet UISlider *rateSlider;
    UITextField *loanTerm;
    UIButton *calculateButton;
    long int emi, totalInterest, totalPayment;
    UIScrollView *scrollView;
    UITextField *activeField;
}

@property (nonatomic, retain) IBOutlet UITextField *principalAmount;  
@property (nonatomic, retain) IBOutlet UILabel *rateLabel;  
@property (nonatomic, retain) IBOutlet UITextField *rateAmount;
@property (nonatomic, retain) IBOutlet UISlider *rateSlider;
@property (nonatomic, retain) IBOutlet UITextField *loanTerm;
@property (nonatomic, retain) IBOutlet UIButton *calculateButton;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain)IBOutlet UITextField *activeField;

- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) calculateLoan:(id)sender;  
- (IBAction) backgroundTouchedHideKeyboard:(id)sender;
- (void) checkAndChangeSlider;
- (void) changeButtonStatus;
- (IBAction) keyboardDidShow:(NSNotification *)aNotification;
- (IBAction) keyboardDidHide:(NSNotification *)aNotification;
- (IBAction) textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction) textFieldDidEndEditing:(UITextField *)textField;

@end

