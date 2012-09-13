//
//  TheHelperSecondViewController.h
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheHelperSecondResultViewController.h"

@interface TheHelperSecondViewController : UIViewController{
    
    UITextField *billAmount;  
    UILabel     *tipRateLabel;
    IBOutlet UITextField *tipRate;
    IBOutlet UISlider *tipSlider;
    UIButton *tipCalculateButton;
    int tipToGive;
}

@property (nonatomic, retain) IBOutlet UITextField *billAmount;  
@property (nonatomic, retain) IBOutlet UILabel *tipRateLabel;  
@property (nonatomic, retain) IBOutlet UITextField *tipRate;
@property (nonatomic, retain) IBOutlet UISlider *tipSlider;
@property (nonatomic, retain) IBOutlet UIButton *tipCalculateButton;

- (IBAction) sliderValueChanged:(id)sender; 
- (IBAction) calculateTip:(id)sender;  
- (IBAction) backgroundTouchedHideKeyboard:(id)sender;

@end
