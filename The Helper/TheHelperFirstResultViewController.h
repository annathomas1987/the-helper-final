//
//  TheHelperFirstResultViewController.h
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheHelperFirstResultViewController : UIViewController {
    UILabel *calculatedEMI;
    UILabel *calculatedInterest;
    UILabel *calculatedPayment;
    id obtainedEMI;
    id obtainedPayment;
    id obtainedInterest;
    NSMutableArray *array;
    
}

@property(nonatomic, retain) NSArray *array;

@property (nonatomic, retain) id obtainedEMI;
@property (nonatomic, retain) id obtainedPayment;
@property (nonatomic, retain) id obtainedInterest;

@property (strong, nonatomic) IBOutlet UILabel *calculatedEMI;
@property (strong, nonatomic) IBOutlet UILabel *calculatedInterest;
@property (strong, nonatomic) IBOutlet UILabel *calculatedPayment;

@end
