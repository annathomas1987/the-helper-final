//
//  TipViewController.h
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) Client XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipResultViewController.h"
//#import "TipCalculatorClass.h"
#import "constants.h"


extern NSString * const TipResultPage;
extern NSString * const jsonKeyForTip;
extern NSString * const jsonKeyForTotalAmount;

@interface TipViewController : UIViewController{
    
    UITextField *billAmount;  
    UILabel     *tipRateLabel;
    IBOutlet UITextField *tipRate;
    IBOutlet UISlider *tipSlider;
    UIButton *tipCalculateButton;
    float tipToGive, totalAmount;
    UITextField *activeField;
    UILabel *warningForBill;
    UIScrollView *scrollView;
    NSMutableData *receivedData;
}
@property (nonatomic, retain) IBOutlet UILabel *warningForBill;
@property (nonatomic, retain) IBOutlet UITextField *billAmount;  
@property (nonatomic, retain) IBOutlet UILabel *tipRateLabel;  
@property (nonatomic, retain) IBOutlet UITextField *tipRate;
@property (nonatomic, retain) IBOutlet UISlider *tipSlider;
@property (nonatomic, retain) IBOutlet UIButton *tipCalculateButton;
@property (nonatomic, retain) IBOutlet UITextField *activeField;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction) sliderValueChanged:(id)sender; 
- (IBAction) getCalculatedTip;
- (IBAction) backgroundTouchedHideKeyboard:(id)sender;
- (void) checkAndChangeSlider;
- (void) changeButtonStatus;
- (void) giveWarningIfRequired;
- (IBAction) textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction) textFieldDidEndEditing:(UITextField *)textField;
- (BOOL) isNumeric:(NSString *) text;
@end
