//
//  EmiViewController.h
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmiResultViewController.h"
#import "EmiCalculatorClass.h"
#import "constants.h"

extern NSString * const EmiResultPage;
//extern NSString * const xmlTagForEmi;
//extern NSString * const xmlTagForTotalInterest;
//extern NSString * const xmlTagForTotalPayment;

@interface EmiViewController : UIViewController <NSXMLParserDelegate> {

    UITextField *principalAmount;  
    UILabel     *rateLabel;
    UITextField *rateAmount;
    UISlider *rateSlider;
    UITextField *loanTerm;
    UIButton *calculateButton;
    UILabel *warningForLoan;
    UILabel *warningForPrincipal;
    long int Emi, totalInterest, totalPayment;
    BOOL keyboardShown, viewMoved;
    UIScrollView *scrollView;
    UITextField *activeField;
    NSMutableData *receivedData;
    NSMutableString *currentString;
    EmiCalculatorClass *calculateObject;
}
@property (nonatomic, retain) IBOutlet UILabel *warningForPrincipal;
@property (nonatomic, retain) IBOutlet UILabel *warningForLoan;
@property (nonatomic, retain) IBOutlet UITextField *principalAmount;  
@property (nonatomic, retain) IBOutlet UILabel *rateLabel;  
@property (nonatomic, retain) IBOutlet UITextField *rateAmount;
@property (nonatomic, retain) IBOutlet UISlider *rateSlider;
@property (nonatomic, retain) IBOutlet UITextField *loanTerm;
@property (nonatomic, retain) IBOutlet UIButton *calculateButton;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *activeField;


- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) getCalculatedLoan;
- (IBAction) backgroundTouchedHideKeyboard:(id)sender;
- (void) checkAndChangeSlider;
- (void) changeButtonStatus;
- (void) giveWarningIfRequired;
- (IBAction) keyboardDidShow:(NSNotification *)aNotification;
- (IBAction) keyboardDidHide:(NSNotification *)aNotification;
- (IBAction) textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction) textFieldDidEndEditing:(UITextField *)textField;
- (BOOL) isNumeric:(NSString *) text;
- (void) establishConnection;

@end

