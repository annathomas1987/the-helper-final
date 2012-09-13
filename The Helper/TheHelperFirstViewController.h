//
//  TheHelperFirstViewController.h
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheHelperFirstResultViewController.h"

@interface TheHelperFirstViewController : UIViewController {

    UITextField *principalAmount;  
    UILabel     *rateLabel;
    IBOutlet UITextField *rateAmount;
    IBOutlet UISlider *rateSlider;
    UITextField *loanTerm;
    UIButton *calculateButton;
    //NSMutableArray *passArray;
    long int emi, totalInterest, totalPayment;
}
//@property (nonatomic, retain) NSArray *passArray;
@property (nonatomic, retain) IBOutlet UITextField *principalAmount;  
@property (nonatomic, retain) IBOutlet UILabel *rateLabel;  
@property (nonatomic, retain) IBOutlet UITextField *rateAmount;
@property (nonatomic, retain) IBOutlet UISlider *rateSlider;
@property (nonatomic, retain) IBOutlet UITextField *loanTerm;
@property (nonatomic, retain) IBOutlet UIButton *calculateButton;

- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) calculateLoan:(id)sender;  
- (IBAction) backgroundTouchedHideKeyboard:(id)sender;

@end

