//
//  TheHelperSecondResultViewController.h
//  The Helper
//
//  Created by qbadmin on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheHelperSecondResultViewController : UIViewController {
    
    UILabel *calculatedTip;
    id infoRequest;
}

@property (strong, nonatomic) IBOutlet UILabel *calculatedTip;
@property (nonatomic, retain) id infoRequest;

@end
