//
//  TheHelperFirstViewController.m
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TheHelperFirstViewController.h"

@interface TheHelperFirstViewController ()

@end

@implementation TheHelperFirstViewController

//@synthesize passArray;
@synthesize principalAmount;
@synthesize rateLabel;
@synthesize rateAmount;
@synthesize rateSlider;
@synthesize loanTerm;
@synthesize calculateButton;


- (void)calculateLoan:(id)sender   
{  
    long int principal = [[principalAmount text] longLongValue];  
    float rate = [[rateAmount text] floatValue];
    int time = [[loanTerm text] intValue];
    //code to calculate loan 
    rate = rate/1200;
    
    emi = principal * rate;
    float temp = 1+rate;
    temp = powf(temp, time);
    emi = emi * temp/(temp-1);
    totalInterest = (emi*time) - principal;
    totalPayment = principal + totalInterest;
    
    /*passArray = [NSMutableArray array];
    [passArray addObject:[NSNumber numberWithInt:(emi)]];
    [passArray addObject:[NSNumber numberWithInt:(totalInterest)]];
     [passArray addObject:[NSNumber numberWithInt:(totalPayment)]];
    TheHelperFirstResultViewController *passObject = [[TheHelperFirstResultViewController alloc] initWithNibName:@"TheHelperFirstResultViewController" bundle: nil];
    passObject.array = passArray ;*/
}  

- (void)backgroundTouchedHideKeyboard:(id)sender  
{  
    [principalAmount resignFirstResponder];  
    [rateAmount resignFirstResponder];
    [loanTerm resignFirstResponder];
}  

- (IBAction) sliderValueChanged:(UISlider *)sender {  
    rateAmount.text = [NSString stringWithFormat:@"%.1f", [sender value]];  
}  

 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"SendLoanInfo"]) {
        TheHelperFirstResultViewController *firstresultViewController = [segue destinationViewController];
        
        //This is the id infoRequest, which is a pointer to the object
        //Look at the viewDidLoad in the Destination implementation.
        
        //this line is imp. pass the calculated value to this
                
        firstresultViewController.obtainedEMI = [NSNumber numberWithInteger:emi];
        firstresultViewController.obtainedInterest = [NSNumber numberWithInteger:totalInterest];
        firstresultViewController.obtainedPayment = [NSNumber numberWithInteger:totalPayment];
        
    }
} 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
