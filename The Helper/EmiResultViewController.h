//
//  EmiResultViewController.h
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) Client XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmiResultViewController : UIViewController {
    UILabel *calculatedEmi;
    UILabel *calculatedInterest;
    UILabel *calculatedPayment;
    id Emi;
    id Payment;
    id Interest;
    
}

@property (nonatomic, retain) id Emi;
@property (nonatomic, retain) id Payment;
@property (nonatomic, retain) id Interest;

@property (strong, nonatomic) IBOutlet UILabel *calculatedEmi;
@property (strong, nonatomic) IBOutlet UILabel *calculatedInterest;
@property (strong, nonatomic) IBOutlet UILabel *calculatedPayment;

@end
