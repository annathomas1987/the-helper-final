//
//  TipViewController.h
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) Client XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipResultViewController.h"


@interface TipViewController : UIViewController{
    
    UITextField *billAmount;  
    UILabel     *tipRateLabel;
    IBOutlet UITextField *tipRate;
    IBOutlet UISlider *tipSlider;
    UIButton *tipCalculateButton;
    float tipToGive, totalAmount;
    UITextField *activeField;
    UILabel *warningForBill;
}
@property (nonatomic, retain) IBOutlet UILabel *warningForBill;

@property (nonatomic, retain) IBOutlet UITextField *billAmount;  
@property (nonatomic, retain) IBOutlet UILabel *tipRateLabel;  
@property (nonatomic, retain) IBOutlet UITextField *tipRate;
@property (nonatomic, retain) IBOutlet UISlider *tipSlider;
@property (nonatomic, retain) IBOutlet UIButton *tipCalculateButton;
@property (nonatomic, retain) IBOutlet UITextField *activeField;

- (IBAction) sliderValueChanged:(id)sender; 
- (IBAction) calculateTip:(id)sender;  
- (IBAction) backgroundTouchedHideKeyboard:(id)sender;
- (void) checkAndChangeSlider;
- (void) changeButtonStatus;

@end
