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
}

@property (nonatomic, retain) IBOutlet UITextField *principalAmount;  
@property (nonatomic, retain) IBOutlet UILabel *rateLabel;  
@property (nonatomic, retain) IBOutlet UITextField *rateAmount;
@property (nonatomic, retain) IBOutlet UISlider *rateSlider;
@property (nonatomic, retain) IBOutlet UITextField *loanTerm;
@property (nonatomic, retain) IBOutlet UIButton *calculateButton;

- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) calculateLoan:(id)sender;  
- (IBAction) backgroundTouchedHideKeyboard:(id)sender;
- (void) checkAndChangeSlider;
- (void) changeButtonStatus;

@end

